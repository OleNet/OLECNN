function grad = numericalGrad4CNN(J, X, net)

%%
epsilon = 0.0001;
theta_grad_num = [];
count = 1;
for l = 1 : length(net.layer)
    if isfield(net.layer{l}, 'filter')
        
        theta = net.layer{l}.filter;
        
        for i = 1 : numel(theta)
            net_p = net;
            net_m = net;
            eps_mask = zeros(size(net_p.layer{l}.filter));
            eps_mask = eps_mask(i) + epsilon;
            net_p.layer{l}.filter(i) = net_p.layer{l}.filter(i) + eps_mask;
            net_m.layer{l}.filter(i) = net_m.layer{l}.filter(i) - eps_mask;
            Jpos = J(X, net_p);
            Jneg = J(X, net_m);
            theta_grad_num(count) = (Jpos-Jneg) / (2*epsilon);
            count = count + 1;
        end
    end
    
    if isfield(net.layer{l}, 'bias')
        bias = net.layer{l}.bias;
        for i = 1 : numel(bias)
            net_p = net;
            net_m = net;
            eps_mask = zeros(size(net_p.layer{l}.bias));
            eps_mask = eps_mask(i) + epsilon;
            net_p.layer{l}.bias(i) = net_p.layer{l}.bias(i) + eps_mask;
            net_m.layer{l}.bias(i) = net_m.layer{l}.bias(i) - eps_mask;
            Jpos = J(X, net_p);
            Jneg = J(X, net_m);
            theta_grad_num(count) = (Jpos-Jneg) / (2*epsilon);
            count = count + 1;
        end
    end
end



grad_theta = reshape(theta_grad_num, 1, []);
% grad_bias = reshape(bias_grad_num, 1, []);
grad = [grad_theta(:)];%; grad_bias(:)];

end
