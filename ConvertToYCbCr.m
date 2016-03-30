function [image] = ConvertToYCbCr(image)
    image = im2double(image);
    T1 = [0.299 0.587 0.144;-0.168736 -0.331264 0.5; 0.5 -0.418688 -0.081312];
    matrixToAdd = [0;0.5;0.5];
    [ht wd h] = size(image);
    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);
    for i=1:ht
        for j=1:wd 
            RGB = [R(i,j);G(i,j);B(i,j)];
            A = T1 * RGB + matrixToAdd;
            Y(i,j) = A(1,1);
            Cb(i,j) = A(2,1)*255;
            Cr(i,j) = A(3,1)*255;
        end
    end
	
	image(:,:,1) = Y;
	image(:,:,2) = Cb;
	image(:,:,3) = Cr;
end