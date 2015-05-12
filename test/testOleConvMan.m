function [ X_, dw ] = testOleConvMan

%%
X = randi(4, [4, 4, 2, 1]);
kernel = rand([3, 3, 2, 2]);
X_ = OleConvMan( X, kernel );

nK = size(kernel, 4);
y = vl_nnconv(single(X), single(kernel), []);

if isequal(fix(y*1000),fix(X_*1000))
    display('test passed!');
else
    display('check it again!');
end
end
