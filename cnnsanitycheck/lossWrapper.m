function [loss, dtheta] = lossWrapper(X, net, y)


%%
[ res ] = OlePipeLine( X, net, y );
loss = res{end}.X;
dtheta = [];
for i = 1 : length(res)
    if isfield(res{i}, 'dfilter')
        dtheta = [dtheta; res{i}.dfilter(:);res{i}.dbias(:)];
    end
end

dtheta = reshape(dtheta, 1, []);
end