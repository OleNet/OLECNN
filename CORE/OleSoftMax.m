function [ h ] = OleSoftMax( X, filter )
%OLESOFTMAX Summary of this function goes here
%   Detailed explanation goes here

%%
% m sample num
% n feature num
mu = mean(X); % 1 * n matrix
pc = exp((X-mu) * filter);
den = sum(pc); % m * 1 matrix
den = repmat(den, [1, c]);
h = pc ./ den;


dfilter = ;

end

