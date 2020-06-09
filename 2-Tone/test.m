function []=test()

%Read the host image
ih=imread('1 (94).JPEG');

%Read the watermark image
iw=imread('logo7.png');


%Specify Block Size 8, 16, 32
bs=16; 


[YW]=MT3WM2T(ih,iw,bs);

end
