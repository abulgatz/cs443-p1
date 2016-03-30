imgRGB = imread('stripes.png');

% Show original RGB image
subplot(2,4,1);
imshow(imgRGB);
title('RGB');

% Do YCBCR conversion, get back uint8
imgYCBCR = rgbToYCBCR(imgRGB);
% imgYCBCRmatlab = rgb2ycbcr(imgRGB);

% 1. Image starts out with 8 bit integer values 0-255
% 2. If we used im2double, we would be converting the 8-bit integer to a double, then dividing by 255. For example, 128 becomes 0.5
% 3. Instead, I want to keep a 0-255 range, but increase precision by just converting to a double. For example, 128 becomes 128.0
% 4. From now on when using imshow, must cast back to uint 8
imgYCBCR = double(imgYCBCR);

img444 = imgYCBCR;
img411 = sub411(imgYCBCR);
img420 = sub420(imgYCBCR);

subplot(2,4,2);
imshow(uint8(img444));
title('4:4:4');

subplot(2,4,3);
imshow(uint8(img411));
title('4:1:1');

subplot(2,4,4);
imshow(uint8(img420));
title('4:2:0');

% 4:4:4
img444 = dctConvert(img444,8,false);
img444 = dctQuantization(img444,false);
img444 = dctQuantization(img444,true);
img444 = dctConvert(img444,8,true);
img444 = uint8(img444);
img444 = ycbcr2rgb(img444);

subplot(2,4,5);
imshow(img444);
title('4:4:4 d,q,rgb');

% 4:1:1
img411 = dctConvert(img411,8,false);
img411 = dctQuantization(img411,false);
img411 = dctQuantization(img411,true);
img411 = dctConvert(img411,8,true);
img411 = uint8(img411);
img411 = ycbcr2rgb(img411);

subplot(2,4,6);
imshow(img411);
title('4:1:1 d,q,rgb');

% 4:2:0
img420 = dctConvert(img420,8,false);
img420 = dctQuantization(img420,false);
img420 = dctQuantization(img420,true);
img420 = dctConvert(img420,8,true);
img420 = uint8(img420);
img420 = ycbcr2rgb(img420);

subplot(2,4,7);
imshow(img420);
title('4:2:0 d,q,rgb');

MSE = computeMSE(imgRGB,img420);
PSNR = computePSNR(MSE);

disp('MSE = ')
disp(MSE)
disp('PSNR = ')
disp(PSNR)