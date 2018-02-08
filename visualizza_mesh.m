% prima del run assicurarsi che nella cartella ci siano i file k_2_n_64.mat
% e k_2_n_200.mat.
% è consigliato runnare il primo section ogni volta.

clear
clc
global mesh_modificata
%% visualizza la mesh 159*159
load ('k2n318_giro0.mat')
matrice_compressa = double(matrice_erosa_c);
matrice_conversione = matrice_compressa;
mesh_modificata = matrice_conversione;
Ricerca_bordi
for i = 1:159
    for j = 1:159
        for k = 1:159
            if mesh_modificata(i,j,k) == 0
                mesh_modificata(i,j,k) = NaN(1);
            end
        end
    end
end
matrice_modificata_sezionata = NaN(159,159,159);
gridx = (1:159);
gridy = (1:159);
gridz = (1:159);
figure 
v3d200 = PATCH_3Darray(mesh_modificata,gridx,gridy,gridz);
%figure 1 mostra tutta la mesh
matrice_modificata_sezionata(:,:,1:50) = mesh_modificata(:,:,1:50);
cmap = jet(4);
figure
v3d200_sezione = PATCH_3Darray(matrice_modificata_sezionata, gridx, gridy, gridz,'col',cmap);
%figure 2 mostra la mesh sezionata
%% visualizza la mesh 30*30
load ('k_2_n_64.mat')
matrice_conversione = matrice_compressa;
mesh_modificata = matrice_conversione;
Ricerca_bordi
for i = 1:30
    for j = 1:30
        for k = 1:30
            if mesh_modificata(i,j,k) == 0
                mesh_modificata(i,j,k) = NaN;
            end
        end
    end
end
matrice_modificata_sezionata = NaN(30,30,30);
gridx = (1:30);
gridy = (1:30);
gridz = (1:30);
figure 
v3d64 = PATCH_3Darray(mesh_modificata,gridx,gridy,gridz);
matrice_modificata_sezionata(:,1:29,:) = mesh_modificata(:,1:29,:);
cmap = [1 1 0; 0 0 1];
figure
v3d64_sezione = PATCH_3Darray(matrice_modificata_sezionata, gridx, gridy, gridz,'col',cmap);
cmap = [1 1 0; 0 0 1;1 0 1];
matrice_modificata_sezionata(14,29,5) = 3;
figure
v3d64_sezione_cricca = PATCH_3Darray(matrice_modificata_sezionata,gridx,gridy,gridz,'col',cmap);
% matrice_modificata_sezionata = NaN(30,30,30);
% matrice_modificata_sezionata(:,29,:) = matrice_modificata(:,29,:);
% matrice_modificata_sezionata(14,29,5) = 3;
% matrice_modificata_sezionata(18,29,4:6) = NaN;
% matrice_modificata_sezionata(17,29,2:8) = NaN;
% matrice_modificata_sezionata(16,29,2:8) = NaN;
% matrice_modificata_sezionata(15,29,1:10) = NaN;
% matrice_modificata_sezionata(14,29,2:8) = NaN;
% matrice_modificata_sezionata(13,29,2:8) = NaN;
% matrice_modificata_sezionata(12,29,2:8) = NaN;
% matrice_modificata_sezionata(11,29,2:8) = NaN;
% matrice_modificata_sezionata(10,29,6) = 3;
% matrice_modificata_sezionata(17,29,9) = 2;
% matrice_modificata_sezionata(18,29,8) = 2;
% matrice_modificata_sezionata(18,29,7) = 3;
% matrice_modificata_sezionata(18,29,2:3) = 2;
% matrice_modificata_sezionata(19,29,4) = 2;
% figure
% v3d64_sezione_cricca = PATCH_3Darray(matrice_modificata_sezionata,gridx,gridy,gridz,'col',cmap);

