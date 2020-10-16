// Dados do Boeing 747 para altitude de 40.000 pés e Mach = 0.90 ref. Nelson
// Coeficientes laterais
cyb = -0.85 
cyp = 0
cyr = 0
clb = -0.10
cnb = 0.20
clp = -0.30
cnp = 0.20
clr = 0.20
cnr = -0.325
clda = 0.014
cnda = 0.003
cydr = 0.075
cldr = 0.005
cndr = -0.09
// Dimensões
S = 510.97 // Área alar
b = 59.64 // Envergadura
c = 8.32 // Corda média

//Massa
m = 288756.9
// Momentos de inércia
Ix = 24.68*10^6 
Iy = 44.88*10^6
Iz = 67.38*10^6

u0 = 236.11 // Velocidade de cruzeiro do Boeing 747

// Dados do ambiente

rho = 3.639*10^-1 // Densidade atmosférica
g = 9.81 // Gravidade


// Pré-cálculo das constantes do espaço de estados

Q = 1/2*rho*u0^2
Fyv = Q*S*cyb/u0
Fyp = Q*S*b*cyp/(2*u0)
Fyr = Q*S*b*cyr/(2*u0)
Mxv = Q*S*b*clb/u0
Mxp = Q*S*b^2*clp/(2*u0)
Mxr = Q*S*b^2*clr/(2*u0)
Mzv = Q*S*b*cnb/(u0)
Mzp = Q*S*b^2*cnp/(2*u0)
Mzr = Q*S*b^2*cnr/(2*u0)
Fydr = Q*S*cydr
Mxda = Q*S*b*clda
Mxdr = Q*S*b*cldr
Mzda = Q*S*b*cnda
Mzdr = Q*S*b*cndr

// Constantes da linearização

theta0 = 0

// Definição das matrizes do espaço de estados
// Espaço de Estados do tipo: dx/dt = Ax + Bu e y = Cx + Du

A = [[Fyv/m,Fyp/m,(Fyr/m-u0/u0),g*cos(theta0)/u0];[Mxv/Ix,Mxp/Ix,Mxr/Ix,0];[Mzv/Iz,Mzp/Iz,Mzr/Iz,0];[0,1,0,0]]
B = [[0,Fydr/m];[Mxda/Ix,Mxdr/Ix];[Mzda/Iz,Mzdr/Iz];[0,0]]
C = [[1,0,0,0];[0,0,1,0]]
D = [[0,0];[0,0]]
E = [[-Fyv/m,0,0];[Mxv/Ix,Mxp/Ix,Mxr/Ix];[-Mzv/Iz,-Mzp/Iz,-Mzr/Iz];[0,0,0]]
// Solução no espaço do tempo

// Via integração do espaço de estados

function entradas = u(t) // Entradas para simulação via integração numérica do espaço dos estados
    u1 =
    u2 =
    entradas = [u1;u2]
endfunction
function dist = p(t) // Disturbios para simulação via integração numérica do espaço de estados
    p1 =
    p2 = 
    p3 =
    dist = [p1;p2;p3]
endfunction
function dx = f(x,t) // Função para simulação via integração do espaço de estados
    dx = A*x+B*u(t)+E*p(t)
endfunction

// Intervalo de tempo da simulação
t0 = 0
dt = 0.01
tf = 10
t = t0:dt:tf

// Condições iniciais
x0 = [0;0;0;0]

// Integração via ode
x = ode(x0,t,t0,f) // integração numérica

// Determinação da saída observável
for i = 1:((tf-t0)/dt) // entradas
    t = t0 + dt*(i-1)
    U(i) = u(t)
end
y = C*x+D*U

// Simulação no espaço das frequências

// Via matriz de transferência

// Via csim

// Via 
