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
dataframe1 = base_path + "\exp_ruido.csv"

dataframe = csvRead(dataframe1,';') // mudar aqui qual arquivo analisar

// Parâmetros do Ensaio 
// Foram realizados 3 ensaios com as seguintes durações:
// Ensaio 1 : 16,3 segundos
// Ensaio 2 : 21,1 segundos
// Ensaio 3 : 12,2 segundos
// Foi escolhido o ensaio 3 devido a maior clareza na observação dos ruídos

med = length(dataframe(:,5)) //Quantidade de medidas

time = 13; // Duração do ensaio, registrados abaixo para os 3 ensaios realizados

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
freq_a = 20; //frequência de amostragem do aplicativo

f = freq_a*(0:med-1)/med; // vetor de frequencias

Z = fft(z) // transformada de Fourier

figure(2); 
plot(f,Z)
title("Item B - Espectro de frequências")
xlabel("Frequência(Hz)")
ylabel("Espectro de potência")
h = gca()
h.data_bounds = [0, -30 ; 20, 50]

// Item C - Frequências Naturais


// Item D - Filtro Digital

Ordem = 1; //ordem do filtro
Fcorte1 = 3; //Frequência de corte inferior
Fcorte2= 4;   //Frequência de corte superior
tau1 = 1/(2*%pi*Fcorte1) // Constante de tempo 1
tau2 = 1/(2*%pi*Fcorte2) // Constante de tempo 2

// Definindo o Filtro
s = poly(0, "s")
sl = syslin('c', (1/(tau2*s + 1))*(s*tau1/(s*tau1 + 1)))
filtro_ss = tf2ss(sl)
filtro_dls = cls2dls(filtro_ss, 1/freq_a)
filtro = ss2tf(filtro_dls)
disp(filtro)

// Especificacoes do filtro:
// Filtro passa-bandas (3 - 4 Hz)

// Realizando a transformada Z inversa do filtro encontra-se a equacao de diferenças e
// então calcula-se, em um loop, cada valor discretizado do sinal filtrado.

// Equação de diferenças encontrada:
// z_f(k+2) - 0.5876594*z_f(k+1) + 0.0820366*z_f(k) = 0.2622752*z(k+2) - 0.2622752*z(k)

z_f = zeros(size(z)(1), size(z)(2))

for i = -1:length(z_f)-2
    if i == -1 then
        z_f(1) = 0.2622752 * z(1)
    elseif i == 0 then
        z_f(2) = 0.5876594 * z_f(1) + 0.2622752 * z(2)
    else
        z_f(i+2) = 0.5876594 * z_f(i+1) - 0.0820366 * z_f(i) + 0.2622752 * z(i+2) - 0.2622752 * z(i)
    end
end

// Aceleração no tempo do sinal filtrado
figure(3)
plot(t,z_f)
title("Item D - Aceleração no tempo (filtrado)")
xlabel("Tempo(s)")
ylabel("Aceleração no eixo Z")

//Resposta em Frequência do filtro
Z_f = fft (z_f)

figure(4)
plot(f,Z_f)
title("Item D - Espectro de frequências (filtrado)")
xlabel("Frequência (Hz)")
ylabel("Espectro de potências")
h = gca()
h.data_bounds = [0, -30 ; 20, 50]

// Item E - Relatorio











