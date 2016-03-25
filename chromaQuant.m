function dctImg = chromaQuant(dctImg)
Cq = [ 17, 18, 24, 47, 99, 99, 99, 99;
    18, 21, 26, 66, 99, 99, 99, 99;
    24, 26, 56, 99, 99, 99, 99, 99;
    47, 66, 99, 99, 99, 99, 99, 99;
    99, 99, 99, 99, 99, 99, 99, 99;
    99, 99, 99, 99, 99, 99, 99, 99;
    99, 99, 99, 99, 99, 99, 99, 99;
    99, 99, 99, 99, 99, 99, 99, 99 ];

dctImg = double(dctImg);
Cq = double(Cq);

imgSize = size(dctImg(:,:,3));
CqSize = size(Cq);
sizeRatio = ceil(imgSize ./ CqSize);
compareMatrix = repmat(Cq, sizeRatio);
compareMatrix = compareMatrix(1:imgSize(1), 1:imgSize(2)); % trim

dctImg(:,:,2) = round(dctImg(:,:,2) ./ compareMatrix);
dctImg(:,:,3) = round(dctImg(:,:,3) ./ compareMatrix);


end