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

base_path = pwd()
dataframe1 = base_path + "\teste.csv"

dataframe = csvRead(dataframe1,';') // mudar aqui qual arquivo analisar

// Parâmetros do Ensaio 
// Foram realizados 3 ensaios com as seguintes durações:
// Ensaio 1 : 16,3 segundos
// Ensaio 2 : 21,1 segundos
// Ensaio 3 : 12,2 segundos
// Foi escolhido o ensaio 3 devido a maior clareza na observação dos ruídos

med = length(dataframe(:,5)) //Quantidade de medidas

time = 18; // Duração do ensaio, registrados abaixo para os 3 ensaios realizados

t = linspace(0,time,med) // vetor tempo

// Identifica-se que a coordenada Z do telefone corresponde à variavel de interesse no problema, que é a aceleração normal ao plano do celular, logo

z = dataframe(:,6)/1000; // vetor de entradas de interesse + correção de unidades

// Item A - Aceleração no tempo

// Para o experimento realizado, importa apenas a aceleracao no eixo z, paralelo a gravidade.

figure(1); 
plot(t,z)
title("Item A - Aceleração no tempo")
xlabel("Tempo(s)");
ylabel("Aceleração no eixo Z");

// Item B - Espectros de frequências

// Transformada rápida de Fourier 
freq_a = 64; //frequência de amostragem do aplicativo

df = 1/(med*(1/freq_a))
f = 0:df:df*(med-1); // vetor de frequencias

Z = fft(z) // transformada de Fourier

figure(2); 
plot(f,Z)
title("Item B - Espectro de frequências")
xlabel("Frequência(Hz)")
ylabel("Espectro de potência")
//h = gca()
//h.data_bounds = [0, -30 ; 65, 50]

// Item C - Frequências Naturais


// Item D - Filtro Digital

Fcorte1 = 9  //Frequência de corte inferior
Fcorte2 = 12  //Frequência de corte superior
tau1 = 1/Fcorte1
tau2 = 1/Fcorte2

// Calculando o Filtro
s = poly(0, "s")

// Será feito um filtro passa-bandas com frequências de corte de 9 e 11 Hz
filtro = syslin("c", (1/(tau2*s + 1)))
filtro_dls = dscr(filtro, 1/freq_a)
filtro = ss2tf(filtro_dls)

disp(filtro)
z_f = flts(z',filtro_dls)
// Aceleração no tempo do sinal filtrado
figure(3)
plot(t,z_f)
title("Item D - Aceleração no tempo (filtrado)")
xlabel("Tempo(s)")
ylabel("Aceleração no eixo Z")

//Resposta em Frequência do filtro
Z_f = fft(z_f)

figure(4)
plot(f,Z_f)
title("Item D - Espectro de frequências (filtrado)")
xlabel("Frequência (Hz)")
ylabel("Espectro de potências")
//h = gca()
//h.data_bounds = [0, -40 ; 65, 30]

// Item E - Relatorio
