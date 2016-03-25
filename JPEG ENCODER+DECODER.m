
% Load the input image
% STOP

imgrgb = imread('Kodak23.bmp');

img = rgb2ycbcr(imgrgb);

luma = img(:,:,1);
%subsample the chroma image
imgcb = img(:,:,2);
imgcr = img(:,:,3);
%% 422 subsampling
imgcb_422 = imgcb(:,1:2:size(imgcb,2));
imgcr_422 = imgcr(:,1:2:size(imgcb,2));
%  420 subsampling
imgcb_420 = imgcb_422(1:2:size(imgcb_422,1),:);
imgcr_420 = imgcr_422(1:2:size(imgcb_422,1),:);
figure(1),imshow(imgcb_420)
figure(2),imshow(imgcr_420)

%LUMA ************************************************************************************* 
%define luminance quantization matrix
Q=[...
   16 11 10 16 24 40 51 61
12 12 14 19 26 58 60 55
14 13 16 24 40 57 69 56
14 17 22 29 51 87 80 62
18 22 37 56 68 109 103 77
24 35 55 64 81 104 113 92
49 64 78 87 103 121 120 101
72 92 95 98 112 100 103 99];
luma=double(luma);
luma=luma-128;
%dct
for i=1:8:size(luma,1)-7
     for j=1:8:size(luma,2)-7
         dluma(i:i+7,j:j+7)=dct2(luma(i:i+7,j:j+7));
         temp(i:i+7,j:j+7)=dluma(i:i+7,j:j+7)./Q;
         temp1(i:i+7,j:j+7)=round(temp(i:i+7,j:j+7));
     end
end
figure(3),imshow(temp1)
%figure(5),imshow(imgcb)
%figure(6),imshow(imgcr)

for i=1:8:size(temp1,1)-7
   for j=1:8:size(temp1,2)-7
       invluma(i:i+7,j:j+7)=temp1(i:i+7,j:j+7).*Q;
      
       RCLUMA(i:i+7,j:j+7)=idct2(invluma(i:i+7,j:j+7));
   end
end
RCLUMA=RCLUMA+128;
 RCL=uint8(RCLUMA);
 
 figure(4),imshow(RCL)

  %CHROMA(CB)**************************************************************
CQ=[... 
    17	18	24	47	99	99	99	99
    18	21	26	66	99	99	99	99
    24	26	56	99	99	99	99	99
    47	66	99	99	99	99	99	99
    99	99	99	99	99	99	99	99
    99	99	99	99	99	99	99	99
    99	99	99	99	99	99	99	99
    99	99	99	99	99	99	99	99];
imgcb_420=double(imgcb_420);
imgcb_420=imgcb_420-128;
%dct
for i=1:8:size(imgcb_420,1)-7
     for j=1:8:size(imgcb_420,2)-7
         dimgcb_420(i:i+7,j:j+7)=dct2(imgcb_420(i:i+7,j:j+7));
         temp21(i:i+7,j:j+7)=dimgcb_420(i:i+7,j:j+7)./CQ;
         temp221(i:i+7,j:j+7)=round(temp21(i:i+7,j:j+7));
     end
end
figure(5),imshow(temp221)

for i=1:8:size(temp221,1)-7
   for j=1:8:size(temp221,2)-7
       invimgcb_420(i:i+7,j:j+7)=temp221(i:i+7,j:j+7).*CQ;
      
        RCIMGCB_420(i:i+7,j:j+7)=idct2(invimgcb_420(i:i+7,j:j+7));
   end
end
RCIMGCB_420=RCIMGCB_420+128;
 RCB1=uint8(RCIMGCB_420);
 %RCB1=RCB';
 figure(6),imshow(RCB1)
 
  %CHROMA(CR)**************************************************************
 imgcr_420=double(imgcr_420);
 imgcr_420=imgcr_420-128;
 %dct
 for i=1:8:size(imgcr_420,1)-7
     for j=1:8:size(imgcr_420,2)-7
         dimgcr_420(i:i+7,j:j+7)=dct2(imgcr_420(i:i+7,j:j+7));
         temp31(i:i+7,j:j+7)=dimgcr_420(i:i+7,j:j+7)./CQ;
         temp321(i:i+7,j:j+7)=round(temp31(i:i+7,j:j+7));
     end
 end
figure(7),imshow(temp321)

for i=1:8:size(temp321,1)-7
   for j=1:8:size(temp321,2)-7
       invimgcr_420(i:i+7,j:j+7)=temp321(i:i+7,j:j+7).*CQ;
       RCIMGCR_420(i:i+7,j:j+7)=idct2(invimgcr_420(i:i+7,j:j+7));
   end
end
RCIMGCR_420=RCIMGCR_420+128;
RCR1=uint8(RCIMGCR_420);
figure(8),imshow(RCR1)

%***************************LUMA****************************************************************************

%SNR CALCULATIONS
RCL=double(RCL);
RCB1=double(RCB1);
RCR1=double(RCR1);
luma_dif = 0;
luma_energy = 0;
for i = 1: size(luma,1)-7
   for j = 1:size(luma, 2)-7
        luma_dif  = luma_dif +((luma(i,j)-RCL(i,j))*(luma(i,j)-RCL(i,j)));
        luma_energy = luma_energy + luma(i,j)*luma(i,j);
   end
end

luma_snr = 10*log10 (luma_energy*luma_energy/luma_dif);

%CHROMA SNR**********************(CB)*********************************************************************

cb_dif1 = 0;
cb_energy1 = 0;
%RCB1_ENERGY=0;
for i = 1: size(imgcb_420,1)-7
   for j = 1:size(imgcb_420,2)-7
        cb_energy1 = cb_energy1 + imgcb_420(i,j);
        cb_dif1=cb_dif1+((imgcb_420(i,j)-RCB1(i,j))*(imgcb_420(i,j)-RCB1(i,j)));
   end
end
cb_snr1 = 10*log10(((cb_energy1)*(cb_energy1))/cb_dif1);

%****************CR***************SNR***********************************************************************

cr_dif1 = 0;
cr_energy1 = 0;

for i = 1: size(imgcr_420,1)-7
   for j = 1:size(imgcr_420,2)-7
       cr_energy1 = cr_energy1 + imgcr_420(i,j);
       cr_dif1=cr_dif1+((imgcr_420(i,j)-RCR1(i,j))*(imgcr_420(i,j)-RCR1(i,j)));
   end
end
cr_snr1 = 10*log10(((cr_energy1)*(cr_energy1))/cr_dif1);




fp=fopen('lena_512x512_420.yuv', 'wb');
RCL1 = RCL';
fwrite(fp,RCL1);

RCB1= RCB1';
fwrite(fp,RCB1);

RCR1 = RCR1';
count=fwrite(fp,RCR1);
fclose(fp);

