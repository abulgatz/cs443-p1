% Added Joshua's Subsampling code 
% Corrected Error Computation as per instructors requirements 
% Added YCbCr back to RGB conversion which was part of instruction set in phase 2


% Load the input image
imgrgb = imread('Lion.jpg');

img = rgb2ycbcr(imgrgb);

luma = img(:,:,1);
%subsample the chroma image
imgcb = img(:,:,2);
imgcr = img(:,:,3);
% 4:2:0 subsampling
    Cb = imgcb;
    Cr = imgcr;
    [CbHeight, CbWidth] = size(Cb);
    [CrHeight, CrWidth] = size(Cr);
    
    for i=1:CbHeight
        for j=1:CbWidth
            if mod(j, 2) == 1 && mod(i,2) == 1
                color = Cb(i,j);
            elseif mod (j, 2) == 1
                color = Cb(i-1,j);
            end
            Cb(i,j) = color;
        end
    end
    
    for i=1:CrHeight
        for j=1:CrWidth
            if mod(j, 2) == 1 && mod(i,2) == 1
                color = Cr(i,j);
            elseif mod (j, 2) == 1
                color = Cr(i-1,j);
            end
            Cr(i,j) = color;
        end
    end
    
 % 4:1:1 subsampling
 
 [CbHeight, CbWidth] = size(Cb);
    [CrHeight, CrWidth] = size(Cr);
    
    for i=1:CbHeight
        for j=1:CbWidth
            if mod(j, 4) == 1
                color = Cb(i,j);
            end
            Cb(i,j) = color;
        end
    end
    
    for i=1:CrHeight
        for j=1:CrWidth
            if mod(j, 4) == 1
                color = Cr(i,j);
            end
            Cr(i,j) = color;
        end
    end
    
   

figure(1),imshow(Cb);title('Subsampled Cb Component');
figure(2),imshow(Cr);title('Subsampled Cr Component');

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
figure(3),imshow(temp1);title('DCT applied and Quantized Luma');

for i=1:8:size(temp1,1)
   for j=1:8:size(temp1,2)
       invluma(i:i+7,j:j+7)=temp1(i:i+7,j:j+7).*Q;
      
       RCLUMA(i:i+7,j:j+7)=idct2(invluma(i:i+7,j:j+7));
   end
end
RCLUMA=RCLUMA+128;
 RCL=uint8(RCLUMA);
 
 figure(4),imshow(RCL);title('Dequantized and Inverse DCT Luma');

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
imgcb_411=double(Cb);
imgcb_411=imgcb_411-128;
%dct
for i=1:8:size(imgcb_411,1)-7
     for j=1:8:size(imgcb_411,2)-7
         dimgcb_411(i:i+7,j:j+7)=dct2(imgcb_411(i:i+7,j:j+7));
         temp21(i:i+7,j:j+7)=dimgcb_411(i:i+7,j:j+7)./CQ;
         temp221(i:i+7,j:j+7)=round(temp21(i:i+7,j:j+7));
     end
end
figure(5),imshow(temp221);title('DCT applied and Quantized Luma');

for i=1:8:size(temp221,1)
   for j=1:8:size(temp221,2)
       invimgcb_411(i:i+7,j:j+7)=temp221(i:i+7,j:j+7).*CQ;
      
        RCIMGCB_411(i:i+7,j:j+7)=idct2(invimgcb_411(i:i+7,j:j+7));
   end
end
RCIMGCB_411=RCIMGCB_411+128;
 RCB1=uint8(RCIMGCB_411);
 figure(6),imshow(RCB1);title('Dequantized and Inverse DCT Cb');
 
  %CHROMA(CR)**************************************************************
 imgcr_411=double(Cr);
 imgcr_411=imgcr_411-128;
 %dct
 for i=1:8:size(imgcr_411,1)-7
     for j=1:8:size(imgcr_411,2)-7
         dimgcr_411(i:i+7,j:j+7)=dct2(imgcr_411(i:i+7,j:j+7));
         temp31(i:i+7,j:j+7)=dimgcr_411(i:i+7,j:j+7)./CQ;
         temp321(i:i+7,j:j+7)=round(temp31(i:i+7,j:j+7));
     end
 end
figure(7),imshow(temp321);title('DCT applied and Quantized Cr');

for i=1:8:size(temp321,1)-7
   for j=1:8:size(temp321,2)-7
       invimgcr_411(i:i+7,j:j+7)=temp321(i:i+7,j:j+7).*CQ;
       RCIMGCR_411(i:i+7,j:j+7)=idct2(invimgcr_411(i:i+7,j:j+7));
   end
end
RCIMGCR_411=RCIMGCR_411+128;
RCR1=uint8(RCIMGCR_411);
figure(8),imshow(RCR1);title('Dequantized and Inverse DCT Cr');

YCbCrIMG(:,:,1) = RCL;
YCbCrIMG(:,:,2) = RCB1;
YCbCrIMG(:,:,3) = RCR1;

YCbCrtoRGB = ycbcr2rgb(YCbCrIMG);
figure(9),imshow(YCbCrtoRGB);title('YCbCr to RGB Image');

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
m = size(luma,1)-7;
n = size(luma,2)-7;
MSE_luma = luma_dif / (m*n);
luma_snr = 20*log10 (255/sqrt(MSE_luma));

%CHROMA SNR**********************(CB)*********************************************************************

cb_dif1 = 0;
cb_energy1 = 0;
%RCB1_ENERGY=0;
for i = 1: size(imgcb_411,1)-7
   for j = 1:size(imgcb_411,2)-7
        cb_energy1 = cb_energy1 + imgcb_411(i,j);
        cb_dif1=cb_dif1+((imgcb_411(i,j)-RCB1(i,j))*(imgcb_411(i,j)-RCB1(i,j)));
   end
end
m = size(imgcb_411,1)-7;
n = size(imgcb_411,2)-7;
MSE_Cb = cb_dif1 / (m*n);
cb_psnr1 = 20*log10(255 /sqrt(MSE_Cb));

%****************CR***************SNR***********************************************************************

cr_dif1 = 0;
cr_energy1 = 0;

for i = 1: size(imgcr_411,1)-7
   for j = 1:size(imgcr_411,2)-7
       cr_energy1 = cr_energy1 + imgcr_411(i,j);
       cr_dif1=cr_dif1+((imgcr_411(i,j)-RCR1(i,j))*(imgcr_411(i,j)-RCR1(i,j)));
   end
end
m = size(imgcr_411,1)-7;
n = size(imgcr_411,2)-7;
MSE_Cr = cr_dif1 / (m*n);
cr_psnr1 = 20*log10(255 /sqrt(MSE_Cr));


fp=fopen('Output_411.yuv', 'wb');
RCL1 = RCL';
fwrite(fp,RCL1);

RCB1= RCB1';
fwrite(fp,RCB1);

RCR1 = RCR1';
count=fwrite(fp,RCR1);
fclose(fp);

