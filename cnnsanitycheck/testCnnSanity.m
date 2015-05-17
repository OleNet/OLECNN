function [ output_args ] = testCnnSanity( input_args )
%TESTCNN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

testIt(@ testSoftmaxAnalytic);
testIt(@ testOleConvMan );

end


%%
function testIt(fun)
funcName = upper(func2str(fun));
ret = fun();
if ret == 1
    fprintf( 'Congratulations! %s test passed!\n', funcName);
else
    fprintf( '%s test NOT passed\n', funcName);
end
end