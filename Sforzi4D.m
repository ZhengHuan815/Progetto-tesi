function Sforzi4D(axis)

global mesh_modificata SF sforzi incidenze
dim = size(mesh_modificata,1);
SF = zeros(dim,dim,dim,6);

for i=1:size(incidenze,1)
    x=incidenze(i,1);
    y=incidenze(i,2);
    z=incidenze(i,3);

    sigma = sforzi(i,:);
    if axis == 1
        SF(x,y,z,:) = sigma; 
    elseif axis == 2
        SF(y,x,z,:) = sigma; 
    elseif axis == 3
        SF(z,y,x,:) = sigma; 
    end
end

end