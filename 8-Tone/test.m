function []=test()

%Read the host image
ih=imread('1 (96).JPEG');

%Read the watermark image
iw=imread('1 (97).JPEG');


%Specify Block Size 8, 16, 32
bs=16; 


[YW]=MT3WM8T(ih,iw,bs);

end
