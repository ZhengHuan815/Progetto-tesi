function elimina_cerchio(riga_cricca)
% dato una riga della matrice_cricche la funzione elimina i voxel pieni
% nel cerchio concentrico nella cricca con raggio la lunghezza istantanea.

global mesh_iniziale mesh_modificata
dim = size(mesh_modificata);
a = 0.032;
% fattore di conversione
l_voxel = riga_cricca(1,5)/a;
% conversione
j = riga_cricca(2);
% sollecitazione in direzione y

for i = (riga_cricca(1,1)-floor(l_voxel)):(riga_cricca(1,1)+ceil(l_voxel))
    for k = (riga_cricca(1,3)-floor(l_voxel/2)):(riga_cricca(1,3)+ceil(l_voxel/2))
        if i>0 && i<dim(1) && k>0 && k<dim(3)
            % per non uscire dalla mesh
            if sqrt((riga_cricca(1)-i)^2+(riga_cricca(3)-k)^2) < l_voxel
                % distanza con pitagora
                mesh_modificata(i,j,k) = 0;
                mesh_iniziale (i,j,k) = 0;
                % elimino voxel pieni
            end
        end
    end
end
                