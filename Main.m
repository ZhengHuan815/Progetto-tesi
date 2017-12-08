
clear
clc
%%          
global mesh_iniziale mesh_modificata sforzi incidenze SF
dim_voxel=  0.032; %dimensione del singolo voxel in micrometri
%% PRIMO GIRO

load('k_2_n_64.mat'); %carica la mesh elaborata e compressa dal codice precedente
incidenze = MATRICENOSTRA;
tab=readtable('k2n64_pulito.dat'); %carica la FEM relativa alla mesh di cui sopra
%%%%%%% la Fem contiene righe in eccesso, si ricorda di ripulire. %%%%%%%
sforzi = table2array(tab); %trasforma la tabella della FEM in matrice
sforzi(:,1) = [];
Sforzi4D;

numero_cricche = 5; %numero cricche da collocare
Cicli_iniziali = 0;

mesh_iniziale = double(matrice_erosa_c); 
Rotate(3);
mesh_modificata = mesh_iniziale;
Ricerca_bordi();
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
    elimina_cerchio (matrice_cricche_modificata(i,:),dim_voxel);
end
% mat=mesh_iniziale;
% save('giro1.mat','mat','matrice_cricche_modificata','Cicli_finali','incidenze');

%% file inp per giro successivo
IncidCoord;

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

