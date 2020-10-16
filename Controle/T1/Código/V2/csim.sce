// Definição das condições iniciais
x0 = [5;5;5;5]

// Definição do intervalo de tempo
t0 = 0
tf = 200
n = 1000
t = linspace(t0,tf,n)
// Sistema linear
sl = syslin('c',A,B,C,D)
h = real(ss2tf(sl))

