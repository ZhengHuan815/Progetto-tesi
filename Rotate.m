function a=Rotate(a)

global dir_carico

dim = size(a,1);

if dir_carico == 2
        a = permute(a,[2 1 3]);
elseif dir_carico == 3
   a = permute(a,[3 2 1]);
end

end