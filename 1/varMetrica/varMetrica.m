init;

addpath('..');

% Definição da função objetivo e de seu gradiente
n = 2; % Dimensão do problema
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
H = eye(n);

while 1 
    % Reduzir a dimensão do problema de otimização    
    % Matriz Hessiana análitica (Método de Newton)
%     H = [k2+k3 -k3
%          -k3 k1+k3];
     
    f1 = @(alfa) f(x0 - alfa*H*df(x0));
    
    % Resolver o problema de otimização uni-dimensional
    [alfaOpt,~,nVal1] = aureaSec(f1,-1,1,1e-4);
    
    % Atualizar a solução ótima
    x = x0 - alfaOpt*H*df(x0);
    
    % Armazenar dados de execução 
    alfaOptValues(k) = alfaOpt;
    nVal = nVal + nVal1;
   
    % Verificar a condição de parada
    cp = norm(x - x0);
    if cp < tol
        break;
    end
    
    % Computação de D para a próxima iteração
    x;
    x0;
    p = x - x0;
    y = df(x) - df(x0);
    sigma = p'*y;
    tal = y'*H*y;
    theta = 1;
    D = ((sigma + theta*tal)/sigma^2)*(p*p') ...
        + ((theta - 1)/tal)*(H*y)*(H*y)' ...
        - (theta/sigma)*(H*y*p' + p*(H*y)');
    
    H = H + D;
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