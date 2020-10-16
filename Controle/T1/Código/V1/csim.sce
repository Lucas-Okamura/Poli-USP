// Definição das condições iniciais
x0 = [5;5;5;5]

// Definição do intervalo de tempo
t0 = 0
tf = 200
n = 1000
t = linspace(t0,tf,n)
// Sistema linear
C = [[1,0,0,0];
     [0,1,0,0];
     [0,0,1,0];
     [0,0,0,1]]
D = [[0,0];
     [0,0];
     [0,0];
     [0,0]]
sl = syslin('c',A,B,C,D)
h = ss2tf(sl)
scf(4)
plzr(sl)

scf(0)
subplot(1,2,1)
bode(h(1,1));
xtitle("Diagrama de Bode: Deflexão Aileron - Velocidade lat. v")
subplot(1,2,2)
bode(h(1,2));
xtitle("Diagrama de Bode: Deflexão Leme - Velocidade lat. v")

scf(1)
subplot(1,2,1)
bode(h(2,1));
xtitle("Diagrama de Bode: Deflexão Aileron - Velocidade angular p")
subplot(1,2,2)
bode(h(2,2));
xtitle("Diagrama de Bode: Deflexão Leme - Velocidade angular p")

scf(2)
subplot(1,2,1)
bode(h(3,1));
xtitle("Diagrama de Bode: Deflexão Aileron - Velocidade angular r")
subplot(1,2,2)
bode(h(3,2));
xtitle("Diagrama de Bode: Deflexão Leme - Velocidade angular r")

scf(3)
subplot(1,2,1)
bode(h(4,1));
xtitle("Diagrama de Bode: Deflexão Aileron - Ângulo phi")
subplot(1,2,2)
bode(h(4,2));
xtitle("Diagrama de Bode: Deflexão Leme - Ângulo phi")

C = [[0,0,0,1];[0,0,1,0]]
D = [[0,0];[0,0]]
