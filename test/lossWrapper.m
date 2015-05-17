function [loss, dtheta] = lossWrapper(X, net, y)


%%
[ res ] = OlePipeLine( X, net, y );
loss = res{end}.X;
dfilter = [];
for i = 1 : length(res)
    if isfield(res{i}, 'dfilter')
        dfilter = [dfilter; res{i}.dfilter(:)];
    end
end
dtheta = reshape(dfilter, 1, []);
end