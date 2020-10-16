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

for i = 1:N // Criação do pulso
    if i >= ki & i <= kf then
        pulso(i) = 1
    else
        pulso(i) = 0
    end
end
scf(0)
subplot(2,1,1)
plot2d(t,pulso) // Plotagem do pulso no tempo
xtitle("Pulso",'Tempo (s)',"Pulso")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(pulso)) // Plotagem do espectro de potência do pulso
xtitle("FFT do Pulso",'Frequência (Hz)',"Potência")
xgrid()
scf(1)

yp = sin(2*%pi*f*t)
subplot(2,1,1)
plot2d(t,yp) // Plotagem da função periódica no tempo
xtitle("Função periódica",'Tempo (s)',"Função Periódica")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(yp)) // Plotagem do espectro de potência do sinal periódico
xtitle("FFT do Pulso",'Frequência (Hz)',"Potência")
xgrid()

prod = []
for i = 1:N // Criação do sinal produto dos sinais criados anteriormente
    prod(i) = yp(i)*pulso(i)
end
scf(2)
subplot(2,1,1)
plot2d(t,prod) // Plotagem do produto dos sinaiis no tempo
xtitle("Produto dos sinais",'Tempo (s)',"Produto dos sinais")
xgrid()
subplot(2,1,2)
plot2d(vf,fft(prod)) // Plotagem do espectro de potência do produto dos sinais
xtitle("FFT do Produto",'Frequência (Hz)',"Potência")
xgrid()
