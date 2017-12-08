function Ricerca_bordi
% Trova e identifica i voxel di contorno della mesh
global mesh_modificata 

%Calcolo le dimensioni della matrice
[x,y,z]=size(mesh_modificata);

for k=1:x
    for j=1:y
        for i=1:z
            
            if(mesh_modificata(i,j,k)==1)
                %Evito controllo se la mesh � finita
                if(i<x)
                    if(mesh_modificata(i+1,j,k)==0)
                        mesh_modificata(i,j,k)=2;
                    end
                end
                if(i>1)
                    if(mesh_modificata(i-1,j,k)==0)
                        mesh_modificata(i,j,k)=2;
                    end
                end
                if(j<y)
                    if(mesh_modificata(i,j+1,k)==0)
                        mesh_modificata(i,j,k)=2;
                    end
                end
                if(j>1)
                    if(mesh_modificata(i,j-1,k)==0)
                        mesh_modificata(i,j,k)=2;
                    end
                end
                if(k<z)
                    if(mesh_modificata(i,j,k+1)==0)
                        mesh_modificata(i,j,k)=2;
                    end
                end
                if(k>1)
                    if(mesh_modificata(i,j,k-1)==0)
                        mesh_modificata(i,j,k)=2;
                    end
                end
            end
        end
    end
end
              
        

        