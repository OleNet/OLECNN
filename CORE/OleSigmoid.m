function [ Y, dx, delta_lm1 ] = OleSigmoid( X, delta_lp1 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%%
Y = 1 ./ (1 + exp( -X ));

if nargin == 2
    dx = Y .* (1-Y);
    delta_lm1 = delta_lp1;
end
end

