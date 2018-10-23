
clear all
clc

global mesh_iniziale mesh_modificata sforzi incidenze SF dim_voxel dir_carico andamento_cricche

%% PRIMO GIRO
disp('selezione file .mat contenente la mesh e le informazioni sulle incidenze')
mesh = uigetfile;
load(mesh); %carica la mesh elaborata e compressa dal codice precedente
incidenze = MATRICENOSTRA;
FEM = uigetfile;
disp('selezionare file .dat contenente la FEM relativo alla mesh gi� selezionata')
tab=readtable(FEM); %carica la FEM relativa alla mesh di cui sopra
%%%%%%% la Fem contiene righe in eccesso, si ricorda di ripulire. %%%%%%%
sforzi = table2array(tab); %trasforma la tabella della FEM in matrice
sforzi(:,1) = [];

Cicli_iniziali = 0;

mesh_iniziale = double(matrice_erosa_c); 

% calcolo parametri macro e richiesta informazioni su input FEM e mesh
dati_ingresso = inputdlg({'Direzione applicazione carico (x=1,y=2,z=3)','spostamento applicato (espresso in mm)','Modulo elastico materiale - in GPa','Fattore di compressione (2, 3 o 6)'},...
              'Parametri FEM e MESH'); 
dati_ingresso = str2double(dati_ingresso);
%converte cell in double, altrimenti non si puo' usare la sintassi x(4).
                                                    
dim = size(mesh_iniziale,1);
dir_carico = dati_ingresso(1);
dim_voxel=  0.018*dati_ingresso(4); %dimensione del singolo voxel in millimetri
porosita= 1 - size(incidenze,1)/dim^3; %frazione volumetrica della mesh
E_mat = dati_ingresso(3); %modulo elastico in GPa
sforzi = sforzi*E_mat;
sigma_tot = sum(sforzi(:,dir_carico)); 
sigma_eq =  sigma_tot /dim^3; %sforzo di comparazione con lo sforzo sperimentale in GPa
epsilon = dati_ingresso(2)/(dim*dim_voxel);
E = [Cicli_iniziali abs(sigma_eq/epsilon)];
P = [Cicli_iniziali porosita];
numero_cricche = round(0.033*dim*(dim_voxel*dim)^2) ; %numero cricche da collocare

%Parametri sperimentali
E0 = 2.199; %modulo elastico espresso in GPa
delta_sigma = -0.005*E0; 
epsilon_max = 0.01558; %da letteratura - media delle def max
eq_inter = @(N) 0.230 + 1.015*porosita - 87.4*0.005 - 0.015*E0 + 0.111*log10(N) + 0.247*epsilon_max; %equazione interpolante da letteratura
%calcolo fattore alfa per ridimensionamento stato degli sforzi
alfa = delta_sigma/sigma_eq;

sforzi = sforzi*alfa;

mesh_iniziale=Rotate(mesh_iniziale); %porta le corrette rotazioni della matrice per allineare l'asse di carico con l'asse x 
Sforzi4D; 
mesh_modificata = mesh_iniziale;
Ricerca_bordi;
matrice_cricche = Crea_cricche(numero_cricche);

andamento_cricche = zeros(numero_cricche,10e5);
for i = 1:size(matrice_cricche,1)
    andamento_cricche(i,1) = matrice_cricche(i,4);  
end
% variabile che contiene tutte le lunghezze istantanee, serve per poi
% graficare l'andamento della propagazione.

sforzo_medio_giri = zeros(numero_cricche,20);
% la variabile salva lo sforzo trovato e applicato, ad ogni giro, in Paris.

% etichetta la trabecola con le cricche
k=unique(matrice_cricche(:,1));
k=k';
for i=k
    mat(:,:) = mesh_modificata(i,:,:);
    mesh_modificata(i,:,:) = bwlabel(mat);
end

M0=mesh_modificata; %si salva la matrice etichettata

% calcola lo spessore della trabecola delle cricche e aggiorna matrice_cricche
for i=1:size(matrice_cricche,1)
    
    x = matrice_cricche(i,1);
    y = matrice_cricche(i,2);
    z = matrice_cricche(i,3);
    matrice_cricche(i,6) = dim_voxel*Spessore(matrice_cricche(i,:),mesh_modificata(x,y,z));
    matrice_cricche(i,8) = mesh_modificata(x,y,z);
end

% propagazione cricche

disp('Propagazione cricche')
[matrice_cricche_modificata,Cicli_finali,sforzo_medio] = Paris (matrice_cricche,Cicli_iniziali);
sforzo_medio_giri(:,1) = sforzo_medio; 
clear sforzo_medio;

% eliminazione totale o parziale trabecola
disp('Eliminazione trabecole inattivate')
for i=1:size(matrice_cricche_modificata,1)
    elimina_cerchio(matrice_cricche_modificata(i,:));
end

mesh_iniziale=Reverse(mesh_iniziale); %ritraspone le matrici in modo da ritornare alla configurazione originale prima di rinviare la mesh alla FEM

% if dir_carico==2
%     matrice_cricche_modificata(:,1) = matrice_cricche(:,2);
%     matrice_cricche_modificata(:,2) = matrice_cricche(:,1);
%     
% elseif dir_carico==3
%     matrice_cricche_modificata(:,1) = matrice_cricche(:,3);
%     matrice_cricche_modificata(:,3) = matrice_cricche(:,1);
% end 

% file inp per giro successivo

disp('Eliminazione delle isole della matrice compressa')
CC_c = bwconncomp(mesh_iniziale,6);                                            
numPixel_c = cellfun(@numel, CC_c.PixelIdxList);                    
[biggest_c,idx_2]=max(numPixel_c);                                   
biggest_c = biggest_c-1;                              
mesh_iniziale = bwareaopen(mesh_iniziale, biggest_c, 6); 
mesh_iniziale = double(mesh_iniziale);

disp('Generazione file .inp')
[~,~,~,incidenze]=IncidCoord; 
disp('Pronto per il giro successivo')
Cicli_iniziali=Cicli_finali;
matrice_cricche=matrice_cricche_modificata;

save('mesh.mat','mesh_iniziale','M0','incidenze');
save('info.mat','E','Cicli_iniziali','E_mat','dir_carico','dim_voxel','matrice_cricche','numero_cricche','andamento_cricche','P','sforzo_medio_giri');

%% Optional
andamento = andamento_cricche;
andamento( :, all(~andamento,1) ) = [];
figure
hold
for i = 1:numero_cricche
    plot(1:size(andamento,2),andamento(i,:));
end
xlabel('Numero di cicli');
ylabel('lunghezza cricca[mm]');
clear andamento;
%% Optional 2
andamento = sforzo_medio_giri;
andamento( :, all(~andamento,1) ) = [];
figure
hold
for i = 1:numero_cricche
    plot(andamento(i,:));
end
xlabel('Numero di giri');
ylabel('sforzo in valore assoluto');
clear andamento;

%% GIRI SUCCESSIVI

disp('selezione file .mat contenente la mesh e le informazioni sulle incidenze')
mesh = uigetfile;
load(mesh); %carica la mesh elaborata e compressa dal codice precedente (contiene M0
FEM = uigetfile;
disp('selezionare file .dat contenente la FEM relativo alla mesh gi� selezionata')
tab=readtable(FEM); %carica la FEM relativa alla mesh di cui sopra
%%%%%%% la Fem contiene righe in eccesso, si ricorda di ripulire. %%%%%%%
sforzi = table2array(tab); %trasforma la tabella della FEM in matrice
sforzi(:,1) = [];
disp('selezionare file .mat contenente le informazioni sui giri precedenti')
info = uigetfile; %info deve contenere: Numero cicli, vettore E, dir carico, numero cricche, E_mat, matrice_cricche, fatt_compr, porosit�
load(info);

dlg = inputdlg({'spostamento applicato (espresso in mm)','N_giro'},...
              'Parametri FEM'); 
dlg = str2double(dlg);
%converte cell in double, altrimenti non si puo' usare la sintassi x(4).
     
dim = size(mesh_iniziale,1);
porosita= 1 - size(incidenze,1)/dim^3; %frazione volumetrica della mesh
sforzi = sforzi*E_mat;
sigma_tot = sum(sforzi(:,dir_carico)); 
sigma_eq =  sigma_tot /dim^3; %sforzo di comparazione con lo sforzo sperimentale in GPa
epsilon = dlg(1)/(dim*dim_voxel);
E = [E; Cicli_iniziali abs(sigma_eq/epsilon)];
P = [P; Cicli_iniziali porosita];


%Parametri sperimentali
E0 = 2.199; %modulo elastico espresso in GPa
delta_sigma = -0.005*E0; 
epsilon_max = 0.01558; %da letteratura - media delle def max
eq_inter = @(N) 0.230 + 1.015*porosita - 87.4*0.005 - 0.015*E0 + 0.111*log10(N) + 0.247*epsilon_max; %equazione interpolante da letteratura
%calcolo fattore alfa per ridimensionamento stato degli sforzi
alfa = delta_sigma/sigma_eq;

sforzi = sforzi*alfa;

mesh_iniziale=Rotate(mesh_iniziale); %porta le corrette rotazioni della matrice per allineare l'asse di carico con l'asse x 
Sforzi4D; 
mesh_modificata = mesh_iniziale;

k=unique(matrice_cricche(:,1));
k=k';
for i=k
    for j=1:dim
        for z=1:dim
            if mesh_iniziale(i,j,z) == 1
                mesh_modificata(i,j,z) = M0(i,j,z);
            end
        end
    end
end

[matrice_cricche_modificata,Cicli_finali,sforzo_medio] = Paris (matrice_cricche,Cicli_iniziali);
sforzo_medio_giri(:,dlg(2)) = sforzo_medio; clear sforzo_medio;

for i=1:size(matrice_cricche_modificata,1)
    elimina_cerchio (matrice_cricche_modificata(i,:));
end

mesh_iniziale=Reverse(mesh_iniziale);

disp('Eliminazione delle isole della matrice compressa')
CC_c = bwconncomp(mesh_iniziale,6);                                            
numPixel_c = cellfun(@numel, CC_c.PixelIdxList);                    
[biggest_c,idx_2]=max(numPixel_c);                                   
biggest_c = biggest_c-1;                              
mesh_iniziale = bwareaopen(mesh_iniziale, biggest_c, 6); 
mesh_iniziale = double(mesh_iniziale);

disp('Generazione file .inp')
[~,~,~,incidenze]=IncidCoord; 
disp('Pronto per il giro successivo')
Cicli_iniziali=Cicli_finali;
matrice_cricche=matrice_cricche_modificata;


save('mesh.mat','mesh_iniziale','M0','incidenze');
save('info.mat','E','Cicli_iniziali','E_mat','dir_carico','dim_voxel','matrice_cricche','numero_cricche','andamento_cricche','P','sforzo_medio_giri');

