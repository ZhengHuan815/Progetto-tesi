function [riga_cricche]=Eliminazione_cerchio(riga_cricche)

global mesh_iniziale mesh_modificata

%   Input: sezione_mesh è la sezione orizzontale di interesse 
%          coordinate_centro sono le coordinate ESATTE del centro del
%          cerchio che si desidera approssimare
%          R è il raggio del cerchio espresso in unità di misura "Voxel" -
%          intero maggiore di 0
%          ID_trabecola è il numero che identifica univocamente la
%          trabecola in analisi
%   Output: sezione_mesh_inattivata è la sezione orizzontale di interesse
%   da cui sono stati eliminati i voxel nella circonferenza

dim=size(mesh_iniziale,1);
xc=riga_cricche(1);
yc=riga_cricche(2);
zc=riga_cricche(3);
R= round(riga_cricche(5)/0.032);
ID_trabecola=mesh_modificata(xc,yc,zc);
% a partire dal centro approssimo tutte le circonferenze di raggio compreso
% tra il centro e R
for i=0:R
% definisce la funzione di controllo
f=@(y,z) (y).^2 + (z).^2 - i.^2;
%identifico come punto di partenza non approssimato l'estremo
%superiore della circonferenza
dy=i;
dz=0;

    while dz<=dy

            if  (yc+dy>=1 && yc+dy<=dim && zc+dz>=1 && zc+dz<=dim) && ...
                mesh_modificata(xc,yc+dy,zc+dz) == ID_trabecola 
                mesh_iniziale(xc,yc+dy,zc+dz)=0;
            end
            
            if  (yc+dz>=1 && yc+dz<=dim && zc+dy>=1 && zc+dy<=dim) && ...
                mesh_modificata(xc,yc+dz,zc+dy) == ID_trabecola 
                mesh_iniziale(xc,yc+dz,zc+dy)=0;
            end
            
            if  (yc-dy>=1 && yc-dy<=dim && zc+dz>=1 && zc+dz<=dim) && ...
                mesh_modificata(xc,yc-dy,zc+dz) == ID_trabecola 
                mesh_iniziale(xc,yc-dy,zc+dz)=0;
            end
            
            if  (yc-dz>=1 && yc-dz<=dim && zc+dy>=1 && zc+dy<=dim) && ...
                mesh_modificata(xc,yc-dz,zc+dy) == ID_trabecola 
                mesh_iniziale(xc,yc-dz,zc+dy)=0;
            end
            
            if  (yc-dy>=1 && yc-dy<=dim && zc-dz>=1 && zc-dz<=dim) && ...
                mesh_modificata(xc,yc-dy,zc-dz) == ID_trabecola 
                mesh_iniziale(xc,yc-dy,zc-dz)=0;
            end
            
            if  (yc-dz>=1 && yc-dz<=dim && zc-dy>=1 && zc-dy<=dim) && ...
                mesh_modificata(xc,yc-dz,zc-dy) == ID_trabecola 
                mesh_iniziale(xc,yc-dz,zc-dy)=0;
            end
            
            if  (yc+dy>=1 && yc+dy<=dim && zc-dz>=1 && zc-dz<=dim) && ...
                mesh_modificata(xc,yc+dy,zc-dz) == ID_trabecola 
                mesh_iniziale(xc,yc+dy,zc-dz)=0;
            end
            
            
            if  (yc+dz>=1 && yc+dz<=dim && zc-dy>=1 && zc-dy<=dim) && ...
                mesh_modificata(xc,yc+dz,zc-dy) == ID_trabecola 
                mesh_iniziale(xc,yc+dz,zc-dy)=0;
            end
                     
        dz=dz+1;
        d=f(dz,dy-1/2);

        if d>0 
            dy=dy-1;
        elseif d==0
            dy=dy-(randi(2,1)-1);
        end
                
    
    end
    
end

%RICOLLOCAZIONE CRICCA
R=R+1;

f=@(y,z) (y).^2 + (z).^2 - R.^2;  
dy = R;
dz = 0;

    while dz<=dy

            if  (yc+dy>=1 && yc+dy<=dim && zc+dz>=1 && zc+dz<=dim) && ...
                mesh_modificata(xc,yc+dy,zc+dz) == ID_trabecola 
                riga_cricche(1)=xc;
                riga_cricche(2)=yc+dy;
                riga_cricche(3)=zc+dz;
                return
            end
            
            if  (yc+dz>=1 && yc+dz<=dim && zc+dy>=1 && zc+dy<=dim) && ...
                mesh_modificata(xc,yc+dz,zc+dy) == ID_trabecola 
                riga_cricche(1)=xc;
                riga_cricche(2)=yc+dz;
                riga_cricche(3)=zc+dy;
                return
            end
            
            if  (yc-dy>=1 && yc-dy<=dim && zc+dz>=1 && zc+dz<=dim) && ...
                mesh_modificata(xc,yc-dy,zc+dz) == ID_trabecola 
                riga_cricche(1)=xc;
                riga_cricche(2)=yc-dy;
                riga_cricche(3)=zc+dz;
                return
            end
            
            if  (yc-dz>=1 && yc-dz<=dim && zc+dy>=1 && zc+dy<=dim) && ...
                mesh_modificata(xc,yc-dz,zc+dy) == ID_trabecola 
                riga_cricche(1)=xc;
                riga_cricche(2)=yc-dz;
                riga_cricche(3)=zc+dy;
                return
            end
            
            if  (yc-dy>=1 && yc-dy<=dim && zc-dz>=1 && zc-dz<=dim) && ...
                mesh_modificata(xc,yc-dy,zc-dz) == ID_trabecola 
                riga_cricche(1)=xc;
                riga_cricche(2)=yc-dy;
                riga_cricche(3)=zc-dz;
                return
            end
            
            if  (yc-dz>=1 && yc-dz<=dim && zc-dy>=1 && zc-dy<=dim) && ...
                mesh_modificata(xc,yc-dz,zc-dy) == ID_trabecola
                riga_cricche(1)=xc;
                riga_cricche(2)=yc-dz;
                riga_cricche(3)=zc-dy;
                return
            end
            
            if  (yc+dy>=1 && yc+dy<=dim && zc-dz>=1 && zc-dz<=dim) && ...
                mesh_modificata(xc,yc+dy,zc-dz) == ID_trabecola 
                riga_cricche(1)=xc;
                riga_cricche(2)=yc+dy;
                riga_cricche(3)=zc-dz;
                return
            end
            
            
            if  (yc+dz>=1 && yc+dz<=dim && zc-dy>=1 && zc-dy<=dim) && ...
                mesh_modificata(xc,yc+dz,zc-dy) == ID_trabecola 
                riga_cricche(1) = xc;
                riga_cricche(2) = yc+dz;
                riga_cricche(3) = zc-dy;
                return
            end
                     
        dz=dz + 1;
        d=f(dz,dy-1/2);

        if d>0 
            dy=dy - 1;
        elseif d==0
            dy=dy-(randi(2,1)-1);
        end
                
    end    
    
end