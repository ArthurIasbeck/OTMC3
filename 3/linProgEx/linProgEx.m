init;

% As restrições são representadas matricialmente, logo, cada linha da
% matriz A representa uma retrição de desigualdade, enquanto cada linha da
% matriz Aeq representa uma restrição de igualdade. 

% Restrições de desigualdade
A = [1 1
    1 1/4
    1 -1
    -1/4 -1
    -1 -1
    -1 1];
b = [2 1 2 1 -1 2];

% Restrições de igualdade
Aeq = [1 1/4];
beq = 1/2;

lb = [-1,-0.5];
ub = [1.5,1.25];

f = [-1 -1/3];

x = linprog(f,A,b,Aeq,beq,lb,ub)