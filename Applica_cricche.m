function Applica_cricche (matrice_cricche)

global mesh_modificata

    for i=1:size(matrice_cricche,1)
       coordx = matrice_cricche(i,1);
       coordy = matrice_cricche(i,2);
       coordz = matrice_cricche(i,3);
       mesh_modificata(coordx,coordy,coordz)=3;
    end

end