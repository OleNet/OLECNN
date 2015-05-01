function [ h ] = OleSoftMaxLoss( X, filter, Y)
%OLESOFTMAX Summary of this function goes here
%   Detailed explanation goes here

%%
% m sample num
% n feature num
h = OleSoftMax(X, filter);

loss = OleSquareLoss(h, y);


end

