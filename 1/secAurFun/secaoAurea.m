init; 
format long g

% Função objetivo
w = 2.5;
L = 600;
E = 50000;
I = 30000;
f = @(x) (w/(120*E*I*L))*(-x.^5 + 2*L^2*x.^3 - L^4*x);

% Parâmetros do algorítmo
a = 0;
b = 600;
tol = 1e-8;

[xOpt, fOpt, k] = aureaSec(f,a,b,tol);

% Para utilizar uma função que esteja escrita em um arquivo, basta utilizar
% [xOpt, fOpt, k] = aureaSec(@funcFile,a,b,tol);

fprintf('x* = %.4f\n', xOpt);
fprintf('f(x*) = %.4f\n', fOpt);
fprintf('k = %d\n', k);

figure; x = linspace(0,600); plotI(x,f(x),'-'); hold on;
plotI(xOpt, fOpt, 'o');
titleI('$f(x)$');
xlabelI('$x$');
ylabelI('$f$');
cropPlotI;
axisComma;
printI('secAur');