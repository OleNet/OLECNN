function [ h, J, dfilter] = OleSoftMaxChain( X, filter, y )
%OLESOFTMAX Summary of this function goes here
%   Detailed explanation goes here

%%
% X : n*m
% filter n * k
% k class num
% m sample num
% n feature num
m = size(X, 2);
mu = max(X); % 1 * n matrix


%% hypothesis
XMulFil = filter' * X;
maxXMulFil = max(XMulFil, [], 1);
for i = 1 : m
    Xminmax(:,i) = (XMulFil(:,i)-maxXMulFil(i)); % Xminmu is col vector
end
Z = exp(Xminmax);
den = sum(Z); % each col contains all the pred for respective class
invden = 1./den;
for i = 1 : m
    prop(:, i) = Z(:, i) * invden(i);
end
onehot_y = full(sparse(y, 1:m, 1));
logprop = log(prop);
logpropMasked = onehot_y.*logprop;
sumViaClass = sum(logpropMasked);
sumViaSample = sum(sumViaClass);
J = (-1/m)*sumViaSample;


%% gradient
dsumViaSample = (-1/m);
dsumViaClass = dsumViaSample * 1;
dlogpropMasked = dsumViaClass * 1;
dlogprop = dlogpropMasked .* onehot_y;
dprop = dlogprop .* (1./prop);
for i = 1 : m
    dZ(:, i) = dprop(:, i) * invden(i);
    dinvden(:, i) = dprop(:, i)' * Z(:, i);
end
dden = (-1) * dinvden .* (den.^(-2));
dZ = dden * 1;
dXminmax = dZ * Z;
for i = 1 : m
    dmaxXmulFil = dXminmax(:, i) * (-1);
end
dXmulFil = dmaxXmulFil; %?
dfilter = dXmulFil * X;


end


