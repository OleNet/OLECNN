function [J, dfilter, delta] = OleSoftMax(X, filter, y, der)
%%
% X : n * m
% filter n * k 
% k class num
% m sample num
% n feature num

M = size(X, 4);
filter_ = squeeze(filter);
X_ = squeeze(X);

Z = filter_' * X_;
maxZ = max(Z,[],1);
Zoffset = bsxfun(@minus, Z, maxZ); % Attention! minux after filter*X!
A = exp(Zoffset);
oneHotMask = full(sparse(y, 1:M, 1));
sumA = sum(A, 1);
Prop = bsxfun(@rdivide, A, sumA);
logProp = log(Prop);
maskedlogProp = oneHotMask.*logProp;
J = (-1/M) * sum(maskedlogProp(:));

if nargin == 4
    delta = -(oneHotMask - Prop);
    dfilter = (1/M) * (X_ * (oneHotMask - Prop)');
ene
end

