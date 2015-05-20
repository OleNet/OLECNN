function [ Y, delta_lm1, dkernel, dbias ] = OleConvMan( X, kernel, b, delta, dx )
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
X_pad = padarray(X, [pad, pad]);

[M N C P] = size(X_pad);
[m n c p] = size(kernel);

for k = 1 : P
    for i = 1 : M
        for j = 1 : N
            if (i+m-1>M) || (j+n-1>N)
                continue;
            end
            
            for d = 1 : p % depth
                XmulK = X_pad(i:i+m-1, j:j+n-1, :, k) .*(kernel(:,:,:,d));
                X_(i, j, d, k) = sum(XmulK(:))+ b(p);
            end
            
        end
    end
end

Y = X_;
%Y = OleSigmoid(X_);

%% 
delta_lm1 = [];
dkernel = [];
dbias = [];

if exist('delta', 'var')
    delta = dx .* delta;
    delta_re = reshape(delta, size(X_));
    delta_lm1 = dx .* delta_re;
    
    X_lm1 = X;
    
    %rot180(conv2(X_lm1, rot180(delta_l), 'valid'));
    dkernel = zeros(size(kernel));
    for i = 1 : p
        for j = 1 : c
            for ii = 1 : P
                dkernel(:,:,j,i) = dkernel(:,:,j,i) + conv2(X_lm1(:,:,j,ii), rot180(delta(:,:,i,ii)), 'full');
            end
        end
    end
    dkernel = (1/P) * dkernel;
    dbias = (1/P) * squeeze(sum(delta, 4))';
end

end

function ma_ = rot180(ma)
ma_ = rot90(rot90(ma));
end
