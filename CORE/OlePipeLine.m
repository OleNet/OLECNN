function [ score] = OlePipeLine( X, net, y )
%OLEFF Summary of this function goes here
%   Detailed explanation goes here

%% 
i = 1;
blob = [];
res{1}.X = X; %input layer
while i <= length(net.layer)
    switch net.layer{i}.type
        case 'conv' 
            [res{end+1}.X]  = OleConvMan(res{end}.X, net.layer{i}.filter);
        case 'softmax' 
            [res{end+1}.X, res{end+1}.dx] =  OleSoftMax(res{end}.X, net.layer{i}.filter, y);
        otherwise
    end
    
i = i + 1;
end

while i > 0
        switch net.layer{i}.type
            case 'conv' 
                [res{end+1}.X, res{end+1}.dfilter, res{end+1}.delta]  = OleConv(res{end}.X, net.layer{i}.filter, res{end+1}.dx, res{i}.delta);
            case 'softmax' 
                [res{end+1}.X, res{end+1}.dfilter, res{end+1}.delta] =  OleSoftMax(res{end}.X, net.layer{i}.filter, y, 1);
            otherwise
end
    i= i - 1;
end

%% Update Weight
yita = 0.0001;
for i = 1 : length(net.layer)
    net.layer{i}.filter = net.layer{i}.filter - yita * res{i}.dilter;
    net.layer{i}.bias = net.layer{i}.bias - yita * res{i}.bias;
end

score = 0;
end

%         case 'pool'
%             [res{end+1}.X, res{end+1}.dx] = OlePool(res{end}.X, net.layer{i}.size, res{end+1}.dx);
%         case 'relu' 
%             [res{end+1}.X, res{end+1}.dx] = OleRelu(res{end}.X, res{end+1}.dx);
