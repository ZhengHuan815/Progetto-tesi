function elimina_cerchio(riga_cricca)
% dato una riga della matrice_cricche la funzione elimina i voxel pieni
% nel cerchio concentrico nella cricca con raggio la lunghezza istantanea.

global mesh_iniziale mesh_modificata
dim = size(mesh_iniziale);
a = 0.032;
% fattore di conversione
l_voxel = riga_cricca(5)/a;
% conversione
xc = riga_cricca(1);

for j = (riga_cricca(2)-floor(l_voxel)):(riga_cricca(2)+ceil(l_voxel))
    for k = (riga_cricca(3)-floor(l_voxel/2)):(riga_cricca(3)+ceil(l_voxel/2))
        if j>0 && j<dim(1) && k>0 && k<dim(3) 
            % per non uscire dalla mesh
            if sqrt((riga_cricca(1)-j)^2+(riga_cricca(3)-k)^2) <= l_voxel && ...
                    mesh_modificata(xc,riga_cricca(2),riga_cricca(3)) == mesh_modificata(xc,j,k)
        
                % distanza con pitagora e condizione che verifica che il
                % punto in analisi appartenga alla trabecola della cricca
                mesh_iniziale (xc,j,k) = 0;
                % elimino voxel pieni
            end
        end
    end
end
                