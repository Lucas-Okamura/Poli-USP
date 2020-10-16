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

subplot(2,1,1)
plot2d(t,y1)
xtitle("y1",'Tempo (s)','y1')
xgrid()
legend(['cos(2*pi*f*t+phi)'])
subplot(2,1,2)
plot2d(t,y2)
xtitle("y2",'Tempo (s)','y2')
xgrid()
legend(['cos(2*pi*f*t+phi+2*pi*P*fa*t)'])

