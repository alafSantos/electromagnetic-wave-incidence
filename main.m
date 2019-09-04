clear all, clc; %limpa todas as variaveis e a janela de comandos tambem

prompt = {'Na:','Nb:'}; %titulos das caixas de texto edit�vel
dims = [1 50]; %dimens�o da caixa de texto
entrada = inputdlg(prompt,'Camadas Externas',dims); %variavel que guarda as entradas
N_a = double(str2num(entrada{1}));
N_b = double(str2num(entrada{2}));

prompt = {'N�mero de Camadas:','�ngulo de Incid�ncia:'}; %titulos das caixas de texto edit�vel
dims = [1 40]; %dimens�o da caixa de texto
entrada = inputdlg(prompt,'',dims); %variavel que guarda as entradas numa matriz
Num_Camadas = uint16(str2num(entrada{1})); %converte o numero de camadas para inteiro de 16 bits
angulo = double(str2num(entrada{2}));

f = linspace(0,4,1000); %vetor de frequencias igualmente espa�adas, iniciando de 0 e indo ate 4, contendo 1000 elementos
n(1,1) = N_a; n(1,Num_Camadas + 2) = N_b; %primeiro e ultimo meio

for b=1:(Num_Camadas)
    str1 = 'n';str2 = 'd'; %caracteres que ser�o somados abaixo no strcat
    str1 = strcat(str1,num2str(b),':'); %string para coeficiente de refra��o
    str2 = strcat(str2,num2str(b),':'); %string para espessura da camada
    prompt = {str1,str2}; %titulos das caixas de texto edit�vel
    dims = [1 20]; %dimens�o da caixa de texto
    entradas = inputdlg(prompt,'',dims); %variavel que guarda as entradas numa matriz
    n(1,b+1) = double(str2num(entradas{1})); %armazena o coeficiente de refra��o digitado pelo usuario, pulando o primeiro e ignorando o ultimo (sao ar)
    d(1,b) = double(str2num(entradas{2})); %guarda a espessura da camada digitada pelo usuario
end

G = gammacalc(n, d, 1./f, angulo); %chama a fun��o q calcula o gamma
subplot(3,1,1); plot(f,abs(G));axis([0 4 -1 1]); title('Reflex�o');%plotar o coef de reflex�o
xlabel('f/f0'); ylabel('\Gamma'); %titulos dos eixos
subplot(3,1,2); plot(f,abs(G+1));axis([0 4 -2 2]); title('Transmiss�o');%plotar o coef de transmiss�o
xlabel('f/f0'); ylabel('\tau');%titulos dos eixos
subplot(3,1,3); plot(f,(abs(G)+1)./(1-abs(G))); title('Rela��o de ondas estacion�rias'); %plotar o vswr
xlabel('f/f0'); ylabel('s');%titulos dos eixos
