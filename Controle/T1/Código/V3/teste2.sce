Ar = [0,1;0,0]

Ke = -inv(C*B)*(-C*A)
K = inv(C*B)*Ar
disp(A)
disp(B*K*C)
disp(B*Ke)
lambda = [A-B*Ke, B*K;zeros(2,4),Ar]
t0 = 0 // Definição do intervalo de tempo
dt = 0.1
n = 10
tf = t0 + dt*(n-1)
t = t0:dt:tf
x0 = [0;0.5;0;1;0;0.5] // Condições inicias
x1=[]
x2=[]
x3=[]
x4=[]
y1 = []
y2 = []
yr1=[]
yr2=[]
for i = 1:n // Simulação via matriz de transição
    T = t0 + dt*(i-1)
    x = []
    x = expm(lambda*(T-t0))*x0
    x1(i)=x(1)
    x2(i)=x(2)
    x3(i)=x(3)
    x4(i)=x(4)
    yr1(i)=x(5)
    yr2(i)=x(6)
end
x = []
x = [x1';x2';x3';x4']
y = C*x
y1 = y(1,:)
y2 = y(2,:)
scf(0)
scf(0)
plot2d(t,x1)
plot2d(t,yr1,style=3)
scf(1)
plot2d(t,x2)
plot2d(t,yr2,style=3)

