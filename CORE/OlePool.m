function [ Y, delta_l ] = OlePool( X, wndSize, delta_lp1 )
%OLEPOOL Summary of this function goes here
%   Detailed explanation goes here

%%
mode = 'max';
switch mode
    case 'max'  
        fun = @(block_struct) max(max(block_struct.data));
    case 'mean' 
        fun = @(block_struct) mean(mean(block_struct.data));
end

Y = blockproc(X, wndSize, fun);

if exist('delta_lp1', 'var')
    delta_l = kron(delta_lp1, ones(wndSize));
end

end