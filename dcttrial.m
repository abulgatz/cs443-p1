function dctCoeffs = dcttrial(image)
tic
image = double(rgb2gray(image));
[M,N] =size(image);
dctCoeffs = zeros(size(image));
for p=1:1:M
    for q = 1:1:N
        dctSum = 0;
        if p==1
            alphaP = sqrt(1/M);
        else
            alphaP = sqrt(2/M);
        end
        if q==1
            alphaQ = sqrt(1/N);
        else
            alphaQ = sqrt(2/N);
        end
        for m=1:1:M
            for n=1:1:N
                dctSum = dctSum + (image(m,n)*cos(pi*(2*m + 1)*(p/(2*M)))*cos(pi*(2*n + 1)*(q/(2*N))));
            end
        end
        dctCoeffs(p,q) = alphaP*alphaQ*dctSum;
    end
end
toc

        
