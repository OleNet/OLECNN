function grad = numerical_grad(J, X, theta)

%%
epsilon = 0.0001;
temp = zeros(size(theta));
for i = 1 : numel(theta)
    temp(i) = temp(i) + epsilon;
    Jpos = J(X, theta+temp);
    Jneg = J(X, theta-temp);
    theta_grad_num(i) = (Jpos-Jneg) / (2*epsilon);
    temp(i) = 0;
end

grad = reshape(theta_grad_num, size(theta));
end