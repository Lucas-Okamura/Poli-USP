clc
clear

/*
ATIVIDADE 2 - 14/09
TAREFA 2
Gabriel de Sousa Araujo - 9299341
Gustavo Lopes Oliveira - 10335490
Herval Pereira de Castro Junior - 10335792
Leonardo Silva Almeida Serra - 1033656
Lucas Hideki Takeuchi Okamura - 9274315
*/

/* 
As leituras serão realizadas por integrante do grupo, sendo que cada um gravou
2 áudios cada, um com fonema aberto (á, é, i, ó) e outro com fonema fechado (â, ê, ô).
O eixo x (Frequência) dos gráficos das FFTs serão limitados em 3400 Hz, que é a máxima
frequência alcançada pela voz humana.

OBS: os caminhos relativos aos arquivos podem ser obtidos clicando no arquivo com o 
botão direito do mouse e a tecla SHIFT, e então selecionar "Copiar como caminho".
Os sufixos _a e _f serão utilizados para os fonemas abertos e fechados, respectivamente.
*/

diretorio = pwd()

// Áudios Gabriel

// Fonema aberto - é
[y_gabriel_a,Fs,bits]=wavread(diretorio + "\é Gabriel.wav")

fa = Fs //frequência de amostragem
t0 = 0 // instante de tempo inicial
dt = 1/fa // período de amostragem
tf = (length(y_gabriel_a(1,:))-1) * dt // instante de tempo final
t = t0:dt:tf // criação do intervalo de tempo discretizado

Y_gabriel_a = fft(y_gabriel_a)  // Transformada de Fourier
N = length(t)   // Número de amostras
df = fa/N       // Resolução em frequência
f = 0:df:(N-1)*df

scf(0)
subplot(2,1,1)
plot2d(t, y_gabriel_a(1,:))
title("Gabriel (é - aberto) - Sinal em função do tempo")
xlabel("Tempo(s)")
ylabel("Amplitude do sinal")
subplot(2,1,2)
plot2d(f, Y_gabriel_a(1,:))
title("FFT")
xlabel("Frequência (Hz)")
ylabel("Espectro de Frequência")
h = gca()
h.data_bounds = [0, -430 ; 3400, 430]

// Fonema Fechado - ê
[y_gabriel_f,Fs,bits]=wavread(diretorio + "\ê Gabriel.wav")

fa = Fs //frequência de amostragem
t0 = 0 // instante de tempo inicial
dt = 1/fa // período de amostragem
tf = (length(y_gabriel_f(1,:))-1) * dt // instante de tempo final
t = t0:dt:tf // criação do intervalo de tempo discretizado

Y_gabriel_f = fft(y_gabriel_f)  // Transformada de Fourier
N = length(t)   // Número de amostras
df = fa/N       // Resolução em frequência
f = 0:df:(N-1)*df

scf(1)
subplot(2,1,1)
plot2d(t, y_gabriel_f(1,:))
title("Gabriel (ê - fechado) - Sinal em função do tempo")
xlabel("Tempo(s)")
ylabel("Amplitude do sinal")
subplot(2,1,2)
plot2d(f, Y_gabriel_f(1,:))
title("FFT")
xlabel("Frequência (Hz)")
ylabel("Espectro de Frequência")
h = gca()
h.data_bounds = [0, -620 ; 3400, 620]

// Áudios Gustavo

// Fonema Aberto - á
[y_gustavo_a,Fs,bits]=wavread(diretorio + "/á Gustavo.wav")

fa = Fs //frequência de amostragem
t0 = 0 // instante de tempo inicial
dt = 1/fa // período de amostragem
tf = (length(y_gustavo_a(1,:))-1) * dt // instante de tempo final
t = t0:dt:tf // criação do intervalo de tempo discretizado

Y_gustavo_a = fft(y_gustavo_a)
N = length(t)   // Número de amostras
df = fa/N       // Resolução em frequência
f = 0:df:(N-1)*df

scf(2)
subplot(2,1,1)
plot2d(t, y_gustavo_a(1,:))
title("Gustavo (á - aberto) - Sinal em função do tempo")
xlabel("Tempo(s)")
ylabel("Amplitude do sinal")
subplot(2,1,2)
plot2d(f, Y_gustavo_a(1,:))
title("FFT")
xlabel("Frequência (Hz)")
ylabel("Espectro de Frequência")
h = gca()
h.data_bounds = [0, -150 ; 3400, 150]

// Fonema Fechado - â
[y_gustavo_f,Fs,bits]=wavread(diretorio + "/â Gustavo.wav")

fa = Fs //frequência de amostragem
t0 = 0 // instante de tempo inicial
dt = 1/fa // período de amostragem
tf = (length(y_gustavo_f(1,:))-1) * dt // instante de tempo final
t = t0:dt:tf // criação do intervalo de tempo discretizado

Y_gustavo_f = fft(y_gustavo_f)
N = length(t)   // Número de amostras
df = fa/N       // Resolução em frequência
f = 0:df:(N-1)*df

scf(3)
subplot(2,1,1)
plot2d(t, y_gustavo_f(1,:))
title("Gustavo (â - fechado) - Sinal em função do tempo")
xlabel("Tempo(s)")
ylabel("Amplitude do sinal")
subplot(2,1,2)
plot2d(f, Y_gustavo_f(1,:))
title("FFT")
xlabel("Frequência (Hz)")
ylabel("Espectro de Frequência")
h = gca()
h.data_bounds = [0, -350 ; 3400, 350]

// Áudios Herval

// Fonema Aberto - á
[y_herval_a,Fs,bits]=wavread(diretorio + "\á Herval.wav")

fa = Fs //frequência de amostragem
t0 = 0 // instante de tempo inicial
dt = 1/fa // período de amostragem
tf = (length(y_herval_a(1,:))-1) * dt // instante de tempo final
t = t0:dt:tf // criação do intervalo de tempo discretizado

Y_herval_a = fft(y_herval_a)
N = length(t)   // Número de amostras
df = fa/N       // Resolução em frequência
f = 0:df:(N-1)*df

scf(4)
subplot(2,1,1)
plot2d(t, y_herval_a(1,:))
title("Herval (á - aberto) - Sinal em função do tempo")
xlabel("Tempo(s)")
ylabel("Amplitude do sinal")
subplot(2,1,2)
plot2d(f, Y_herval_a(1,:))
title("FFT")
xlabel("Frequência (Hz)")
ylabel("Espectro de Frequência")
h = gca()
h.data_bounds = [0, -1000 ; 3400, 1000]

// Fonema Fechado - â
[y_herval_f,Fs,bits]=wavread(diretorio + "\â Herval.wav")

fa = Fs //frequência de amostragem
t0 = 0 // instante de tempo inicial
dt = 1/fa // período de amostragem
tf = (length(y_herval_f(1,:))-1) * dt // instante de tempo final
t = t0:dt:tf // criação do intervalo de tempo discretizado

Y_herval_f = fft(y_herval_f)
N = length(t)   // Número de amostras
df = fa/N       // Resolução em frequência
f = 0:df:(N-1)*df

scf(5)
subplot(2,1,1)
plot2d(t, y_herval_f(1,:))
title("Herval (â - fechado) - Sinal em função do tempo")
xlabel("Tempo(s)")
ylabel("Amplitude do sinal")
subplot(2,1,2)
plot2d(f, Y_herval_f(1,:))
title("FFT")
xlabel("Frequência (Hz)")
ylabel("Espectro de Frequência")
h = gca()
h.data_bounds = [0, -800 ; 3400, 800]

// Áudios Leonardo

// Fonema Aberto - é
[y_leonardo_a,Fs,bits]=wavread(diretorio + "\é Leonardo.wav")

fa = Fs //frequência de amostragem
t0 = 0 // instante de tempo inicial
dt = 1/fa // período de amostragem
tf = (length(y_leonardo_a(1,:))-1) * dt // instante de tempo final
t = t0:dt:tf // criação do intervalo de tempo discretizado

Y_leonardo_a = fft(y_leonardo_a)
N = length(t)   // Número de amostras
df = fa/N       // Resolução em frequência
f = 0:df:(N-1)*df

scf(6)
subplot(2,1,1)
plot2d(t, y_leonardo_a(1,:))
title("Leonardo (é - aberto) - Sinal em função do tempo")
xlabel("Tempo(s)")
ylabel("Amplitude do sinal")
subplot(2,1,2)
plot2d(f, Y_leonardo_a(1,:))
title("FFT")
xlabel("Frequência (Hz)")
ylabel("Espectro de Frequência")
h = gca()
h.data_bounds = [0, -1000 ; 3400, 1000]

// Fonema Fechado - ê
[y_leonardo_f,Fs,bits]=wavread(diretorio + "\ê Leonardo.wav")

fa = Fs //frequência de amostragem
t0 = 0 // instante de tempo inicial
dt = 1/fa // período de amostragem
tf = (length(y_leonardo_f(1,:))-1) * dt // instante de tempo final
t = t0:dt:tf // criação do intervalo de tempo discretizado

Y_leonardo_f = fft(y_leonardo_f)
N = length(t)   // Número de amostras
df = fa/N       // Resolução em frequência
f = 0:df:(N-1)*df

scf(7)
subplot(2,1,1)
plot2d(t, y_leonardo_f(1,:))
title("Leonardo (ê - fechado) - Sinal em função do tempo")
xlabel("Tempo(s)")
ylabel("Amplitude do sinal")
subplot(2,1,2)
plot2d(f, Y_leonardo_f(1,:))
title("FFT")
xlabel("Frequência (Hz)")
ylabel("Espectro de Frequência")
h = gca()
h.data_bounds = [0, -750 ; 3400, 750]

// Áudios Lucas

// Fonema Aberto - ó
[y_lucas_a,Fs,bits]=wavread(diretorio + "\ó Lucas.wav")

fa = Fs //frequência de amostragem
t0 = 0 // instante de tempo inicial
dt = 1/fa // período de amostragem
tf = (length(y_lucas_a(1,:))-1) * dt // instante de tempo final
t = t0:dt:tf // criação do intervalo de tempo discretizado

Y_lucas_a = fft(y_lucas_a)
N = length(t)   // Número de amostras
df = fa/N       // Resolução em frequência
f = 0:df:(N-1)*df

scf(8)
subplot(2,1,1)
plot2d(t, y_lucas_a(1,:))
title("Lucas (ó - aberto) - Sinal em função do tempo")
xlabel("Tempo(s)")
ylabel("Amplitude do sinal")
subplot(2,1,2)
plot2d(f, Y_lucas_a(1,:))
title("FFT")
xlabel("Frequência (Hz)")
ylabel("Espectro de Frequência")
h = gca()
h.data_bounds = [0, -700 ; 3400, 700]

// Fonema Aberto - ô
[y_lucas_f,Fs,bits]=wavread(diretorio + "\ô Lucas.wav")

fa = Fs //frequência de amostragem
t0 = 0 // instante de tempo inicial
dt = 1/fa // período de amostragem
tf = (length(y_lucas_f(1,:))-1) * dt // instante de tempo final
t = t0:dt:tf // criação do intervalo de tempo discretizado

Y_lucas_f = fft(y_lucas_f)
N = length(t)   // Número de amostras
df = fa/N       // Resolução em frequência
f = 0:df:(N-1)*df

scf(9)
subplot(2,1,1)
plot2d(t, y_lucas_f(1,:))
title("Lucas (ô - fechado) - Sinal em função do tempo")
xlabel("Tempo(s)")
ylabel("Amplitude do sinal")
subplot(2,1,2)
plot2d(f, Y_lucas_f(1,:))
title("FFT")
xlabel("Frequência (Hz)")
ylabel("Espectro de Frequência")
h = gca()
h.data_bounds = [0, -900 ; 3400, 900]

/*
Análise dos Resultados

A detecção da linguagem oral é um dos grandes desafios que a tecnologia enfrenta 
atualmente. Existem diversas metodologias para processar a linguagem oral e 
permitir que um computador seja capaz de interpretá-la corretamente. Um dos 
principais método de reconhecimento vocal se baseia na análise do espectro de
frequências da gravação dos aúdios com o intuito de entender qual fonema está 
sendo analisado. Neste código interpretamos gravações feitas por smartphones
do ponto de vista do domínio de frequências, buscando perceber características
que permitam diferenciar os fonemas.

Comparação dos fonemas (é/ê) gravados pelo membro Gabriel:

O fonema aberto tem um pico muito próximo à frequência de 504 Hz, com picos
de menor intensidade nas frequências de 124, 249 e 376 Hz, o que são harmônicas.
Nota-se, ainda, presença de picos em frequências harmônicas acimas dos 504 Hz, 
porém com intensidade menor.
Já para o fonema fechado (ê) a frequência do pico máximo é de cerca de 269 Hz,
há também um pico de alta intensidade próximo da frequência de 257 Hz. Nas
harmônicas mais baixas dessas frequências (124 Hz e 136 Hz), como no caso
anterior, é possível notar a presença de picos de menor intensidade em
harmônicos de maior intensidade.
Nota-se, então, que o pico de maior intensidade do fonema aberto tem maior
frequência que o do fonema fechado, indicando que, possivelmente, nosso sistema
auricular irá interpretá-lo como um som mais agudo, o que é esperado.

Comparação dos fonemas (á/â) gravados pelo membro Gustavo:

Para o fonema aberto (á) nota-se um pico de frequência próximo dos 125 Hz. 
São notados, também, dois picos consideráveis nas frequências de 610 e 738 Hz.
O fonema fechado (â) tem um pico bastante claro perto da frequência de 126 Hz.
Por conta de sua amplitude muito grande e de sua aparição no fonema aberto, 
pode-se tratar, também, de algum efeito dos ruídos durante a gravação ou 
fenômeno de ressonância com a estrutura do aparelho celular. Nota-se, portanto,
um outro pico próximo da frequência de 133 Hz. Também existem picos próximos da
frequência de 266, 400 e 533 Hz, que são, possivelmente harmônicas da segunda 
frequência citada.
Descontando o efeito das frequências de 125 e 126 Hz, que provavlmente
aparecem por conta de efeitos de ressonância ou ruídos, novamente verifica-se
que o fonema aberto possui sua maior intensidade em uma frequência maior do que
o fonema fechado, o que é esperado.


Comparação dos fonemas (á/â) gravados pelo membro Herval:

Para o fonema aberto (á), há um pico de intensidade na frequência de
aproximadamente 97 Hz, e picos nas frequências próximas de 194, 290 e 386 Hz, e
também de harmôicos mais altos. Também são notados intervalos em que as intensi-
dades são elevadas, como é o caso do intervalo de 570 até 620 Hz, 670 até 740 Hz
e de 760 até 815 Hz. Nesses intervalos, existem diversos picos com intensidades
muito próximas, porém é difícil determinar valores exatos.
Para o fonema aberto (â), existem dois picos muito notáveis nas frequências de
111 Hz e seu harmônico, 222 Hz, além das frequências próximas de 333, 444 e 555
Hz, com menor intensidade.
Ainda que o pico máximo do fonema aberto aconteça em uma frequência mais baixa
do que no fonema fechado, ainda existem picos com intensidade considerável em 
maiores frequências, que permitem afirmar que, possivelemte, o fonema aberto
será interpretado como um fonema mais agudo que o fonema fechado por conta 
desses picos de maior frequência.

Comparação dos fonemas (é/ê) gravados pelo membro Leonardo:

O fonema aberto (é) tem pico próximo da frequência de 524 Hz. Além disso, existem
picos de menor intensidade das frequências de 130, 265 e 394 Hz, possivelmente
harmônicas da primeira citada. 
Já para o fonema fechado (ê) existem picos com intensidades próximas nas 
frequências de 100, 203, 304 e 406 Hz, possívelmente harmônicos entre si, com
a frequência de 304 Hz tendo maior intensidade.
Como esperado, o fonema aberto é mais agudo que o fonema fechado, com uma
diferença de frequências bastante notável.

Comparação dos fonemas (ó/ô) gravados pelo membro Lucas:

O fonema aberto (ó) tem picos 217, 433, 542 e 974 Hz. As duas primeiras são, 
possivelmente, harmônicas entre si. Os picos de maior intensidade ocorre para
as frequências de 433 e 542 Hz.
O fonema fechado (ô) tem picos nas frequências de 226, 335, 430 e 450 Hz. 
A primeira, segunda e quarta são, possivelmente, harmônicas entre sim, e a
frequência de 335 Hz.
Como esperado, o fonema aberto tem frequências maiores nos picos de maior 
intensidade.

Comparação dos fonemas iguais gravados por membros diferentes:

Comparação fonemas (é/ê) entre Gabriel e Leonardo:

O pico em ambos os fonemas abertos analisados foram de 504 e 524 Hz, ou seja, 
muito próximos. Seriam necessários mais análises para afirmar que essa
faixa de frequências é característica desse fonema específico, porém a
proximidade verificada pode ser um indicativo.
O fonema fechado não apresenta uma proximidade tão grande entre as frequências
de maior amplitude no espectro. Isso pode indicar que esse fonema pode ser
mais difícil de detectar. Outros fatores como sotaque, diferentes tons de voz,
etc podem ser responsáveis pela diferenciação.

Comparação fonemas (á/â) entre Gustavo e Herval:

Para o fonema aberto (á) as faixas de maior intensidade foram bem próximas, o
que permitiria, de certa, identificar, em gravações feitas pelos dois membros,
sua presença.
No fonema fechado (â) as frequência foram próximas, com uma diferença relativa
de cerca de 16,5% na frequência mais notável. Essa diferença pode impedir a
diferenciação dos fonemas quando se trabalhar com uma maior quantidade de opções
(ou seja, quando se estiver tentando descobrir qual fonema está gravada dentro
de uma grande quantidade de opções), porém para sua diferenciação do fonema
aberto, essa diferença de frequências não seria limitante.

Comparação geral:

Existem fonemas, como é o caso de (é) e (ó) cujas frequências de maior
intensidade no espectro são bastante próximas. Possivelmente a diferenciação
desses fonemas por meio da comparação dos espectros de frequência deve consi-
derar diversas componentes do espectro. 
Com a quantidade limitada de gravações que temos, essa comparação não seria
eficaz, pois seria muito afetada por características vocais de cada individuo
gravado, o que dificultaria a caracterização dos fonemas por si só.







