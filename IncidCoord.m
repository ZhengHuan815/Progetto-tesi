function [incidenze,coordinate,nset_sup,centroidi] = IncidCoord


global mesh_iniziale

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%IncidCoord ha bisogno di un reverse rotate?%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dim_voxel = 0.032;

x_max = size(mesh_iniziale,1);
y_max = size(mesh_iniziale,2);
z_max = size(mesh_iniziale,3);

h = waitbar(0,'Please wait..');

N_pixel_x = x_max;                                                  
N_pixel_y = y_max;
N_pixel_z = z_max;
% Numero voxel lungo le tre direzioni

nset_sup=struct('x_meno',[],'y_meno',[],'z_meno',[],'x_piu',[],'y_piu',[], 'z_piu',[]);  
% Liste inizializzate dei nodi di superficie

cont=0;                                                                     
% Inizializzazione dei contatori

NodiLayer = (N_pixel_x+1)*(N_pixel_y+1);                                    
% Numero dei nodi totali in un layer

N_vox = nnz(mesh_iniziale);
incidenze=zeros(N_vox,9);                                                     
coordinate=zeros((N_vox*8),4); 
centroidi=zeros(N_vox,3);
% Inizializzazione delle tabelle

for L=1:N_pixel_z
    waitbar(L/N_pixel_z,h,sprintf('Step:%d',L))                             
    for j=1:N_pixel_y
        for i=1:N_pixel_x       
            
            if mesh_iniziale(i,j,L)==1                                            
                % Se il voxel e' pieno
                
                cont=cont+1;                                                         % Conta il numero degli elementi finiti (voxel PIENI)
                centroidi(n,:) = [i,j,L];                                                   
                % Conta il numero dei voxel pieni
               
                nodoA=NodiLayer*(L-1)+(N_pixel_x+1)*(j-1)+(i+1);
                nodoB=nodoA+(N_pixel_x+1);
                nodoC=nodoB-1;
                nodoD=nodoA-1;
                nodoE=nodoA+NodiLayer;
                nodoF=nodoB+NodiLayer;
                nodoG=nodoC+NodiLayer;
                nodoH=nodoD+NodiLayer;
                incidenze(cont,:)=[cont,nodoA,nodoB,nodoC,nodoD,nodoE,nodoF,nodoG,nodoH];
                % Trova i numeri assoluti dei nodi di questo EF e riempie 
                % la riga della tabella delle incidenze.
                
                xnA = dim_voxel*(i-1)+dim_voxel/2;
                xnB=xnA;
                xnE=xnA;
                xnF=xnA;
                xnC = dim_voxel*(i-1)-dim_voxel/2;      
                xnD=xnC; 
                xnG=xnC;
                xnH=xnC;
                
                ynA = dim_voxel*(j-1)-dim_voxel/2;         
                ynD=ynA;
                ynE=ynA;
                ynH=ynA;
                ynB = dim_voxel*(j-1)+dim_voxel/2;  
                ynC=ynB; 
                ynF=ynB; 
                ynG=ynB;
                
                znA = dim_voxel*(L-1)-dim_voxel/2; 
                znB=znA;
                znC=znA;
                znD=znA;
                znE = dim_voxel*(L-1)+dim_voxel/2; 
                znF=znE;
                znG=znE;
                znH=znE;
                
                coordinate(1+(cont-1)*8,1:4) = [nodoA,xnA,ynA,znA];
                coordinate(2+(cont-1)*8,1:4) = [nodoB,xnB,ynB,znB];
                coordinate(3+(cont-1)*8,1:4) = [nodoC,xnC,ynC,znC];
                coordinate(4+(cont-1)*8,1:4) = [nodoD,xnD,ynD,znD];
                coordinate(5+(cont-1)*8,1:4) = [nodoE,xnE,ynE,znE];
                coordinate(6+(cont-1)*8,1:4) = [nodoF,xnF,ynF,znF];
                coordinate(7+(cont-1)*8,1:4) = [nodoG,xnG,ynG,znG];
                coordinate(8+(cont-1)*8,1:4) = [nodoH,xnH,ynH,znH];
                % Trova le coordinate nel SDR della mesh dei nodi dell'EF, 
                % e riempie la tabella delle coordinate
                
            end
        end
    end
end

incidenze=unique(incidenze,'rows');% Vogliamo che la tabella sia anche ordinata, ma unique oltre che scartare i doppi ordina!
centroidi = unique(centroidi,'rows');
coordinate = unique(coordinate,'rows');
% Scartiamo le righe vuote, i doppi e ordiniamo le tabelle per numero di 
% nodo/elemento finito.
% Vogliamo che la tabella sia anche ordinata, ma unique oltre che scartare 
% i doppi ordina!
% Riesce a eliminare gli zeri ma non i nodi doppi (?)
% Per risolvere artigianalmente il problema: [Ora coordinate contiene 
% le righe gia' in ordine crescente, seppure con doppie]
[~, righe_uniche, ~] = unique(coordinate(:, 1)); 
% ~ per gli output che non servono 

coordinate = coordinate(righe_uniche, :);  
% Sostituisce a coordinate solo la matrice con le righe date dal vettore righe_uniche 
 
posizioni1=find(coordinate(:,2) == -dim_voxel/2);                                    
posizioni2=find(coordinate(:,3) == -dim_voxel/2);
posizioni3=find(coordinate(:,4) == -dim_voxel/2);
posizioni4=find(coordinate(:,2) == (dim_voxel*(x_max-1))+dim_voxel/2);
posizioni5=find(coordinate(:,3) == (dim_voxel*(y_max-1))+dim_voxel/2);
posizioni6=find(coordinate(:,4) == (dim_voxel*(y_max-1))+dim_voxel/2);
% Trova i nodi appartenenti alle 6 facce 
% Estrae i numeri di riga di coordinate i cui nodi hanno una coordinata 
% estrema

% Riempimento delle liste assegnando alle righe il corrispondente numero di nodo (colonna 1 di coordinate)
nset_sup.x_meno=coordinate(posizioni1,1);
nset_sup.y_meno=coordinate(posizioni2,1);
nset_sup.z_meno=coordinate(posizioni3,1);
nset_sup.x_piu=coordinate(posizioni4,1);
nset_sup.y_piu=coordinate(posizioni5,1);
nset_sup.z_piu=coordinate(posizioni6,1);

close(h)  %chiude la waitbar

disp('Scrittura del file .inp')
createf=fopen(['descrittori_Bovine_comp_', 'k_', num2str(2), '.inp'],'w+');
stampa(createf,coordinate,incidenze,nset_sup);
fclose(createf);

end