function gamma = gammacalc(n,d,lambda,theta)
M = size(n,2)-2;                                                        % numero de camadas (sem contar as camadas externas)
n1sen_2 = (n(1,1)*sind(theta))^2;                                       %              
c_i = sqrt(1 - n1sen_2 ./ n(1,:).^2);                                   % calculo da lei de snell, n(1,:) refere-se a todos os elementos da primeira linha de n
nt = n(1,:) .* c_i;                                                     % transformando indice de refração para o indice de refração transverso
reflex = -diff(nt) ./ (2*nt(1:end-1) + diff(nt));                       % transforma indice de refração para coeficiente de reflexão
d = d .* c_i(1:M);                                                      %
gamma = reflex(M+1) * ones(1,length(lambda));                           % gamma na ultima camada (da esquerda para direita)
for i = M:-1:1                                                          % nossa referencia começa na ultima camada e vai voltando 
    B = 2*pi*d(i)./lambda;                                              % constante de fase na i-ézima camada
    expz = exp(-2*1i*B);                                                %
    gamma = (reflex(i) + gamma.*expz) ./ (1 + reflex(i)*gamma.*expz);   % variavel de retorno da função, recebendo o devido tratamento algebrico
end