function grad = numericalGrad(J, X, theta, bias)

%%
epsilon = 0.0001;
temp = zeros(size(theta));
for i = 1 : numel(theta)
    temp(i) = temp(i) + epsilon;
    [~, Jpos] = J(X, theta+temp, bias);
    [~, Jneg] = J(X, theta-temp, bias);
    theta_grad_num(i) = (Jpos-Jneg) / (2*epsilon);
    temp(i) = 0;
end

temp = zeros(size(bias));
for i = 1 : numel(bias)
    temp(i) = temp(i) + epsilon;
    [~, Jpos] = J(X, theta, bias+temp);
    [~, Jneg] = J(X, theta, bias-temp);
    bias_grad_num(i) = (Jpos-Jneg) / (2*epsilon);
    temp(i) = 0;
end

grad_theta = reshape(theta_grad_num, size(theta));
grad_bias = reshape(bias_grad_num, size(bias));
grad = [grad_theta(:); grad_bias(:)];
end