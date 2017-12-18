function Rotate

global mesh_iniziale dir_carico

dim = size(mesh_iniziale,1);

if dir_carico == 2
        mesh_iniziale = permute(mesh_iniziale,[2 1 3]);
elseif dir_carico == 3
   mesh_iniziale = permute(mesh_iniziale,[3 2 1]);
end

end