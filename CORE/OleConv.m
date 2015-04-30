function [ a ] = OleConv( X, kernel )
%OLECONV Summary of this function goes here
%   Detailed explanation goes here

%% 
stride = 1; % ?
nK = size(kernel, 4);

ncX = size(X, 3);
ncK = size(kernel, 3);
assert(ncX == ncK, 'kernel channel dosnt match X');

z = [];
for i = 1 : nK
    z = cat(3, z, convn(X, kernel(:,:,:,i), 'valid'));
end

a = OleSigmoid(z);

end

