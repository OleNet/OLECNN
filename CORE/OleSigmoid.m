function [ Y ] = OleSimgoid( X )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

Y = 1 ./ (1 + exp( -X ));

end

