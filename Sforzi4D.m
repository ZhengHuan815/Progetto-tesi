function Sforzi4D

global mesh_modificata SF sforzi incidenze dir_carico
dim = size(mesh_modificata,1);
SF = zeros(dim,dim,dim,6);

for i=1:size(incidenze,1)
    x=incidenze(i,1);
    y=incidenze(i,2);
    z=incidenze(i,3);

    sigma = sforzi(i,:);
    if dir_carico == 1
        SF(x,y,z,:) = sigma; 
    elseif dir_carico == 2
        SF(y,x,z,:) = sigma; 
    elseif dir_carico == 3
        SF(z,y,x,:) = sigma; 
    end
end

end