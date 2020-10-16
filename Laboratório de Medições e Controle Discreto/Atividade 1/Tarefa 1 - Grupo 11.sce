clc
clear

// TAREFA 1
// Gabriel de Sousa Araujo - 9299341
// Gustavo Lopes Oliveira - 10335490
// Herval Pereira de Castro Junior - 10335792
// Leonardo Silva Almeida Serra - 1033656
// Lucas Hideki Takeuchi Okamura - 9274315

// Parte 1
fa = 100 // frequência de amostragem
t0 = 0 // instante de tempo inicial
tf = 4 // instante de tempo final
dt = 1/fa // período de amostragem
t = t0:dt:tf // criação do intervalo de tempo discretizado

f = 10 // frequência do seno analisado
phi = %pi/180*5 // ângulo de fase
P = 3
y1 = cos(2*%pi*f*t+phi) // Criação do vetor y1 para os valores do intervalo de tempo discretizado
y2 = cos(2*%pi*f*t+phi+2*P*%pi*fa*t) // Criação do vetor y2 para os valores do intervalo de tempo discretizado

scf(0)
subplot(2,1,1)
title("Parte 1")
plot2d(t,y1)
xtitle("y1",'Tempo (s)','y1')
xgrid()
legend(['cos(2*pi*f*t+phi)'])
subplot(2,1,2)
plot2d(t,y2)
xtitle("y2",'Tempo (s)','y2')
xgrid()
legend(['cos(2*pi*f*t+phi+2*pi*P*fa*t)'])

// Análise - Parte 1
// Os sinais coincidiram no intervalo avaliado. Isso ocorreu pois a frequência do novo termo adicionado é 
// igual à frequência de amostragem, o que faz com que o sistema apenas amostre pontos onde o componente 
// adicionado é múltiplo de 2*pi e, por isso, não altera o resultado.

// Parte 2
dt = 0.05 // Passo do vetor de tempos
f = 4 // Frequência do sinal periódico
t = 0:dt:10 // Geração do vetor de tempos
fa = 1/dt // Frequência de amostragem
N = length(t) // Número de amostras
df = fa/N // Resolução em frequência
vf = []
for i = 1:N
    vf(i) = (i-1)*df
end
ti = 1 // Instante inicial do pulso
dur = 2 // Duração do pulso
ki = ti/0.05+1 // Determinação da posição do instante ti no vetor de tempo
tf = ti + dur // Instante final do pulso
kf = tf/0.05+1 // Determinação da posição do instante ti no vetor de tempo

for i = 1:N // Criação do pulso
    if i >= ki & i <= kf then
        pulso(i) = 1
    else
        pulso(i) = 0
    end
end

scf(1)
subplot(2,1,1)
plot2d(t,pulso) // Plotagem do pulso no tempo
xtitle("Parte 2 - Pulso",'Tempo (s)',"Pulso")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(pulso)) // Plotagem do espectro de potência do pulso
xtitle("Parte 2 - FFT do Pulso",'Frequência (Hz)',"Potência")
xgrid()

scf(2)
yp = sin(2*%pi*f*t)
subplot(2,1,1)
plot2d(t,yp) // Plotagem da função periódica no tempo
xtitle("Parte 2- Função periódica",'Tempo (s)',"Função Periódica")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(yp)) // Plotagem do espectro de potência do sinal periódico
xtitle("Parte 2 - FFT da Função periódica",'Frequência (Hz)',"Potência")
xgrid()

prod = []
for i = 1:N // Criação do sinal produto dos sinais criados anteriormente
    prod(i) = yp(i)*pulso(i)
end

scf(3)
subplot(2,1,1)
plot2d(t,prod) // Plotagem do produto dos sinais no tempo
xtitle("Parte 2 - Produto dos sinais",'Tempo (s)',"Produto dos sinais")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(prod)) // Plotagem do espectro de potência do produto dos sinais
xtitle("FFT do Produto dos sinais",'Frequência (Hz)',"Potência")
xgrid()

// Análise - Parte 2
// A partir dos gráficos elaborados, é possível observar as frequências existentes
// nos sinais avaliados, sendo espelhados em torno da frequência de amostragem. Verifica-se
// que o critério de Nyquist foi respeitado, visto que não há valores de frequência
// além do valor do próprio sinal, dentro do intervalo de amostragem.

// Parte 3
// Frequência 4,01 Hz
dt = 0.05 // Passo do vetor de tempos
f = 4.01 // Frequência do sinal periódico
t = 0:dt:10 // Geração do vetor de tempos
fa = 1/0.05 // Frequência de amostragem
N = length(t) // Número de amostras
df = fa/N // Resolução em frequência
vf = []
for i = 1:N
    vf(i) = (i-1)*df
end
ti = 1 // Instante inicial do pulso
dur = 2 // Duração do pulso
ki = ti/0.05+1 // Determinação da posição do instante ti no vetor de tempo
tf = ti + dur // Instante final do pulso
kf = tf/0.05+1 // Determinação da posição do instante ti no vetor de tempo

for i = 1:N // Criação do pulso
    if i >= ki & i <= kf then
        pulso(i) = 1
    else
        pulso(i) = 0
    end
end

scf(4)
subplot(2,1,1)
plot2d(t,pulso) // Plotagem do pulso no tempo
xtitle("Parte 3 - Pulso (4,01 Hz)",'Tempo (s)',"Pulso")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(pulso)) // Plotagem do espectro de potência do pulso
xtitle("Parte 3 - FFT do Pulso (4,01 Hz)",'Frequência (Hz)',"Potência")
xgrid()

scf(5)
yp = sin(2*%pi*f*t)
subplot(2,1,1)
plot2d(t,yp) // Plotagem da função periódica no tempo
xtitle(" Parte 3 - Função periódica (4,01 Hz)",'Tempo (s)',"Função Periódica")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(yp)) // Plotagem do espectro de potência do sinal periódico
xtitle("Parte 3 - FFT da Função periódica (4,01 Hz)",'Frequência (Hz)',"Potência")
xgrid()

prod = []
for i = 1:N // Criação do sinal produto dos sinais criados anteriormente
    prod(i) = yp(i)*pulso(i)
end
scf(6)
subplot(2,1,1)
plot2d(t,prod) // Plotagem do produto dos sinaiis no tempo
xtitle("Parte 3 - Produto dos sinais (4,01 Hz)",'Tempo (s)',"Produto dos sinais")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(prod)) // Plotagem do espectro de potência do produto dos sinais
xtitle("Parte 3 - FFT do Produto dos sinais (4,01 Hz)",'Frequência (Hz)',"Potência")
xgrid()

// Frequência 4,16 Hz
dt = 0.05 // Passo do vetor de tempos
f = 4.16 // Frequência do sinal periódico
t = 0:dt:10 // Geração do vetor de tempos
fa = 1/0.05 // Frequência de amostragem
N = length(t) // Número de amostras
df = fa/N // Resolução em frequência
vf = []
for i = 1:N
    vf(i) = (i-1)*df
end
ti = 1 // Instante inicial do pulso
dur = 2 // Duração do pulso
ki = ti/0.05+1 // Determinação da posição do instante ti no vetor de tempo
tf = ti + dur // Instante final do pulso
kf = tf/0.05+1 // Determinação da posição do instante ti no vetor de tempo

scf(7)
subplot(2,1,1)
plot2d(t,pulso) // Plotagem do pulso no tempo
xtitle("Parte 3 - Pulso (4,16 Hz)",'Tempo (s)',"Pulso")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(pulso)) // Plotagem do espectro de potência do pulso
xtitle("Parte 3 - FFT do Pulso (4,16 Hz)",'Frequência (Hz)',"Potência")
xgrid()

yp1 = sin(2*%pi*f*t) 

scf(8)
subplot(2,1,1)
plot2d(t,yp1) // Plotagem da função periódica no tempo
xtitle("Parte 3 - Função Periódica (4,16 Hz)",'Tempo (s)',"Função Periódica")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(yp1)) // Plotagem do espectro de potência do sinal periódico
xtitle("Parte 3 - FFT da Função Periódica (4,16 Hz)",'Frequência (Hz)',"Potência")
xgrid()

prod1 = []
for i = 1:N // Criação do sinal produto dos sinais criados anteriormente
    prod1(i) = yp1(i)*pulso(i)
end

scf(9)
title("Parte 3 - Produto (4,16 Hz)")
subplot(2,1,1)
plot2d(t,prod1) // Plotagem do produto dos sinaiis no tempo
xtitle("Parte 3 - Produto dos sinais (4,16 Hz)",'Tempo (s)',"Produto dos sinais")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(prod1)) // Plotagem do espectro de potência do produto dos sinais
xtitle("Parte 3 - FFT do Produto dos sinais (4,16 Hz)",'Frequência (Hz)',"Potência")
xgrid()

// Análise - Parte 3
// Observa-se que o sinal com frequência 4.01 Hz possui dois picos no gráfico da transformada de Fourier, 
// que indicam a propria frequência F e F_amost - F, efeito decorrente do espelhamento da frequência de amostragem.
// Já no gráfico do sinal de frequência 4.16 Hz, os picos são semelhantes, no entanto, houve uma inversão de fase em 
// relação ao caso anterior, ou seja, o pico negativo do sinal é maior que o pico positivo. Na situação 
// em que os sinais são mutiplicados pelo pulso, o comportamento é igual nas diferentes frequências, com 
// pico positivo maior que o negativo. Além disso, nesta última situação, a aplicação de um pulso (janela retangular),
// fez com que o sinal não se tornasse periódico e consequentemente ocorresse o fenômeno de leakage, observado pelo
// fato de haver ruídos nas proximidades da frequência do sinal. O sinal obtido respeita o critério de Nyquist.

// Parte 4
// Frequência 4,01 Hz
dt = 0.01 // Passo do vetor de tempos
f = 4.01 // Frequência do sinal periódico
t = 0:dt:10 // Geração do vetor de tempos
fa = 1/dt // Frequência de amostragem
N = length(t) // Número de amostras
df = fa/N // Resolução em frequência
vf = []
for i = 1:N
    vf(i) = (i-1)*df
end
ti = 1 // Instante inicial do pulso
dur = 2 // Duração do pulso
ki = ti/dt+1 // Determinação da posição do instante ti no vetor de tempo
tf = ti + dur // Instante final do pulso
kf = tf/dt+1 // Determinação da posição do instante ti no vetor de tempo

for i = 1:N // Criação do pulso
    if i >= ki & i <= kf then
        pulso(i) = 1
    else
        pulso(i) = 0
    end
end
scf(10)
subplot(2,1,1)
plot2d(t,pulso) // Plotagem do pulso no tempo
xtitle("Parte 4 - Pulso (4,01 Hz)",'Tempo (s)',"Pulso")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(pulso)) // Plotagem do espectro de potência do pulso
xtitle("Parte 4 - FFT do Pulso (4,01 Hz)",'Frequência (Hz)',"Potência")
xgrid()

scf(11)
yp = sin(2*%pi*f*t)
subplot(2,1,1)
plot2d(t,yp) // Plotagem da função periódica no tempo
xtitle("Parte 4 - Função periódica (4,01 Hz)",'Tempo (s)',"Função Periódica")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(yp)) // Plotagem do espectro de potência do sinal periódico
xtitle("Parte 4 - FFT da Função periódica (4,01 Hz)",'Frequência (Hz)',"Potência")
xgrid()

prod = []
for i = 1:N // Criação do sinal produto dos sinais criados anteriormente
    prod(i) = yp(i)*pulso(i)
end
scf(12)
subplot(2,1,1)
plot2d(t,prod) // Plotagem do produto dos sinaiis no tempo
xtitle("Parte 4 - Produto dos sinais (4,01 Hz)",'Tempo (s)',"Produto dos sinais")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(prod)) // Plotagem do espectro de potência do produto dos sinais
xtitle("Parte 4 - FFT do Produto dos sinais (4,01 Hz)",'Frequência (Hz)',"Potência")
xgrid()

// Frequência 4,16 Hz
dt = 0.01 // Passo do vetor de tempos
f = 4.16 // Frequência do sinal periódico
t = 0:dt:10 // Geração do vetor de tempos
fa = 1/dt // Frequência de amostragem
N = length(t) // Número de amostras
df = fa/N // Resolução em frequência
vf = []
for i = 1:N
    vf(i) = (i-1)*df
end
ti = 1 // Instante inicial do pulso
dur = 2 // Duração do pulso
ki = ti/0.05+1 // Determinação da posição do instante ti no vetor de tempo
tf = ti + dur // Instante final do pulso
kf = tf/0.05+1 // Determinação da posição do instante ti no vetor de tempo

scf(13)
subplot(2,1,1)
plot2d(t,pulso) // Plotagem do pulso no tempo
xtitle("Parte 4 - Pulso (4,16 Hz)",'Tempo (s)',"Pulso")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(pulso)) // Plotagem do espectro de potência do pulso
xtitle("Parte 4 - FFT do Pulso (4,16 Hz)",'Frequência (Hz)',"Potência")
xgrid()

scf(14)
yp = sin(2*%pi*f*t)
subplot(2,1,1)
plot2d(t,yp) // Plotagem da função periódica no tempo
xtitle("Parte 4 - Função periódica (4,16 Hz)",'Tempo (s)',"Função Periódica")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(yp)) // Plotagem do espectro de potência do sinal periódico
xtitle("Parte 4 - FFT da Função periódica (4,16 Hz)",'Frequência (Hz)',"Potência")
xgrid()

prod = []
for i = 1:N // Criação do sinal produto dos sinais criados anteriormente
    prod(i) = yp(i)*pulso(i)
end
scf(15)
subplot(2,1,1)
plot2d(t,prod) // Plotagem do produto dos sinaiis no tempo
xtitle("Parte 4 - Produto dos sinais (4,16 Hz)",'Tempo (s)',"Produto dos sinais")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(prod)) // Plotagem do espectro de potência do produto dos sinais
xtitle("Parte 4 - FFT do Produto dos sinais (4,16 Hz)",'Frequência (Hz)',"Potência")
xgrid()

// Análise - Parte 4
// Percebe-se que o comportamento citado no item anterior se repete, só que agora mudamos
// a frequência de amostragem, que possui um valor de 100 Hz. Com isso o efeito de F_amost - F 
// no gráfico da transformada de Fourier acompanha essa mudança. Todos os fenômenos que ocorrem
// são semelhantes ao da Parte 3, como o leakage. Porém, como a frequência de amostragem é
// diferente, mas ainda respeitando o critério de Nyquist, a frequência do sinal é obtida 
// na Transformada de Fourier em intervalos diferentes.
