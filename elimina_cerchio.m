function [] = elimina_cerchio(riga_cricca,dim_voxel)
% dato una riga della matrice_cricche la funzione elimina i voxel pieni
% nel cerchio concentrico nella cricca con raggio la lunghezza istantanea.

global mesh_iniziale mesh_modificata
dim = size(mesh_modificata);

% fattore di conversione
l_voxel = riga_cricca(1,5)/dim_voxel;
% conversione
i = riga_cricca(1);
% sollecitazione in direzione y

for j = (riga_cricca(1,2)-floor(l_voxel)):(riga_cricca(1,2)+ceil(l_voxel))
    for k = (riga_cricca(1,3)-floor(l_voxel/2)):(riga_cricca(1,3)+ceil(l_voxel/2))
        if j>0 && j<=dim(2) && k>0 && k<=dim(3)
            % per non uscire dalla mesh
            if sqrt((riga_cricca(2)-j)^2+(riga_cricca(3)-k)^2) < l_voxel
                % distanza con pitagora
                mesh_modificata(i,j,k) = 0;
                mesh_iniziale (i,j,k) = 0;
                % elimino voxel pieni
            end
        end
    end
end
                