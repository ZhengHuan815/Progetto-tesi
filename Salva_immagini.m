function [inten_sforzi]=Salva_immagini(layer)
global SF mesh_iniziale

dim=size(mesh_iniziale,1);
inten_sforzi=mesh_iniziale(layer,:,:);

for y=1:dim
    for z=1:dim
        if inten_sforzi(x,y)~=0
            inten_sforzi(x,y)=abs(SF(layer,y,z,1)+SF(layer,y,z,5)+SF(layer,y,z,6));
        end
    end  
end    

end