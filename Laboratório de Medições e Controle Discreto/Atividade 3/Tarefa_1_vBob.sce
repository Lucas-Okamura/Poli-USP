clear all
clc 
close 
//---------------------------------------//
//Integrantes
//Clara Mayumi Bertolino Hamada - 9348182
//Mateus Verdeja Garcia - 10332761
//Paulo Montijo Bandeira - 9348449
//Ricardo Gonçalves Ruano - 8992408
//---------------------------------------//

//Informações do acelerômetro do Samsung SM-A520F 
//Fabricante: STM
//Modelo: K6DS3TR
//Sampling rate: 195.2 Hz

//Importar dados do arquivo .csv para a matriz "data"
data = csvRead("C:\Users\Bob\Desktop\Medicoes\Tarefa 1\Testes\teste4.csv",[],[],"string"); 
//Observação: o diretório dos arquivos deve ser alterado conforme o teste. Para isto,
//deve-se apertar Shift + botão direito do mouse e selecionar a opção "Copy as path" ou 
//copiar como caminho

//Quantidade de pontos coletados no ensaio
pts = length(strtod(data(:,1),","));

//Tempo decorrido no ensaio (fornecido pelo app para cada teste, deve ser dado como entrada pelo usuário)
//Ensaio 1: 18.234 s 
//Ensaio 2: 21.465 s 
//Ensaio 3: 22.286 s
//Ensaio 4: 23.567 s 
//Ensaio 5: 25.379 s 

time = 23.567;
t = linspace(0,time,pts);

//Vetores correspondentes a cada coordenada (x,y,z)
x = strtod(data(:,3),",")+0.67;
y = strtod(data(:,4),","); 
z = strtod(data(:,5),",");

//Observação: construindo o gráfico para coordenada, nota-se que 
//a mais representativa do fenômeno físico em questão é a coordenada "x",
//a qual será adotada nos gráficos de sinal e espectro de potência

//---------Tarefa 1---------//

//Item a)faça gráficos mostrando cada um dos sinais capturados em função do tempo. Utilize janelas temporais que permitam a visualização clara do sinal capturado. 

//Sinal completo
figure(1); 
plot(t,x) 
title("Item a - sinal em função do tempo")
xlabel("Tempo(s)");
ylabel("Amplitude do sinal");

//Sinal obtido a partir da interrupção das excitações externas

//Cada teste possui um intervalo "mod", relacionado abaixo e que deve ser substituído de acordo para geração dos vetores t1,x1 

//Teste 1: 605:750
//Teste 2: 680:810
//Teste 3: 726:872
//Teste 4: 785:937
//Teste 5: 822:1001

mod = 605:750;
t1 = t(1,mod) //Cria-se novo vetor de tempos. 
x1 = x(mod,1) //Cria-se novo vetor de pontos. 

figure(2); 
plot(t1,x1)
title("Item b - sinal obtido após interrupção das excitações")
xlabel("Tempo(s)");
ylabel("Amplitude");


//Item b) obtenha os espectros de frequências (ou espectros de potência) dos sinais adquiridos.

//Aplicação da transformada rápida de Fourier ao sinal

freq_aq = 195.2; //frequência de amostragem 
Y = abs(fft(x,-1))

df = 1/(pts*(1/freq_aq));
f = 0:df:df*(pts-1);

figure(3); 
plot(f,Y)
title("Item b - espectro de potência do sinal")
xlabel("Frequência(Hz)");
ylabel("Espectro de potência");
h = gca();
h.data_bounds = [0, 0; 50,max(Y)+10];//limitação do espectro para melhor visualização 

figure(4);
Y1 = abs(fft(x1,-1))
pts = length(t1)
df = 1/(pts*(1/freq_aq));
f1 = 0:df:df*(pts-1);
plot(f1,Y1)
title("Item b - espectro de potência do sinal após interrupção das excitações")
xlabel("Frequência(Hz)");
ylabel("Espectro de potência");
h = gca();
h.data_bounds = [0, 0; 50,max(Y1)+10]; //limitação do espectro para melhor visualização 


//Item c) Identifique, tanto nos sinais temporais quanto nos espectros, as frequências naturais, relacionando-as com os modos de vibrar das estruturas/dispositivos ensaiados, ou as frequências de interesse, caso o experimento não envolva os modos de vibração do sistema ensaiado.

//No sinal temporal anterior ao amortecimento, é possível identificar uma 
//frequência de excitação da ordem de 1.5 Hz. Este valor é proposital, uma 
//vez que a maioria dos carros de passeio são projetados para frequências 
//entre 1 a 1.5 Hz para atender à especificações de conforto em "Ride".
//Outro fator a ser identificado é o amortecimento nos instantes em que o
//veículo já não é submetido às excitações na carroceria, no intervalo de 
//tempo localizado nos instantes finais de cada ensaio. Em observação,
//trata-se de uma oscilação subamortecida, para o qual tem-se a 
//expressão x(t) = exp(-y*t)*A*cos(w*t). Para o teste 2, por exemplo, 
//é possível extrair que w = 9.92 rad/s e o coeficiente de amortecimento 
//de aproximadamente 0.71, que sendo inferior a 1 corrobora para a hipótese 
//de que o amortecimento é subamortecido. 


Ordem = 2; //ordem do filtro
Fs    = 195.2; // Frequência de Amostragem
Fcorte1 = 10; //Frequência de corte inferior
Fcorte2= 0;   //Frequência de corte superior

//Calculando o Filtro
//Filtros Passa-Baixa(lp), Passa-Alta(hp), Passa-faixa(bp)
//Rejeita-faixa(sb)
//Filtros Elípticos (ellip), Butterworth (butt), Chebyshev(cheb1 ou cheb2)
hz=iir(Ordem,'lp','butt',[Fcorte1/Fs Fcorte2/Fs],[0.1 0.1]);

//Resposta em Frequência do filtro

figure(6);
sl = tf2ss(hz);
w = flts(x',sl);
plot(t,w);













