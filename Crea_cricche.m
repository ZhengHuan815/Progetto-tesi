function [ matrice_cricche ] = Crea_cricche( n_cricche )

global mesh_modificata

%Crea_cricche Seleziona casualmente dei voxel tra gli elementi di contorno 
%             della mesh, assegna una lunghezza iniziale a ciascun elemento 
%             (sottofunzione Assegna_lunghezza) e stabilisce lo spessore 
%             minimo della trabecola nell'intorno dell'elemento
%             (sottofunzione Spessore_trabecola).
%             
%             
%             
%   Input: mesh_contorno è la mesh con i contorni evidenziati
%          n_cricche è il numero di elementi di contorno da estrarre
%          casualmente dalla mesh
%
%   Output: una matrice n_cricche x 6 dove così strutturata
%
%             coord x   coord y   coord z   lunghezza iniziale   lunghezza istantanea     spessore trabecola   stato trabecola
%  cricca 1
%  cricca 2
%  ...
%  cricca n

i=1;
n=0;
dim_mesh= size(mesh_modificata);
nmax=dim_mesh(1)*dim_mesh(2)*dim_mesh(3);
matrice_cricche=zeros(n_cricche-1,7);

while i < n_cricche && n < nmax
    
    x = randi(dim_mesh(1),1); 
    y = randi(dim_mesh(2),1);
    z = randi(dim_mesh(3),1);
    
    if mesh_modificata(x,y,z) == 2
        
        l_0 = genera_lunghezze_iniziali;
        matrice_cricche(i,:) = [x y z l_0 l_0 0 0];
        mesh_modificata(x,y,z) = 3;
        i = i + 1;
        
    end
    
    n=n+1;
    
end


end

