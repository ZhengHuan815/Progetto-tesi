
global mesh_iniziale mesh_modificata 
dim_voxel=  0.032; %dimensione del singolo voxel in micrometri

%% PRIMO GIRO

load('mesh.mat'); %carica la mesh elaborata e compressa dal codice precedente
%tab=readtable(); %carica la FEM relativa alla mesh di cui sopra
%Sforzi = table2cell(tab); %trasforma la tabella della FEM in matrice



numero_cricche = 10000; %numero cricche da collocare
Cicli_iniziali = 0;

mesh_iniziale = matrice_compressa; 
mesh_modificata = Ricerca_bordi(mesh_iniziale);
matrice_cricche = Crea_cricche(numero_cricche);
a(:,:) = mesh_modificata(8,:,:);
figure; imagesc(a)

for i=1:size(matrice_cricche,1)
    
    x = matrice_cricche(i,1);
    y = matrice_cricche(i,2);
    z = matrice_cricche(i,3);
    mat(:,:) = mesh_modificata(x,:,:);
    mesh_modificata(x,:,:) = bwlabel(mat);
    matrice_cricche(i,6) = dim_voxel*Spessore(matrice_cricche(i,:),mesh_modificata(x,y,z));
end

[matrice_cricche_modificata,Cicli_finali,numero_cricca] = Paris (matrice_cricche,Cicli_iniziali);

for i=1:size(matrice_cricche_modificata,1)
    matrice_cricche_modificata(i,:) = Eliminazione_cerchio (matrice_cricche_modificata(i,:),i);
end
mat=mesh_iniziale;
save('giro1.mat','mat','matrice_cricche_modificata','Cicli_finali');

%% GIRI SUCCESSIVI

load('giro1.mat');
mesh_iniziale = mat; 
mesh_modificata = ricercabordi(mesh_iniziale);
matrice_cricche = matrice_cricche_modificata;
Cicli_iniziali=Cicli_finali;
Applica_cricche(matrice_cricche);


for i=1:dim(matrice_cricche,1)
    evidenzia_perimetro(matrice_cricche(i,:),i);
    matrice_cricche(i,6) = dim_voxel*Spessore(matrice_cricche(i,:),i);
end

[matrice_cricche_modificata,Cicli_finali,numero_cricca] = Paris (matrice_cricche,Cicli_iniziali);

for i=1:size(matrice_cricche_modificata,1)
    matrice_cricche_modificata(i,:) = Eliminazione_cerchio (matrice_cricche_modificata(i,:),i);
end
