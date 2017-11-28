function Sforzi4D

global mesh_modificata SF sforzi incidenze
dim = size(mesh_modificata,1);
SF = zeros(dim,dim,dim,6);

for i=1:size(incidenze,1)
    x=incidenze(i,2);
    y=incidenze(i,1);
    z=incidenze(i,3);

    sigma = sforzi(i,:);
    SF(x,y,z,:) = 13*sigma;   
    
end

end