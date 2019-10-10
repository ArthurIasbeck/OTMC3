init;

addpath('..');

% Definição da função objetivo e de seu gradiente
k1 = 2;
k2 = 2.5;
k3 = 1.5;
F = 50;

f = @(x) 0.5*k2*x(1).^2 + 0.5*k3*(x(2) - x(1)).^2 + 0.5*k1*x(2).^2 ...
    - F*x(2);

df = @(x) [k2*x(1) - k3*(x(2) - x(1))
           k3*(x(2) - x(1)) + k1*x(2) - F];

% Parâmetros pra execução do algorítmo
x0 = [0, 0]';
tol = 1e-4;

% Variáveis para controle de execução
alfaOptValues = zeros(1,1);
k = 1;
nVal = 0;

while 1 
    % Reduzir a dimensão do problema de otimização
    f1 = @(alfa) f(x0 - alfa.*df(x0));
    
    % Resolver o problema de otimização uni-dimensional
    [alfaOpt,~,nVal1] = aureaSec(f1,-1,1,1e-4);
    
    % Atualizar a solução ótima
    x = x0 - alfaOpt.*df(x0);
    
    % Armazenar dados de execução 
    alfaOptValues(k) = alfaOpt;
    nVal = nVal + nVal1;
    
    % Verificar a condição de parada
    cp = norm(x - x0);
    if cp < tol
        break;
    end
   
    % Atualizar variáveis para a próxima iteração
    x0 = x;
    
    k = k + 1;
end

% TODO: O próximo passo é implementar o Método da Variável Métrica pra
% resolver este mesmo problema, uma vez que eu já sei o resultado esperado.
xOpt = x;
fOpt = f(xOpt);

for i = 1:length(x)
    fprintf(['x',num2str(i),'* = %.4f\n'], xOpt(i));
end

fprintf('f(x*) = %.4f\n', fOpt);
fprintf('nval = %d\n', nVal);