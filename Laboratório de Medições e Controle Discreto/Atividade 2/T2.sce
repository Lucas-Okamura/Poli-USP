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

// Áudios Gabriel

// Fonema aberto - é
gabriel_aberto = fullfile("é Gabriel.wav")
[y_gabriel_a,Fs,bits]=wavread(gabriel_aberto)

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
gabriel_fechado = fullfile("ê Gabriel.wav")
[y_gabriel_f,Fs,bits]=wavread(gabriel_fechado)

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
gustavo_aberto = fullfile("á Gustavo.wav")
[y_gustavo_a,Fs,bits]=wavread(gustavo_aberto)

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
[y_gustavo_f,Fs,bits]=wavread("D:\Poli\PME3402 (Lab. Medições e Controle)\Atividade 2\â Gustavo.wav")

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
[y_herval_a,Fs,bits]=wavread("D:\Poli\PME3402 (Lab. Medições e Controle)\Atividade 2\á Herval.wav")

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
[y_herval_f,Fs,bits]=wavread("D:\Poli\PME3402 (Lab. Medições e Controle)\Atividade 2\â Herval.wav")

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
[y_leonardo_a,Fs,bits]=wavread("D:\Poli\PME3402 (Lab. Medições e Controle)\Atividade 2\é Leonardo.wav")

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
[y_leonardo_f,Fs,bits]=wavread("D:\Poli\PME3402 (Lab. Medições e Controle)\Atividade 2\ê Leonardo.wav")

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
[y_lucas_a,Fs,bits]=wavread("D:\Poli\PME3402 (Lab. Medições e Controle)\Atividade 2\ó Lucas.wav")

fa = Fs //frequência de amostragem
t0 = 0 // instante de tempo inicial
dt = 1/fa // período de amostragem
tf = (length(y_lucas_a(1,:))-1) * dt // instante de tempo final
t = t0:dt:tf // criação do intervalo de tempo discretizado

Y_lucas_a = fft(y_lucas_a)
N = length(t)   // Número de amostras
df = fa/N       // Resolução em frequência
f = 0:df:(N-1)*df

scf(7)
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
[y_lucas_f,Fs,bits]=wavread("D:\Poli\PME3402 (Lab. Medições e Controle)\Atividade 2\ô Lucas.wav")

fa = Fs //frequência de amostragem
t0 = 0 // instante de tempo inicial
dt = 1/fa // período de amostragem
tf = (length(y_lucas_f(1,:))-1) * dt // instante de tempo final
t = t0:dt:tf // criação do intervalo de tempo discretizado

Y_lucas_f = fft(y_lucas_f)
N = length(t)   // Número de amostras
df = fa/N       // Resolução em frequência
f = 0:df:(N-1)*df

scf(8)
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
