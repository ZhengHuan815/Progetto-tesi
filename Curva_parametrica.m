function [coordinates]=Curva_parametrica(coord_cricca)



global mesh_modificata

conn=0;
n=10; %parametro di progetto
xc=coord_cricca(1);
coordinates= [coord_cricca(2) coord_cricca(3)]; %inizializzazione variabile

while size(coordinates,1)<=n %condizione di terminazione coincide con aver trovato le coordinate di n punti del contorno centrati in coord_cricca

    for i=(size(coordinates,1)-conn):size(coordinates,1) %evita di ripetere operazioni inutili

        conn=0;
        yc=coordinates(i,1);
        zc=coordinates(i,2);
        
        if max([yc-1 yc+1 zc-1 zc+1]) <= size(mesh_modificata,1) && min([yc-1 yc+1 zc-1 zc+1]) >= 1
            near(:,:)=mesh_modificata(xc,yc-1:yc+1,zc-1:zc+1);
            [y,z]=find(near==2);
            y = y + yc - 2;
            z = z + zc - 2;
            l=length(y);

            for j=1:l
                log = ([y(j) z(j)] == coordinates); 
                log2 = [];
                for k=1:size(coordinates,1)
                    log2 = [log2 log(k,1)&&log(k,2)];       
                end
                if  all(~(log2))
                    coordinates=[coordinates; [y(j) z(j)] ];  
                    conn = conn+1;
                end
            end
            
        else 
            return
        end
        
    end

end
end