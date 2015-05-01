function [f, grad] = grad(x, y)

%% FF 
sigy = OleSigmoid(y);           %1
numerator = x + sigy;           %2
sigx = OleSigmoid(x);           %3
xpy = (x+y);                    %4
xpySquare = xpy.^2;             %5
denominator = sigx + xpySquare; %6
inv = 1./denominator;           %7
f = numerator .* inv;           %8

%% BP
dnumerator = inv;%8
dinv = numerator;%8

ddenominator = -1 ./ (denominator.^2) .* dinv; %7

dsigx = ddenominator;%&6
dxpySquare = ddenominator;%6

dxpy = 2 * xpy .* dxpySquare;%5

dx = dxpy;%4
dy = dxpy;%4

dx = dx + dsigx .* sigx .* (1-sigx);%3

dx = dx+ dnumerator;%2
dsigy = dnumerator;%2

dy = dy + dsigy .* (1-sigy) .* sigy;%1

grad = [dx, dy];
