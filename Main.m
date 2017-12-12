
clear
clc

global mesh_iniziale mesh_modificata sforzi incidenze SF dim_voxel

%% PRIMO GIRO

load('k_2_n_64.mat'); %carica la mesh elaborata e compressa dal codice precedente
incidenze = MATRICENOSTRA;
tab=readtable('k2n64_pulito.dat'); %carica la FEM relativa alla mesh di cui sopra
%%%%%%% la Fem contiene righe in eccesso, si ricorda di ripulire. %%%%%%%
sforzi = table2array(tab); %trasforma la tabella della FEM in matrice
sforzi(:,1) = [];


numero_cricche = 5; %numero cricche da collocare
Cicli_iniziali = 0;

mesh_iniziale = double(matrice_erosa_c); 


%% calcolo parametri macro e richiesta informazioni su input FEM e mesh
dati_ingresso = inputdlg({'Direzione applicazione carico (x=1,y=2,z=3)','spostamento applicato (espresso in voxel)','Modulo elastico materiale - in GPa','Fattore di compressione (2, 3 o 6)'},...
              'Parametri FEM e MESH'); 
dati_ingresso = str2double(dati_ingresso);
%converte cell in double, altrimenti non si puo' usare la sintassi x(4).
                                                    
dim = size(mesh_iniziale,1);
dim_voxel=  0.018*dati_ingresso(4); %dimensione del singolo voxel in millimetri
porosita=size(incidenze,1)/dim^3; %frazione volumetrica della mesh
E_mat = dati_ingresso(3); %modulo elastico in GPa
sigma_tot = sum(sforzi(:,2))*E_mat*10^3; 
sigma_sp =  sigma_tot * porosita; %sforzo di comparazione con lo sforzo sperimentale
epsilon = dati_ingresso(2)/dim;
E = [Cicli_iniziali sigma_sp/epsilon]; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% dà errore, è da modificare quando utilizzeremo dati sperimentali.%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Rotate(dati_ingresso(1)); %porta le corrette rotazioni della matrice per allineare l'asse di carico con l'asse x 
Sforzi4D(dati_ingresso(1)); 
mesh_modificata = mesh_iniziale;
Ricerca_bordi;
matrice_cricche = Crea_cricche(numero_cricche);


%% etichetta la trabecola con li cricche
k=unique(matrice_cricche(:,1));
k=k';
for i=k
    mat(:,:) = mesh_modificata(i,:,:);
    mesh_modificata(i,:,:) = bwlabel(mat);
end

%% calcola lo spessore della trabecola delle cricche e aggiorna matrice_cricche
for i=1:size(matrice_cricche,1)
    
    x = matrice_cricche(i,1);
    y = matrice_cricche(i,2);
    z = matrice_cricche(i,3);
    matrice_cricche(i,6) = dim_voxel*Spessore(matrice_cricche(i,:),mesh_modificata(x,y,z));
end

%% propagazione cricche
[matrice_cricche_modificata,Cicli_finali] = Paris (matrice_cricche,Cicli_iniziali);

%% eliminazione totale o parziale trabecola
for i=1:size(matrice_cricche_modificata,1)
    elimina_cerchio (matrice_cricche_modificata(i,:));
end

%%
Rotate(dati_ingresso(1)); %ritraspone le matrici in modo da ritornare alla configurazione originale prima di rinviare la mesh alla FEM

% save('giro1.mat','mesh_iniziale','matrice_cricche_modificata','Cicli_finali','incidenze');

%% file inp per giro successivo
[,,,centroidi]=IncidCoord; %%dove vengono salvati i file?

%% GIRI SUCCESSIVI
clear variables;
dim_voxel=  0.032;
load('giro1.mat');
tab=readtable('k2n64.dat'); %carica la FEM relativa alla mesh di cui sopra
sforzi = table2array(tab); %trasforma la tabella della FEM in matrice
sforzi(:,1) = [];

mesh_iniziale = mat; 
mesh_modificata = Ricerca_bordi(mesh_iniziale);
matrice_cricche = matrice_cricche_modificata;
Cicli_iniziali=Cicli_finali;
Applica_cricche(matrice_cricche);


k=unique(matrice_cricche(:,1));
k=k';
for i=k
    mt(:,:) = mesh_modificata(i,:,:);
    mesh_modificata(i,:,:) = bwlabel(mt);
end

for i=1:size(matrice_cricche,1)
    
    x = matrice_cricche(i,1);
    y = matrice_cricche(i,2);
    z = matrice_cricche(i,3);
    matrice_cricche(i,6) = dim_voxel*Spessore(matrice_cricche(i,:),mesh_modificata(x,y,z));
end


[matrice_cricche_modificata,Cicli_finali] = Paris (matrice_cricche,Cicli_iniziali);

for i=1:size(matrice_cricche_modificata,1)
    elimina_cerchio (matrice_cricche_modificata(i,:),dim_voxel);
end
mat=mesh_iniziale;
save('giro2.mat','mat','matrice_cricche_modificata','Cicli_finali','incidenze');

