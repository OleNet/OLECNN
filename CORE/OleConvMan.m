function [ X_, dw ] = OleConvMan( X, kernel )
%OLECONV Summary of this function goes here
%   Detailed explanation goes here
%   OleConvMan == convn(a,flipud(fliplr(kernel)),'valid')
%% 
stride = 1; % ?
pad = 0; % equals to invalid conv
nK = size(kernel, 4);

ncX = size(X, 3);
ncK = size(kernel, 3);
assert(ncX == ncK, 'kernel channel dosnt match X');
X = padarray(X, [pad, pad]);

[M N C P] = size(X);
[m n c p] = size(kernel);

for k = 1 : P
    for i = 1 : M
        for j = 1 : N
            if (i+m-1>M) || (j+n-1>N)
                continue;
            end
            
            for d = 1 : p % depth
                XmulK = X(i:i+m-1, j:j+n-1, :, k) .*(kernel(:,:,:,d));
                X_(i, j, d, k) = sum(XmulK(:));
            end
            
        end
    end
end



%% Gradient
% dz = (1-z) .* z;
% dwx = dz .* 1;
% dw = X .* dz;
% grad = dw;
end

