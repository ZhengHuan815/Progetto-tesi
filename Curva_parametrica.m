function [coordinates]=Curva_parametrica(coord_cricca)



global mesh_modificata

conn=0;
n=10; %parametro di progetto
xc=coord_cricca(1);
coordinates= [coord_cricca(2); coord_cricca(3)]; %inizializzazione variabile

while size(coordinates,2)<=n %condizione di terminazione coincide con aver trovato le coordinate di n punti del contorno centrati in coord_cricca

    for i=(size(coordinates,2)-conn):size(coordinates,2) %evita di ripetere operazioni inutili

        conn=0;
        yc=coordinates(1,i);
        zc=coordinates(2,i);
        
        if max([yc-1 yc+1 zc-1 zc+1]) <= size(mesh_modificata,1) && min([yc-1 yc+1 zc-1 zc+1]) >= 1
            near(:,:)=mesh_modificata(xc,yc-1:yc+1,zc-1:zc+1);
            [y,z]=find(near==2);
            y = y + yc - 2;
            z = z + zc - 2;
            l=length(y);

            log2=[];


            for j=1:l
                log = ([y(i);z(i)] == coordinates); %%problema! in caso di quadrato va prima per righe
                log2 = [];
                for k=1:size(coordinates,2)
                    log2 = [log2 log(1,k)&&log(2,k)];       
                end
                if  all(~(log2))
                    coordinates=[coordinates [y(i);z(i)] ];  
                    conn = conn+1;
                end
            end
            
        else 
            return
        end
        
    end

end
end