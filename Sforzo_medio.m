function [sm] = Sforzo_medio (riga_cricca,R)

global mesh_iniziale SF

R = round(R)+1;
xc= riga_cricca(1);
yc= riga_cricca(2);
zc= riga_cricca(3);
k=0;
dim=size(mesh_iniziale,1);
Sforzo_direzione_carico = 0;

for y=yc-R:yc+R
    for z=zc-R:zc+R
        if y>0 && z>0 && y<=dim && z<=dim && mesh_iniziale(xc,y,z)==1    
            k=k+1;
            Sforzo_direzione_carico = Sforzo_direzione_carico + SF(xc,y,z,2); 
            %seleziona la riga di interesse che contiene i sei elementi del
            %tensore degli sforzi nel punto            
        end
    end
end

sm = abs((Sforzo_direzione_carico)/k);
 
end