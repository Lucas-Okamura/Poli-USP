Ar = [0,0,0,1;0,0,0,0;0,0,0,0;0,0,0,0]
F = A-Ar
Ke = inv(C*inv(A-B*Kc)*B)*C*inv(A-B*Kc)*F
lambda = [A-B*Kc B*(Kc-Ke);zeros(4,4) Ar]
t0 = 0 // Definição do intervalo de tempo
dt = 0.1
n = 500
tf = t0 + dt*(n-1)
t = t0:dt:tf
x0 = [1;1;1;1;0;0;0;2] // Condições inicias
x1=[]
x2=[]
x3=[]
x4=[]
e1=[]
e2=[]
e3=[]
e4=[]
for i = 1:n // Simulação via matriz de transição
    T = t0 + dt*(i-1)
    x = expm(lambda*(T-t0))*x0
    x1(i)=x(1)
    x2(i)=x(2)
    x3(i)=x(3)
    x4(i)=x(4)
    e1(i)=x(5)
    e2(i)=x(6)
    e3(i)=x(7)
    e4(i)=x(8)
end
scf(0)
plot2d(t,x1)
scf(1)
plot2d(t,e1)
scf(2)
plot2d(t,x2)
scf(3)
plot2d(t,e2)
