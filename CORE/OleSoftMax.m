function [Prop, J, delta_lm1, dfilter] = OleSoftMax(X, filter, y, der)
%%
% X : n * m
% filter n * k 
% k class num
% m sample num
% n feature num

Mx = size(X, 4);
Mf = size(filter, 4);

filter_ = reshape(filter, [], Mf);  % n * k
X_ = reshape(X, [], Mx);            % n * m

assert(size(filter_,1) == size(X_, 1), 'feature num != image feature.Hint: Is X 1x1xNxM?>');

Z = filter_' * X_;                  % k * m

maxZ = max(Z,[],1);                 % k * 1
Zoffset = bsxfun(@minus, Z, maxZ);  % k * 1 Attention! minux after filter*X!
A = exp(Zoffset);                   % k * 1
oneHotMask = full(sparse(y, 1:Mx, 1));% k * m
sumA = sum(A, 1);                   % 1 * m              
Prop = bsxfun(@rdivide, A, sumA);   % k * m
logProp = log(Prop);                % k * m
maskedlogProp = oneHotMask.*logProp;% k * m
J = (-1/Mx) * sum(maskedlogProp(:)); % 1 * 1 scalar


delta = [];
dfilter = [];
if nargin == 4
    delta = -(oneHotMask - Prop);
    dfilter = -(1/Mx) * (X_ * (oneHotMask - Prop)');
    delta = reshape(delta, size(Z));
    delta_lm1 = (filter_ * delta);
    dfilter = reshape(dfilter, size(filter));
    delta_lm1 = reshape(delta_lm1, size(X));
end

end

