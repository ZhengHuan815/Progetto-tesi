function elimina_cerchio(riga_cricca)

% dato una riga della matrice_cricche la funzione elimina i voxel pieni
% nel cerchio concentrico nella cricca con raggio la lunghezza istantanea.

global mesh_iniziale mesh_modificata dim_voxel

dim = size(mesh_iniziale);

l_voxel = riga_cricca(5)/dim_voxel;
% conversione
xc = riga_cricca(1);

for j = floor(riga_cricca(2)-(l_voxel)):ceil(riga_cricca(2)+(l_voxel))
    for k = floor(riga_cricca(3)-(l_voxel/2)):ceil(riga_cricca(3)+(l_voxel/2))
        if j>0 && j<=dim(2) && k>0 && k<=dim(3) 
            % per non uscire dalla mesh
            if hypot((riga_cricca(2)-j),(riga_cricca(3)-k)) <= l_voxel && ...
                    mesh_modificata(xc,riga_cricca(2),riga_cricca(3)) == mesh_modificata(xc,j,k)
        
                % distanza con pitagora e condizione che verifica che il
                % punto in analisi appartenga alla trabecola della cricca
                mesh_iniziale (xc,j,k) = 0;
                % elimino voxel pieni
            end
        end
    end
end
                