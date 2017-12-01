
global matrice_compressa matrice_modificata
%% visualizza la mesh 30*30
load ('k_2_n_64.mat')
matrice_conversione = matrice_compressa;
matrice_modificata = matrice_conversione;
Ricerca_bordi
for i = 1:30
    for j = 1:30
        for k = 1:30
            if matrice_modificata(i,j,k) == 0
                matrice_modificata(i,j,k) = NaN;
            end
        end
    end
end
matrice_modificata_sezionata = NaN(30,30,30);
gridx = (1:30);
gridy = (1:30);
gridz = (1:30);
figure 
v3d64 = PATCH_3Darray(matrice_modificata,gridx,gridy,gridz);
matrice_modificata_sezionata(:,1:29,:) = matrice_modificata(:,1:29,:);
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
%% visualizza la mesh 99*99
load ('k_2_n_200.mat')

matrice_conversione = matrice_compressa;
matrice_modificata = matrice_conversione;
Ricerca_bordi
for i = 1:99
    for j = 1:99
        for k = 1:99
            if matrice_modificata(i,j,k) == 0
                matrice_modificata(i,j,k) = NaN(1);
            end
        end
    end
end
matrice_modificata_sezionata = NaN(99,99,99);
gridx = (1:99);
gridy = (1:99);
gridz = (1:99);
figure 
v3d200 = PATCH_3Darray(matrice_modificata,gridx,gridy,gridz);

matrice_modificata_sezionata(:,:,1:50) = matrice_modificata(:,:,1:50);
cmap = jet(4);
figure
v3d200_sezione = PATCH_3Darray(matrice_modificata_sezionata, gridx, gridy, gridz,'col',cmap);

end
