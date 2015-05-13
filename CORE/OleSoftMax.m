function [ h, J, dfilter] = OleSoftMax( X, filter, y )
%OLESOFTMAX Summary of this function goes here
%   Detailed explanation goes here

%%
% filter k * n
% k class num
% m sample num
% n feature num
m = size(X, 4);
mu = max(X); % 1 * n matrix
for i = 1 : m
    Xminmu(:,:,:,i) = (X(:,:,:,i)-mu(:,:,:,i)); % Xminmu is col vector
end
Xminmu = squeeze(reshape(Xminmu, 1, 1, [], m)); % Xminmu should be two col vector, n * m

%% hypothesis
XminMulFil = filter * Xminmu;
pc = exp(XminMulFil);
den = sum(pc); % each col contains all the pred for respective class
invden = 1./den;
for i = 1 : m
    h(:, i) = pc(:, i) * invden(i);
end
% h = bsxfun(@mul, , invden);

onehot_y = full(sparse(y, 1:m, 1));
logh = log(h);
J = (-1/m)*sum(sum(onehot_y.*logh));


%% gradient
dlogh = (-1/m)*sum(sum(onehot_y));
dh = dlogh*(1./h);
dinvden = pc*dh;
dpc = invden * dh;
dden = (-1) .* (den) .^(-2) * dinvden;
dpc = dpc + dden;
dXminMulFil = dpc * pc;
dfilter = dXminMulFil * Xminmu' ;

end

