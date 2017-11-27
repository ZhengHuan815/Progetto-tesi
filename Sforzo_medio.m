function [sm] = Sforzo_medio (riga_cricca,R)

global mesh_iniziale sforzi incidenze

R = round(R);
xc= riga_cricca(1);
yc= riga_cricca(2);
zc= riga_cricca(3);
k=0;
dim=size(mesh_iniziale,1);


for y=yc-R:yc+R
    for z=zc-R:zc+R
        if y>0 && z>0 && y<=dim && z<=dim && mesh_iniziale(xc,y,z)==1    
            k=k+1;
            i = find(all((incidenze==[xc y z])')); %trova la riga della matrice Sforzi che corrisponde alle coordinate di interesse attraverso una matrice di appoggio che fornisce l'informazione
            sigma_locale = sforzi(i,:); %seleziona la riga di interesse che contiene i sei elementi del tensore degli sforzi nel punto
%             Tensore_sigma = [sigma_locale(1) sigma_locale(4) sigma_locale(5); sigma_locale(4) sigma_locale(2) sigma_locale(6); sigma_locale(5) sigma_locale(6) sigma_locale(3)]; %costruisce il tensore degli sforzi
            Sforzo_massimo(k) = sigma_locale(1) + sigma_locale(4) + sigma_locale(5); %nonzeros(Tensore_sigma*[1 0 0]'); %valuta lo sforzo massimo per la propagazione (perpendicolare alla direzione della cricca)
        end
    end
end

sm = abs(mean(Sforzo_massimo));

end