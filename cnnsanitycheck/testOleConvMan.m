function [ ret ] = testOleConvMan(m, n, k)

%%
X = randi(4, [4, 4, n, m]);
kernel = rand([3, 3, n, k]);
bias = zeros([1, k]);
X_ = OleConvMan( X, kernel, bias );

nK = size(kernel, 4);
y = vl_nnconv(single(X), single(kernel), []);

if isequal(fix(y*1000),fix(X_*1000))
    ret = 1;
else
    ret = 0;
end

end
