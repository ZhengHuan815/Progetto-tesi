function Evidenzia_perimetro(riga_della_cricca,numero_della_cricca) 
%evidenzia_perimetro : funzione evidenzia nella mesh_contorno il perimetro
%                      e l'interno della trabecola affetta da cricca.

%input : riga_della_cricca (vettore riga contenente informazioni sulla cricca)
%        numero_della cricca (identifica la cricca e quindi la trabecola su
%                             si vuole trovare il merimetro)

%output : mesh_modificata (sovrascritta)

global mesh_modificata

coordinata = riga_della_cricca(1:3);
x = coordinata(1);

max_y = coordinata(2);
min_y = coordinata(2);
max_z = coordinata(3);
min_z = coordinata(3);
%servono alla fine per evidenziare i voxel interni.
a = 0;
b = 1;
while b == 1 %finchè non torna alla mesh iniziale percorrendo una forma chiusa
    for y = coordinata(2)-1:coordinata(2)+1
        for z = coordinata(3)-1:coordinata(3)+1
            %   si analizza i 8 voxel adiacenti alla cricca, quando ne trova uno di
            %   numero 2, salva le sue coordinate ed esce direttamente dai for.
            
            c = [y,z];
            angolo_1 = [coordinata(2)-1,coordinata(3)-1];
            angolo_2 = [coordinata(2)+1,coordinata(3)+1];
            angolo_3 = [coordinata(2)+1,coordinata(3)-1];
            angolo_4 = [coordinata(2)-1,coordinata(3)+1];
            %voglio controllare prima i voxel adiacenti per lato
        
            if mesh_modificata(x,y,z) == 2  
                if (c == angolo_1) | (c == angolo_2) | (c == angolo_3) | (c == angolo_4)
                    a = 2;
                    %se è un voxel 2 di angolo, lo salvo temporaneamente,
                    %lo considero solo se sono sicuro che non ci siano
                    %altri voxel adiacenti.
                    d = [y,z];
                else
                    coordinata = [x,y,z];
                    mesh_modificata(x,y,z) = (numero_della_cricca+1)*2;
                
                    %se è la cricca numero 1, il perimetro della trabecola è 4
                    %se è la cricca numero 2, il perimetro della trabecola è 6
                    % e cosi via.
                
                    if max_y < coordinata(2)
                    max_y = coordinata(2);
                    end
                
                    if min_y > coordinata(2)
                    min_y = coordinata(2);
                    end
                
                    if max_z < coordinata(3)
                    max_z = coordinata(3);
                    end
                
                    if min_z > coordinata(3)
                    min_z = coordinata(3);
                    end
                    a = 1;
                    break
                end
            end
            
            if y == coordinata(2)+1 && z == coordinata(3)+1 &&  a == 2
                
                coordinata = [x,d(1),d(2)];                
                mesh_modificata(x,d(1),d(2)) = (numero_della_cricca+1)*2;

                if max_y < coordinata(2)
                    max_y = coordinata(2);
                end
                
                if min_y > coordinata(2)
                    min_y = coordinata(2);
                end
                
                if max_z < coordinata(3)
                    max_z = coordinata(3);
                end
                
                if min_z > coordinata(3)
                    min_z = coordinata(3);
                end
                
                break
                
            elseif y == coordinata(2)+1 && z == coordinata(3)+1 &&  a == 0
                b = 0;
            end
        end
        if a == 1
            a = 0;
            break
        end           
    end
end
%   finchè non ritorna al voxel della cricca continua la ricerca di un
%   voxel di frontiera adiacente, ne salva le coordinate e fa un'altra
%   ricerca in vicinanza del nuovo voxel.
    
sono_tra_2_voxel_di_perimetro = 0;
%   scorrendo il rettangolo evidenzio solo i voxel compresi tra 2 voxel di
%   perimetro, se questa variabile == 0 vuol dire che sono fuori e
%   viceversa.

for j = min_y:max_y
    for k = min_z:max_z
        if sono_tra_2_voxel_di_perimetro == 0 && (mesh_modificata(x,j,k) == (numero_della_cricca+1)*2 || mesh_modificata(x,j,k) == 3)
            sono_tra_2_voxel_di_perimetro = 1;
            a = 1;
        end
        if a == 0 && sono_tra_2_voxel_di_perimetro == 1 && (mesh_modificata(x,j,k) == (numero_della_cricca+1)*2 || mesh_modificata(x,j,k) == 3)
            sono_tra_2_voxel_di_perimetro = 0;
        end
        %on/off quando incontro un voxel di perimetro, se era 0 diventa 1 e
        %se era 1 diventa 0.
        
        if sono_tra_2_voxel_di_perimetro == 1 && mesh_modificata(x,j,k) == 1
            mesh_modificata(x,j,k) = (numero_della_cricca+1)*2+1;
            a = 0;
        end
        %se la variabile è 1, cioè siamo in una zona tra 2 voxel di
        %perimetro nominiamo il voxel di interesse con
        %(numero_della_cricca+1)*2+1
    end
end