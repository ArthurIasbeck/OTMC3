function F = funcFile(x)
    w = 2.5;
    L = 600;
    E = 50000;
    I = 30000;
    F = (w/(120*E*I*L))*(-x.^5 + 2*L^2*x.^3 - L^4*x);
end