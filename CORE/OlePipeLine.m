function [ res, net ] = OlePipeLine( X, net, y )
%OLEFF Summary of this function goes here
%   Detailed explanation goes here

%% 
i = 1;
blob = [];
res{1}.X = X; %input layer
while i <= length(net.layer)
    switch net.layer{i}.type
        case 'conv' 
            [res{i+1}.X]  = OleConvMan(res{i}.X, net.layer{i}.filter);
        case 'softmax' 
            [res{i+1}.Prop, res{i+1}.X] =  OleSoftMax(res{i}.X, net.layer{i}.filter, y);
        otherwise
    end
    
i = i + 1;
end


i = i - 1;
while i > 0
    switch net.layer{i}.type
        case 'conv'
            [~, res{i}.delta, res{i}.dfilter, ]  = OleConvMan(res{i}.X, net.layer{i}.filter, res{i+1}.delta);
        case 'softmax'
            [~, ~, res{i}.delta, res{i}.dfilter] =  OleSoftMax(res{i}.X, net.layer{i}.filter, y, 1);
        otherwise
    end
    i= i - 1;
end

%% Update Weight
yita = 500;
for i = 1 : length(net.layer)
    net.layer{i}.filter = net.layer{i}.filter - yita * res{i}.dfilter;
    disp(net.layer{i}.filter(1));
%     net.layer{i}.bias = net.layer{i}.bias - yita * res{i}.bias;
end

score = 0;
end

%         case 'pool'
%             [res{end+1}.X, res{end+1}.dx] = OlePool(res{end}.X, net.layer{i}.size, res{end+1}.dx);
%         case 'relu' 
%             [res{end+1}.X, res{end+1}.dx] = OleRelu(res{end}.X, res{end+1}.dx);
