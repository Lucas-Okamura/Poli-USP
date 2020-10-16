clear all
clc 

// Grupo
// Gabriel de Sousa Araujo - 9299341 - gabriel_araujo@usp.br
// Gustavo Lopes Oliveira - 10335490 - gustavo.l.oliveira@usp.br
// Herval Pereira de Castro Junior - 10335792 - hervalcastro@usp.br
// Leonardo Silva Almeida Serra - 10335656 - leonardoserra@usp.br
// Lucas Hideki Takeuchi Okamura - 9274315 - lucasokamura@usp.br

//// Tarefa 1 ////

// Importação de dados

base_path = pwd()
dataframe1 = base_path + "\exp_ruido.csv"

dataframe = csvRead(dataframe1,';') // mudar aqui qual arquivo analisar

// Parâmetros do Ensaio 
// Foram realizados 3 ensaios com as seguintes durações:
// Ensaio 1 : 16,3 segundos
// Ensaio 2 : 21,1 segundos
// Ensaio 3 : 13 segundos
// Foi escolhido o ensaio 3 devido a maior clareza na observação dos ruídos

med = length(dataframe(:,5)) //Quantidade de medidas

time = 13; // Duração do ensaio, registrados abaixo para os 3 ensaios realizados

t = linspace(0,time,med) // vetor tempo

// Identifica-se que a coordenada Z do telefone corresponde à variavel de interesse no problema, que é a aceleração normal ao plano do celular, logo

z = dataframe(:,6)/1000 // vetor de entradas de interesse + correção de unidades

// Item A - Aceleração no tempo

// Para o experimento realizado, importa apenas a aceleracao no eixo z, paralelo a gravidade.

figure(1)
plot(t,z)
title("Item A - Aceleração no tempo")
xlabel("Tempo(s)")
ylabel("Aceleração no eixo Z")

// Item B - Espectros de frequências

// Transformada rápida de Fourier 
freq_a = 20; //frequência de amostragem do aplicativo

f = freq_a*(0:med-1)/med; // vetor de frequencias

Z = fft(z) // transformada de Fourier

figure(2)
plot(f,Z)
title("Item B - Espectro de frequências")
xlabel("Frequência(Hz)")
ylabel("Espectro de potência")
h = gca()
h.data_bounds = [0, -30 ; 20, 50]

// Item C - Frequências Naturais

/* O experimento ensaiado se baseia na medição da aceleração de um telefone
celular fixo à ponta de uma régua plástica. Uma deflexão perpendicular ao eixo
da régua é aplicada inicialmente, e quando se solta, o telefone se movimenta
de maneira aparentemente periódica. O objetivo deste código, então, é estudar
as frequências naturais desse movimento, que possuem relação com propriedades
mecânicas e geométricas da régua e também do peso do celular, aplicando um
filtro digital com o intuito de remover frequências distantes da natural, que
possivelmente estarão presentes na gravação por conta de ruídos. Para inserir
mais ruídos no experimento, como forma de verificar a eficiência do filtro, a 
base onde a régua estava fixa foi excitada por meio de um impacto.
    Inicialmente, lê-se a informação gravada pelo telefone por meio de um
arquivo .csv, cuja progressão no tempo está apresentada no primeiro gráfico e
seu espectro de frequências no segundo.
    Com isso, verificou-se a frequência natural tanto pelo espectro, quanto
por meio da contagem da quantidade de picos no gráfico de progressão temporal. 
Essa contagem foi feita no final do gráfico, uma vez que no começo da gravação
é nítida a influência de componentes distintas da frequência natural que
atrapalhariam a contagem. 
    Pelo espectro, o intervalo de frequências naturais está entre 3 e 4 Hz.
Por meio da contagem, a frequência natural encontrada foi de aproximadamente
3,5 Hz, dentro do intervalo encontrado no espectro de frequências.
*/
// Item D - Filtro Digital

Ordem = 1 //ordem do filtro
Fcorte1 = 3 //Frequência de corte inferior
Fcorte2= 4   //Frequência de corte superior
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


figure(5)
plot2d(t,z_f, style = 2)
plot2d(t,z,style = 5)
title("Item D - Comparação sinal filtrado / mensurado")
xlabel("Tempo(s)")
ylabel("Aceleração no eixo Z")
legend("Filtrado", "Mensurado")

// Item E - Relatorio

/* 
    Aplicando o filtro passa-banda para a faixa de frequências entre 3 e 4 Hz
chegamos ao gráfico de aceleração no tempo filtrado (3º gráfico) e o gráfico
do espectro de frequências da gravação filtrada (4º gráfico).
    Comparando a gravação não filtrada com aquela submetida ao filtro, fica
evidente que a faixa de frequências escolhida para o filtro é adequada, uma
vez que o sinal filtrado está ausente de efeitos de interação entre as
oscilações na frequência natural e as perturbações geradas pelo ruído. As
amplitudes do sinal se mantiveram dentro do esperado, o que atesta que as
frequências rejeitadas não correspodiam as componentes de grande intensidade,
sendo, muito possivelmente, disturbios que não refletem a oscilação que se
desejava observar com o experimento.
    Como o filtro rejeita as frequências baixas, existe um "offset" do gráfico 
temporal do sinal original em relação ao sinal filtrado. Esse offset é causado 
por conta da aceleração gravitacional praticamente constante (há uma pequena 
variação por conta do fato de que os movimento do telefone o fazem rotacionar,
alterando a direção dos eixos de seu acelerômetro, o que faz com que a aceleração
gravitacional tenha componentes em outras direções além de z, alterando a sua
intensidade nesse eixo). O filtro, então, além de rejeitar distúrbios causados
tanto pelos ruídos introduzidos voluntariamente pelo executor do ensaio, quanto
os ruídos presentes por fatores que não se pode controlar, ainda é capaz de
remover o offset do sensor, isolando, dessa forma, a oscilação que se deseja
analisar.
    A eficácia do filtro pode ser verificada, também, por meio do espectro de 
frequências do sinal filtrado. A atenuação das componentes fora da banda de
passagem do filtro é nítida. A forma do espectro dentro da banda de passagem é
mantida com certa precisão, o que é essencial para uma boa reprodução da banda
de passagem no sinal filtrado.
    É possível concluir, portanto, que o filtro aplicado foi capaz de cumprir
seu papel, atenuando as interferências indesejadas de modo a permitir a 
visualização do sinal de interesse e que o exercício realizado foi essencial
para o aprendizado sobre a manipulação de sinais discretos, o uso da
transformada Z, o funcionamento dos filtros digitais e a aplicação das equações
de diferenças.
*/











