function [inten_sforzi,j]=Intsf(layer)
global SF mesh_iniziale

dim=size(mesh_iniziale,1);
inten_sforzi=zeros(dim,dim,3);
j=jet(10);
for y=1:dim
    for z=1:dim
    %    if inten_sforzi(y,z)~=0
            sf=abs(SF(layer,y,z,1)+SF(layer,y,z,5)+SF(layer,y,z,6));
           
            if sf>0 && sf<1e-5
                inten_sforzi(y,z,:)=j(1,:);
            elseif sf<1e-4
                inten_sforzi(y,z,:)=j(2,:);
            elseif sf<1e-3
                inten_sforzi(y,z,:)=j(3,:);
            elseif sf<1e-2
                inten_sforzi(y,z,:)=j(4,:);
            elseif sf<0.1
                inten_sforzi(y,z,:)=j(5,:);
            elseif sf<0.2
                inten_sforzi(y,z,:)=j(6,:);
            elseif sf<0.3
                inten_sforzi(y,z,:)=j(7,:);
            elseif sf<0.4
                inten_sforzi(y,z,:)=j(8,:);
            elseif sf<0.5
                inten_sforzi(y,z,:)=j(9,:);
            elseif sf>=0.5
                inten_sforzi(y,z,:)=j(10,:);
            end
    end  
end    

end