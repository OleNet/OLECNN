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
            [res{i+1}.X]  = OleConvMan(res{i}.X, net.layer{i}.filter, net.layer{i}.bias);
        case 'sigmoid'
            [res{i+1}.X] = OleSigmoid(res{i}.X);  
        case 'softmax' 
            [res{i+1}.Prop, res{i+1}.X] =  OleSoftMax(res{i}.X, net.layer{i}.filter, net.layer{i}.bias, y);
       
        otherwise
       
    end
    
i = i + 1;
end


i = i - 1;
while i > 0
    switch net.layer{i}.type
        case 'conv'
            [~, res{i}.delta, res{i}.dfilter, res{i}.dbias]  = OleConvMan(res{i}.X, net.layer{i}.filter, net.layer{i}.bias, res{i+1}.delta, res{i+1}.dx);
        case 'sigmoid'
            [~, res{i}.dx, res{i}.delta] = OleSigmoid(res{i}.X, res{i+1}.delta);
        case 'softmax'
            [~, ~, res{i}.delta, res{i}.dfilter, res{i}.dbias] =  OleSoftMax(res{i}.X, net.layer{i}.filter, net.layer{i}.bias, y, 1);

        otherwise
    end
    i= i - 1;
end


%% Update Weight
yita = 500;
for i = 1 : length(net.layer)
    if isfield(res{i}, 'dfilter')
        net.layer{i}.filter = net.layer{i}.filter - yita * res{i}.dfilter;
        %     disp(net.layer{i}.filter(1));
    end
    
    if isfield(res{i}, 'dbias')
        net.layer{i}.bias = net.layer{i}.bias - yita * res{i}.dbias;
    end
end

score = 0;
end

%         case 'pool'
%             [res{end+1}.X, res{end+1}.dx] = OlePool(res{end}.X, net.layer{i}.size, res{end+1}.dx);
%         case 'relu' 
%             [res{end+1}.X, res{end+1}.dx] = OleRelu(res{end}.X, res{end+1}.dx);
