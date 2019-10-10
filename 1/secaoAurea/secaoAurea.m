init; 
format long g

a = 0;
b = 600;
tal = 0.618;
cp = 1e-8;

alfa = a + (1 - tal)*(b - a);
beta = a + tal*(b - a);
fAlfa = f(alfa);
fBeta = f(beta);

k = 1;

while abs(a-b) > cp
    if fBeta < fAlfa 
        a = alfa;
        alfa = beta;
        fAlfa = fBeta;
        beta = a + tal*(b - a);
        fBeta = f(beta);
    elseif fAlfa <= fBeta
        b = beta;
        beta = alfa;
        fBeta = fAlfa;
        alfa = a + (1 - tal)*(b - a);
        fAlfa = f(alfa);
    end
    k = k + 1;
end

xOpt = (alfa+beta)/2;
fOpt = f(xOpt);

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