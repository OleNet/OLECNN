function [ output_args ] = testCnnSanity( input_args )
%TESTCNN 此处显示有关此函数的摘要
%   此处显示详细说明

testIt(@ testSoftmaxAnalytic);
testIt(@ testOleConvMan );
testIt(@ testCnnPipeline);
end


%%
function testIt(fun)
funcName = upper(func2str(fun));
ret = fun();
if ret == 1
    fprintf( 'Congratulations! %s test passed!\n', funcName);
else
    fprintf( 'Sadlly! %s test NOT passed\n', funcName);
end
end