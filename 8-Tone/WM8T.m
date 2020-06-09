%Function to generate four tone watermark

function [Y]=WM8T(im)

[s1 s2]=size(im);

for i=1:1:s1
    for j=1:1:s2
        
        if(im(i,j)>224)
            Y(i,j)=1;
        elseif(im(i,j)>192)
            Y(i,j)=0.84;
        elseif(im(i,j)>160)
            Y(i,j)=0.70;
        elseif(im(i,j)>128)
            Y(i,j)=0.66;
        elseif(im(i,j)>96)
            Y(i,j)=0.42;
        elseif(im(i,j)>64)
            Y(i,j)=0.28;
        elseif(im(i,j)>32)
            Y(i,j)=0.14;
        else
            Y(i,j)=0;
        end
    end
end
end
