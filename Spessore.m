function [ i ] = Spessore( riga_cricca,numero_cricca )
% Calcola lo spessore massimo di una forma a partire da un punto P
% appartenente al contorno della figura come il raggio minimo della circonferenza di
% centro P che inscrive la forma.
% Input: riga_cricca fornisce le informazioni della cricca - centro 
%        numero_cricca fornisce l'ID della trabecola
% Output: spessore espresso in unità intere [voxel]
% la funzione è basata sull'algoritmo di Brasenham per la circonferenza
% ! utilizza variabili globali per verifica condizioni ma non le modifica

global mesh_modificata


dim = size(mesh_modificata,1); %mesh quadrata - 1 sola dimensione
xc = riga_cricca(1); %fissato. La funzione si muove sul piano y-z
yc = riga_cricca(2); %coordinate del centro
zc = riga_cricca(3);
ID_trabecola=numero_cricca; %scelta progettuale - identifica univocamente la trabecola
R_max = max([yc zc dim-yc dim-zc]); %scelta di una condizione di terminazione
                                    %per evitare cicli infiniti



for i=1:R_max 
    
    logical=1; %flag di appoggio per l'uscita dal secondo ciclo
    
    % definisce la funzione di controllo (circonferenza 2-D)
    f = @(y,z) (y).^2 + (z).^2 - i.^2;

    %identifico come punto di partenza non approssimato l'estremo
    %superiore della circonferenza
    dy = i;
    dz = 0;

    while dz<=dy %scorre i punti della circonferenza del primo ottante superiore
    
            %tutti gli if esprimono la stessa condizione sfruttando le 8
            %simmetrie della circonferenza: rispetto agli assi e rispetto
            %alle bisettrici.
            %le condizioni iniziali servono a evitare che il controllo su
            %mesh_modificata avvenga per valori non compresi tra le sue
            %dimensioni massima e minima.
            %è sufficiente che un solo punto della circonferenza appartenga alla trabecola 
            %per uscire dal while e incrementare il raggio di analisi
        
            if  yc+dy>=1 && yc+dy<=dim && zc+dz>=1 && zc+dz<=dim && (mesh_modificata(xc,yc+dy,zc+dz) == ID_trabecola) % || mesh_modificata(xc,yc+dy,zc+dz) == ID_trabecola+1)
                logical=0;
                break
            end
            
            if  yc+dz>=1 && yc+dz<=dim && zc+dy>=1 && zc+dy<=dim && (mesh_modificata(xc,yc+dz,zc+dy) == ID_trabecola) % || mesh_modificata(xc,yc+dz,zc+dy) == ID_trabecola+1)
                logical=0;
                break
            end
            
            if  yc-dy>=1 && yc-dy<=dim && zc+dz>=1 && zc+dz<=dim && (mesh_modificata(xc,yc-dy,zc+dz) == ID_trabecola) % || mesh_modificata(xc,yc-dy,zc+dz) == ID_trabecola+1)
                logical=0;
                break
            end
            
            if  yc-dz>=1 && yc-dz<=dim && zc+dy>=1 && zc+dy<=dim && (mesh_modificata(xc,yc-dz,zc+dy) == ID_trabecola) % || mesh_modificata(xc,yc-dz,zc+dy) == ID_trabecola+1)
                logical=0;
                break
            end
            
            if  yc-dy>=1 && yc-dy<=dim && zc-dz>=1 && zc-dz<=dim && (mesh_modificata(xc,yc-dy,zc-dz) == ID_trabecola) % || mesh_modificata(xc,yc-dy,zc-dz) == ID_trabecola+1)
                logical=0;
                break
            end
            
            if  yc-dz>=1 && yc-dz<=dim && zc-dy>=1 && zc-dy<=dim && (mesh_modificata(xc,yc-dz,zc-dy) == ID_trabecola) % || mesh_modificata(xc,yc-dz,zc-dy) == ID_trabecola+1)
                logical=0;
                break
            end
            
            if  yc+dy>=1 && yc+dy<=dim && zc-dz>=1 && zc-dz<=dim && (mesh_modificata(xc,yc+dy,zc-dz) == ID_trabecola) % || mesh_modificata(xc,yc+dy,zc-dz) == ID_trabecola+1)
                logical=0;
%                 mesh_modificata(xc,yc+dy,zc-dz)=125;
                break
            end
            
            if  yc+dz>=1 && yc+dz<=dim && zc-dy>=1 && zc-dy<=dim && (mesh_modificata(xc,yc+dz,zc-dy) == ID_trabecola) %  || mesh_modificata(xc,yc+dz,zc-dy) == ID_trabecola+1)
                logical=0;
                break
            end
                     
        dz = dz + 1;
        d= f(dz, dy - 1/2);

        if d>0 
            dy = dy - 1;
        elseif d==0
            dy = dy - (randi(2,1)-1);
        end
                
    
    end
    %se logical è rimasto uno significa che il while ha scorso tutta la
    %circonferenza senza incontrare punti appartenenti alla trabecola.
    %di conseguenza il raggio è quello cercato e si esce dal for,
    %terminando la funzione.
    if logical==1
        break
    end
    
end

end