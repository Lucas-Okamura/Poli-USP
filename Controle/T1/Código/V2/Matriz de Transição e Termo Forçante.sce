// Matriz de Transição e termo forçante
t0 = 0
dt = 0.1
n = 500
x0 = [1;1;1;1]
function input = u(t)
    u1 = 0
    u2 = 0
    input = [u1;u2]
endfunction
x1 =[]
x2 =[]
x3 =[]
x4 =[]
for i = 1:n
    t = t0+(i-1)*dt
    mt = expm(A*(t-t0))*x0
    disp(mt)
    tf1 = integrate('(expm(A*(t-d))*B*[0;0])(1)','d',t0,t)
    tf2 = integrate('(expm(A*(t-d))*B*[0;0])(2)','d',t0,t)
    tf3 = integrate('(expm(A*(t-d))*B*[0;0])(3)','d',t0,t)
    tf4 = integrate('(expm(A*(t-d))*B*[0;0])(4)','d',t0,t)
    x1(i) = mt(1)+tf1
    x2(i) = mt(2)+tf2
    x3(i) = mt(3)+tf3
    x4(i) = mt(4)+tf4
end
tint = t0:dt:(t0+(n-1)*dt)
x=[]
x = [x1';x2';x3';x4']
y=[]
y = C*x
scf(0)
plot2d(tint,y(1,:),style=3)
scf(1)
plot2d(tint,y(2,:),style=3)
