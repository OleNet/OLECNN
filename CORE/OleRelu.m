function [ Y ] = OleRelu( X )
%OLERELU Summary of this function goes here
%   Detailed explanation goes here

%%
Y = X;
ind = Y < 0;
Y(ind) = 0;

end

