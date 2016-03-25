function [dluma,copareluma, C] = dctbasis(image)
    [height, width] = size(image);
    N = 8;
    
    % N is the size of the NxN block being DCTed.
    % For this code, it does a 4x4, 8x8, and 16x16
    % Create C
    image = im2double(image);
    luma = image(:,:,1);
    
    C = zeros(N,N);
    
    
    for i=1:8:size(luma,1)-7
        for j=1:8:size(luma,2)-7
             C=luma(i:i+7,j:j+7);
             for m = 0:1:N-1
                for n = 0:1:N-1
                    if n == 0
                    k = sqrt(1/N);
                    else
                    k = sqrt(2/N);
                    end
                C(m+1,n+1) = k*cos( ((2*m+1)*n*pi) / (2*N));
                end
             end
            dluma(i:i+7,j:j+7) = C(1:8,1:8);
            copareluma(i:i+7,j:j+7)=dct2(luma(i:i+7,j:j+7));
        end
    end
   
    

%     Get Basis Functions
%     figure;
%     colormap('gray');
%     for m = 0:1:N-1
%         for n = 0:1:N-1
% %                 subplot(N,N,m*N+n+1);
%                 Y = [zeros(m,N);
%                 zeros(1,n) 1 zeros(1,N-n-1);
%                 zeros(N-m-1,N)];
%                 X = C'*Y*C;
%                 imagesc(X);
%                 axis square;
%                 axis off;
%         end
%     end
end
