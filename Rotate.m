function Rotate(axis)

global mesh_iniziale

dim = size(mesh_iniziale,1);

if axis==1
   for x=1:dim
      mesh_iniziale(x,:,:)=mesh_iniziale(x,:,:)'; 
   end
   
elseif axis == 1
    for y=1:dim
      mesh_iniziale(:,y,:)=mesh_iniziale(:,y,:)';
    end
    
elseif axis == 3
    for z=1:dim
      mesh_iniziale(:,:,z)=mesh_iniziale(:,:,z)';
    end
end

end