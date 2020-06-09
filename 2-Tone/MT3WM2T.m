%A Combined Multitoning and Watermarking Scheme for Clustered Dot Pattern
%%   Author: Dr. J. M. Guo, Mr. Sankarasrinivasan, %%   Multimedia Signal Processing Lab, NTUST, Taiwan+
%% MT3W2T: MT3 represents 3-tone image and 2T represents watermark image
%% im- host image; iw-watermark image, bs-block size

function [YW]=MT3WM2T(im,iw,bs)

figure, subplot(1,3,1), imshow(iw);
title('Watermark Image');

%No of Tones
T=3;

%Size of Host & Watermark Image
[s1,s2]=size(im);
[w1,w2]=size(iw);
s11=s1/bs;
s22=s2/bs;
iw=imresize(iw,[s11 s22]);


%Creating pseudo random image
iwr=iw; 
r1=randperm(s11*s22);
r1=vec2mat(r1,s11)
rr=1;

for i=1:1:s11
    for j=1:1:s22
        [p1,p2]=find(r1==rr);
        iw(i,j)=iwr(p1,p2);
        rr=rr+1;
    end
end


%Symmetrical dither arrays
[DA]=gen_ditherarrayMT3SD76(bs);
[DA4]=gen_ditherarrayMT3SD83(bs);


T=T-1;
x1=1; y1=1;


%WATERMARK EMBEDDING

MT=ones(bs,bs); 
NT=ones(bs,bs);
for i=1:bs:s1
    for j=1:bs:s2             
        bl=im(i:i+(bs-1),j:j+(bs-1));
                   
       for nT=1:1:T     
       MT=(bl>=DA(:,:,nT));      
       M(:,:,nT)=MT;    
       MT=(bl>DA4(:,:,nT));
       Mc(:,:,nT)=MT;
             
       end       
       
           if(iw(x1,y1)==0)
       for x=1:1:bs
           for y=1:1:bs                     
              if(M(x,y,1)==1 )
                  blc(x,y)=1;
              elseif(M(x,y,2)==1)
                  blc(x,y)=0.5;       
              else
                  blc(x,y)=0;
              end
              
           end
       end
           end
          if(iw(x1,y1)==1)
               for x=1:1:bs
           for y=1:1:bs                     
              if(Mc(x,y,1)==1 )
                  blc(x,y)=1;
              elseif(Mc(x,y,2)==1)
                  blc(x,y)=0.5;                    
              else
                  blc(x,y)=0;
              end
           end
               end
          end
          
     
           y1=y1+1;
    
 Y(i:i+(bs-1),j:j+(bs-1))=blc;
    end 
       y1=1;
       x1=x1+1;
end


imw=Y;
%WATERMARK EXTRACTION

x1=1; y1=1;

MT=ones(bs,bs); 
NT=ones(bs,bs);
for i=1:bs:s1
    for j=1:bs:s2    
      
        bl=255*imw(i:i+(bs-1),j:j+(bs-1));
        bl=ones(bs,bs)*mean(bl(:));
        blm=imw(i:i+(bs-1),j:j+(bs-1));
                   
        for nT=1:1:T     
        MT=(bl>=DA(:,:,nT));      
        M(:,:,nT)=MT;    
        MT=(bl>DA4(:,:,nT));
        Mc(:,:,nT)=MT;       
        end       
       
          
        for x=1:1:bs
           for y=1:1:bs                     
              if(M(x,y,1)==1 )
                  blc(x,y)=1;
              elseif(M(x,y,2)==1)
                  blc(x,y)=0.5;                        
              else
                  blc(x,y)=0;
              end
              
           end
        end
        ia=blc;
                
        for x=1:1:bs
           for y=1:1:bs                     
              if(Mc(x,y,1)==1 )
                  blc(x,y)=1;
              elseif(Mc(x,y,2)==1)
                  blc(x,y)=0.5;                      
              else
                  blc(x,y)=0;
              end
              
           end         
          end
               iwh=blc;
               
              
        
                         
               t1=sum(sum(uint8(blm).*uint8(ia)));
               t2=sum(sum(uint8(blm).*uint8(iwh)));            
               t=[t1; t2;];
               [m m1]=max(t);
               if(m1==1)
                   YW(x1,y1)=0;
               elseif(m1==2)
                   YW(x1,y1)=1;
               end
               
               y1=y1+1;         
    
    end     
     y1=1;
     x1=x1+1;
end
rr=1;
iwr=YW;

%Reconstructing extracted watermark using pseudo random key
for i=1:1:s11
    for j=1:1:s22
        [p1,p2]=find(r1==rr);
        YW(p1,p2)=iwr(i,j);
        rr=rr+1;
    end
end

subplot(1,3,2),imshow(iw);
title('Pseudo Random Watermark');


subplot(1,3,3), imshow(YW);
title('Extracted Watermark');


end

