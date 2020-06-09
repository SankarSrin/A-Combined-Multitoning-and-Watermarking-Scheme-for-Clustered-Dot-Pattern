%A Combined Multitoning and Watermarking Scheme for Clustered Dot Pattern
%%   Author: Dr. J. M. Guo, Mr. Sankarasrinivasan, %%   Multimedia Signal Processing Lab, NTUST, Taiwan+
%% MT3W2T: MT3 represents 3-tone image and 8T represents watermark image
%% im- host image; iw-watermark image, bs-block size

function [YW]=MT3WM8T(im,iw,bs)


[s1,s2]=size(im);
[w1,w2]=size(iw);
s11=s1/bs;
s22=s2/bs;


iw=imresize(iw,[s11 s22]);
iw=WM8T(iw);

figure, subplot(1,3,1), imshow(iw);
title('Watermark Image');

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

T=3;
if(T==3)
 [DA]=gen_ditherarrayMT3(bs); 
 [DAc]=gen_ditherarrayMT3SD81(bs);
 [DA4]=gen_ditherarrayMT3SD82(bs);
 [DAc4]=gen_ditherarrayMT3SD83(bs); 
 [DA44]=gen_ditherarrayMT3SD79(bs);
 [DAc44]=gen_ditherarrayMT3SD78(bs);
 [DA8]=gen_ditherarrayMT3SD77(bs);
 [DAc8]=gen_ditherarrayMT3SD76(bs); 
 end

T=T-1;
x1=1; y1=1;

MT=ones(bs,bs); 
NT=ones(bs,bs);
for i=1:bs:s1
    for j=1:bs:s2             
        bl=im(i:i+(bs-1),j:j+(bs-1));
                   
       for nT=1:1:T     
       MT=(bl>=DA(:,:,nT));      
       M(:,:,nT)=MT;    
       MT=(bl>DAc(:,:,nT));
       Mc(:,:,nT)=MT;
       MT=(bl>DA4(:,:,nT));
       M4(:,:,nT)=MT;
       MT=(bl>DAc4(:,:,nT));
       M4t(:,:,nT)=MT;  
       MT=(bl>DA44(:,:,nT));
       M44(:,:,nT)=MT;
       MT=(bl>DAc44(:,:,nT));
       M44t(:,:,nT)=MT;  
       MT=(bl>DA8(:,:,nT));
       M8(:,:,nT)=MT;
       MT=(bl>DAc8(:,:,nT));
       M8t(:,:,nT)=MT; 
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
              elseif(Mc(x,y,2)==1 )
                  blc(x,y)=0.5;                        
              else
                  blc(x,y)=0;
              end
           end
               end
          end
          
                    
         if(iw(x1,y1)==0.14)
           for x=1:1:bs
           for y=1:1:bs                     
              if(M4(x,y,1)==1 )
                  blc(x,y)=1;
              elseif(M4(x,y,2)==1 )
                  blc(x,y)=0.5;                        
              else
                  blc(x,y)=0;
              end
              
           end
       end
               
         end     
               
         if(iw(x1,y1)==0.84)
               for x=1:1:bs
           for y=1:1:bs                     
              if(M4t(x,y,1)==1 )
                  blc(x,y)=1;                        
              elseif(M4t(x,y,2)==1 )
                  blc(x,y)=0.5;                        
              else
                  blc(x,y)=0;
              end
              
           end
       end
               
         end   
           
         if(iw(x1,y1)==0.28)
               for x=1:1:bs
           for y=1:1:bs                     
              if(M44(x,y,1)==1 )
                  blc(x,y)=1;                                 
              elseif(M44(x,y,2)==1 )
                  blc(x,y)=0.5;                        
              else
                  blc(x,y)=0;
              end
              
           end
               end               
          end     
           
          if(iw(x1,y1)==0.70)
               for x=1:1:bs
           for y=1:1:bs                     
              if(M44t(x,y,1)==1 )
                  blc(x,y)=1;                                  
              elseif(M44t(x,y,2)==1 )
                  blc(x,y)=0.5;                        
              else
                  blc(x,y)=0;
              end
              
           end
       end
               
          end     
           if(iw(x1,y1)==0.42)
               for x=1:1:bs
           for y=1:1:bs                     
              if(M8(x,y,1)==1 )
                  blc(x,y)=1;                                  
              elseif(M8(x,y,2)==1 )
                  blc(x,y)=0.5;                        
              else
                  blc(x,y)=0;
              end
              
           end
       end
               
           end       
           if(iw(x1,y1)==0.66)
               for x=1:1:bs
           for y=1:1:bs                     
              if(M8t(x,y,1)==1 )
                  blc(x,y)=1;                                  
              elseif(M8t(x,y,2)==1 )
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
       MT=(bl>DAc(:,:,nT));
       Mc(:,:,nT)=MT;
        MT=(bl>DA4(:,:,nT));
       M4(:,:,nT)=MT;
       MT=(bl>DAc4(:,:,nT));
       M4t(:,:,nT)=MT;
       MT=(bl>DA44(:,:,nT));
       M44(:,:,nT)=MT;
       MT=(bl>DAc44(:,:,nT));
       M44t(:,:,nT)=MT;  
       MT=(bl>DA8(:,:,nT));
       M8(:,:,nT)=MT;
       MT=(bl>DAc8(:,:,nT));
       M8t(:,:,nT)=MT; 
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
              elseif(Mc(x,y,2)==1 )
                  blc(x,y)=0.5;                        
              else
                  blc(x,y)=0;
              end
              
           end         
               end
               iwh=blc;
               for x=1:1:bs
           for y=1:1:bs                     
              if(M4(x,y,1)==1 )
                  blc(x,y)=1;                                 
              elseif(M4(x,y,2)==1 )
                  blc(x,y)=0.5;                        
              else
                  blc(x,y)=0;
              end
              
           end         
               end
               iwh1=blc;
               
                       for x=1:1:bs
           for y=1:1:bs                     
              if(M4t(x,y,1)==1 )
                  blc(x,y)=1;
              elseif(M4t(x,y,2)==1)
                  blc(x,y)=0.5;                                    
              else
                  blc(x,y)=0;
              end
              
           end         
               end
               iwh2=blc;
               
                for x=1:1:bs
           for y=1:1:bs                     
              if(M44(x,y,1)==1 )
                  blc(x,y)=1;
              elseif(M44(x,y,2)==1)
                  blc(x,y)=0.5;  
              else
                  blc(x,y)=0;
              end
              
           end         
               end
               iwh3=blc;
               
                for x=1:1:bs
           for y=1:1:bs                     
              if(M44t(x,y,1)==1 )
                  blc(x,y)=1;                                  
              elseif(M44t(x,y,2)==1 )
                  blc(x,y)=0.5;                        
              else
                  blc(x,y)=0;
              end
              
           end         
               end
               iwh4=blc;
               
               for x=1:1:bs
           for y=1:1:bs                     
              if(M8(x,y,1)==1 )
                  blc(x,y)=1;                                  
              elseif(M8(x,y,2)==1 )
                  blc(x,y)=0.5;                        
              else
                  blc(x,y)=0;
              end
              
           end         
               end
               iwh5=blc;
               
                for x=1:1:bs
           for y=1:1:bs                     
              if(M8t(x,y,1)==1 )
                  blc(x,y)=1;                                  
              elseif(M8t(x,y,2)==1 )
                  blc(x,y)=0.5;                        
              else
                  blc(x,y)=0;
              end
              
           end         
               end
               iwh6=blc;
               
               
               
               t1=sum(sum(blm.*ia));
               t2=sum(sum(blm.*iwh));
               t3=sum(sum(blm.*iwh1));
               t4=sum(sum(blm.*iwh2));
               t5=sum(sum(blm.*iwh3));
               t6=sum(sum(blm.*iwh4));
               t7=sum(sum(blm.*iwh5));
               t8=sum(sum(blm.*iwh6));
               
               t=[t1; t2 ; t3; t4; t5; t6; t7; t8;];
               [m m1]=max(t);
               if(m1==1)
                   YW(x1,y1)=0;
               elseif(m1==2)
                   YW(x1,y1)=1;
               elseif(m1==3)
                   YW(x1,y1)=0.14;
               elseif(m1==4) 
                   YW(x1,y1)=0.84;
               elseif(m1==5) 
                   YW(x1,y1)=0.28;
                elseif(m1==6) 
                   YW(x1,y1)=0.70;
                    elseif(m1==7) 
                   YW(x1,y1)=0.42;
               else 
                   YW(x1,y1)=0.66;
               end
               
               y1=y1+1;
          
    
    end     
     y1=1;
     x1=x1+1;
end
   
rr=1;
iwr=YW;

%Rearrange watermark image using pseudorandom 
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

