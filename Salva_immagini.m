function Salva_immagini (im)

dim=size(im,1);

for x=1:dim
    temp(:,:)=im(x,:,:);
    t = image(temp);
    imwrite(t,'Layer_n_'+string(x),'jpeg');
end    

end