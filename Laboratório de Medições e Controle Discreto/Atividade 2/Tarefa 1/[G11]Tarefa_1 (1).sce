clear all
clc 

// Grupo
// Gabriel de Sousa Araujo - 9299341 - gabriel_araujo@usp.br
// Gustavo Lopes Oliveira - 10335490 - gustavo.l.oliveira@usp.br
// Herval Pereira de Castro Junior - 10335792 - hervalcastro@usp.br
// Leonardo Silva Almeida Serra - 10335656 - leonardoserra@usp.br
// Lucas Hideki Takeuchi Okamura - 9274315 - lucasokamura@gmail.com

//// Tarefa 1 ////

// Importação de dados

base_path = pwd(); // Diretório atual onde o programa está

dataframe1 = base_path + "\c1.csv"

dataframe = csvRead(dataframe1,[],[],"string"); 

// Parâmetros do Ensaio 

med = length(strtod(dataframe(:,1),",")); //Quantidade de medidas

time = 12.211; // Duração do ensaio, registrados abaixo para os 3 ensaios realizados
// C1 = 12.211
// C2 = 8.593
// C3 = 11.106

t = linspace(0,time,med); // vetor tempo

// Identifica-se que a coordenada Z do telefone corresponde à variavel de interesse no problema, que é a aceleração normal ao plano do celular, logo

z = strtod(dataframe(:,5),",")/1000; // vetor de entradas de interesse + correção de unidades

disp(z)

// Transformada rápida de Fourier 
freq_a = 413; //frequência de amostragem do aplicativo

df = 1/(med*(1/freq_a));
f = 0:df:df*(med-1); // vetor de frequencias

Y = fft(z,-1) // transformada

// Item A - Aceleração no tempo

figure(1); 
plot(t,z)

plot(t,0,"-")
title("Item A - Aceleração no tempo")
xlabel("Tempo(s)");
ylabel("Aceleração no eixo Z");



// Item B - Espectros de frequências

figure(2); 
plot(f,Y)
title("Item B - Espectros de frequências")
xlabel("Frequência(Hz)");
ylabel("Espectro de potência");

// Item C - Frequências Naturais

// Observamos nos 3 ensaios realizados que a frequência mais relevante no espectro de potência é por volta de 3Hz, o que corresponde à frequencia natural de oscilação do sistema massa-mola-amortecedor, construido no experimento com uma régua e um telefone celular. Intuitivamente, esse valor de 3Hz faz sentido ser a frequência de oscilação do sistema, dada a observação qualitativa realizada










