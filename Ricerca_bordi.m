function [mat]=Ricerca_bordi(mat)

%Calcolo le dimensioni della matrice
[x,y,z]=size(mat);

%Faccio scorrere i vari elementi della matrice con ciclo for
for k=1:x
    for j=1:y
        for i=1:z
            %Controllo che il voxel sia un 1 altrimenti non mi interessa
            %vedere se è un bordo
            if(mat(i,j,k)==1)
                %Evito controllo se la mesh è finita
                if(i<x)
                    if(mat(i+1,j,k)==0)
                        mat(i,j,k)=2;
                    end
                end
                if(i>1)
                    if(mat(i-1,j,k)==0)
                        mat(i,j,k)=2;
                    end
                end
                 if(j<y)
                    if(mat(i,j+1,k)==0)
                        mat(i,j,k)=2;
                    end
                 end
                 if(j>1)
                    if(mat(i,j-1,k)==0)
                        mat(i,j,k)=2;
                    end
                 end
                 if(k<z)
                    if(mat(i,j,k+1)==0)
                        mat(i,j,k)=2;
                    end
                 end
                 if(k>1)
                    if(mat(i,j,k-1)==0)
                        mat(i,j,k)=2;
                    end
                 end
            end
        end
    end
end
              
        

        