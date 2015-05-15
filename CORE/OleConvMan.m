function [ X_, delta_l, dkernel, dbias ] = OleConvMan( X, kernel, delta_lp1 )
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

%% 
if exist('delta_lp1', 'var')
    delta_l = X_ .* delta_lp1;
    X_lm1 = X;
    dkernel = rot180(conv2(X_lm1, rot180(delta_l), 'valid'));
    dbias = sum(delta_l);
end
%% Gradient
% dz = (1-z) .* z;
% dwx = dz .* 1;
% dw = X .* dz;
% grad = dw;
end

function ma_ = rot180(ma)
ma_ = rot90(rot90(ma));
end
