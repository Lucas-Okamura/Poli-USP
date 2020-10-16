// Simulação via integração numérica do espaço de estados

function entradas = u(t) // Entradas para simulação via integração numérica do espaço dos estados
    u1 = 0
    u2 = 0
    entradas = [u1;u2]
endfunction
function dist = p(t) // Disturbios para simulação via integração numérica do espaço de estados
    p1 = 0
    p2 = 0
    p3 = 0
    dist = [p1;p2;p3]
endfunction
function dx = f(t,x) // Função para simulação via integração do espaço de estados
    dx = A*x+B*u(t)+E*p(t)
endfunction

// Intervalo de tempo da simulação
t = []
t0 = 0
dt = 0.01
tf = 50
t = t0:dt:tf

// Condições iniciais
x0 = [1;1;1;1]

// Integração via ode
x =[]
x = ode(x0,t0,t,f) // integração numérica

// Determinação da saída observável
U1 = []
U2 = []
for i = 1:((tf-t0)/dt)+1 // entradas
    T = t0 + dt*(i-1)
    ent = u(T)
    U1(i) = ent(1)
    U2(i) = ent(2)
end
U = [U1,U2]'
y =[]
y = C*x+D*U

scf(0)
plot2d(t,y(1,:))
scf(1)
plot2d(t,y(2,:))
