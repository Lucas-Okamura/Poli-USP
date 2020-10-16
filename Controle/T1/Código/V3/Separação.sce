// Programa para executar o princípio da separação, realizando o controle do sistema a partir do 
lambda = [A-B*Kc,B*Kc;zeros(4,4),A-Ko*C] // Crianção da matriz lambda
t0 = 0 // Definição do intervalo de tempo
dt = 0.1
n = 50
tf = t0 + (n-1)*dt
t = t0:dt:tf
x0 = [1;1;1;1;0;0;0;0] // Condições inicias
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

