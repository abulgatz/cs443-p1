JPEG ENCODER + DECODER 

WORKS IN 'MATLAB 7 '  ONLY 
UNRAR THE CONTENTS  INTO "WORK" FOLDER OF  MATLAB.

THIS PROGRAM CONSTRUCTS  A '.YUV' FILE FROM THE INPUT BMP,TIFF FILE FORMATS.

1.subsampling 
2.level shifting --> dct -->quantization
3.dequantization-->idct--->level shifting
4.SNR calculations
5.writing decoded matrices into yuv file.
6.YUV FILE can be viewed using yuv players like 1)YUV TOOLS 2) ELECARD YUV VIEWER.(available for free download)
7.PLZ SELECT 420 SUBSAMPLING in yuv viewer and give appropriate resolution of the input image.
8.compare the size of input and reconstructed images.