Ar = [0,0,0,0;0,0,-1,0;0,1,0,0;0,0,0,0]
B2 = E
Aw = 0.01*[0,0,1;0,0,0;-1,0,0]
F = A-B*Kc
F2 = [A-Ar]
Ao = [Aw zeros(3,4);zeros(4,3) Ar]
Ke = inv(C*inv(eye(4,4)-A-B*Kc)*B)*C

//lambdafull = [A-B*Kc,Ay;zeros(7,4),Ao]
lambda = [A-B*Kc, (B*(Kc-Ke));zeros(4,4),Ar]
t0 = 0 // Definição do intervalo de tempo
dt = 0.1
n = 500
tf = t0 + dt*(n-1)
t = []
t = t0:dt:tf
x0 =[]
x0 = [0;0;0;0] // Condições inicias
w0 = [0;1;1]
r0 = [0;0;0.01;0]
c0 = [x0;w0;r0]
x1=[]
x2=[]
x3=[]
x4=[]
xr1=[]
xr2=[]
xr3=[]
xr4=[]
yr =[]
xw1=[]
xw2=[]
xw3=[]
xw=[]
for i = 1:n // Simulação via matriz de transição
    T = t0 + dt*(i-1)
    x = expm(lambda*(T-t0))*[x0;r0]
    xe = expm(lambdafull*(T-t0))*c0
    xr = expm(Ar*(T-t0))*r0
    xw = expm(Aw*(T-t0))*w0
    x1(i)=x(1)
    x2(i)=x(2)
    x3(i)=x(3)
    x4(i)=x(4)
    xe1(i) = xe(1)
    xe2(i) = xe(2)
    xe3(i) = xe(3)
    xe4(i) = xe(4)
    xw1(i)=xw(1)
    xw2(i)=xw(2)
    xw3(i)=xw(3)
    xr1(i)=xr(1)
    xr2(i)=xr(2)
    xr3(i)=xr(3)
    xr4(i)=xr(4)
end
y=[]
yr=[]
y = C*[x1';x2';x3';x4']
yr = C*[xr1';xr2';xr3';xr4']
yw = C*[xe1';xe2';xe3';xe4']
xw = [xw1';xw2';xw3']
scf(0)
plot2d(t,y(1,:))
plot2d(t,yw(1,:),style = 4)
plot2d(t,xw(3,:),style = 5)
plot2d(t,yr(1,:),style=3)
xgrid()
scf(1)
plot2d(t,y(2,:))
plot2d(t,yw(2,:),style = 4)
plot2d(t,yr(2,:),style=3)
xgrid()

