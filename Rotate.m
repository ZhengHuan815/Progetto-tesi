function Rotate(axis)

global mesh_iniziale

dim = size(mesh_iniziale,1);

if axis == 2
        mesh_iniziale = permute(mesh_iniziale,[2 1 3]);
elseif axis == 3
   mesh_iniziale = permute(mesh_iniziale,[3 2 1]);
end

end