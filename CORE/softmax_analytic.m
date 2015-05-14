function [J, dfilter] = softmax_analytic(X, filter, y, m, n, k)
%%
% X : n * m
% filter n * k 
% k class num
% m sample num
% n feature num

Z = filter' * X;
maxZ = max(Z,[],1);
Zoffset = bsxfun(@minus, Z, maxZ); % Attention! minux after filter*X!
A = exp(Zoffset);
oneHotMask = full(sparse(y, 1:m, 1));
sumA = sum(A, 1);
Prop = bsxfun(@rdivide, A, sumA);
logProp = log(Prop);
maskedlogProp = oneHotMask.*logProp;
J = (-1/m) * sum(maskedlogProp(:));

dfilter = (-1/m) * (X * (oneHotMask - Prop)');

end

