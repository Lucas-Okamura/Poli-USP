// Dados do Boeing 747 para altitude de 40.000 pés e Mach = 0.90 ref. Nelson
// Coeficientes laterais
cyb = -0.96 
cyp = 0
cyr = 0
clb = -0.221
cnb = 0.150
clp = -0.45
cnp = -0.121
clr = 0.101
cnr = -0.30
clda = 0.0461
cnda = 0.0064
cydr = 0.175
cldr = 0.007
cndr = -0.109
// Dimensões
S = 5500*0.092903 // Área alar
b = 195.68*0.3048 // Envergadura
c = 27.31*0.3048 // Corda média

//Massa
m = 636600*0.453592
// Momentos de inércia
Ix = 18.2*10^6*1.35581795
Iy = 33.1*10^6*1.35581795
Iz = 49.7*10^6*1.35581795

u0 = 85.75 // Velocidade de cruzeiro do Boeing 747

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
