function net = InitModel()

%%
net = [];
net.layer = {};
net.layer{end+1} = struct('type', 'conv', ...
                    'filter', rand(3,3,3,10), ...
                    'bias', rand(1,10));
                
% net.layer{end+1} = struct('type', 'pool', ...
%                      'size', [2,2]);
% 
% net.layer{end+1} = struct('type', 'relu');

net.layer{end+1} = struct('type', 'softmax', ...
                        'filter', rand(1,1,10,2),...
                        'bias', rand(1, 2)); %??
end