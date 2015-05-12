function net = InitModel2()

%%
net = [];
net.layer = {};
net.layer{end+1} = struct('type', 'conv', ...
                    'filter', rand(3,3,3,10));
                
net.layer{end+1} = struct('type', 'conv', ...
                    'filter', rand(3,3,3,10));
                
net.layer{end+1} = struct('type', 'softmax', ...
                        'filter', rand(3,3,3,10)); %??
end