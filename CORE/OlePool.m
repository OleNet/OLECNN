function [ Y ] = OlePool( X, wndSize )
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

end