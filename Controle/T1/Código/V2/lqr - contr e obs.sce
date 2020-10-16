// Criação das matrizes K do controlador e do observador via LQR
Qc = [4,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1] // Matriz Q do controlador
Pc = [10**5,0;0,10**4] // Matriz P do controlador
slc = syslin('c',A,B,C) // Criação do sistema linear do espaço de estados para o controlador
Kclq = lqr(slc,Qc,Pc) // Definição da matriz Kc
Qo = [10,0,0,1;0,5,0,1;0,0,1,0;1,1,0,0] // Matriz Q do observador
Po = [10**4,0;0,10**2] // Matriz P do observador
slo = syslin('c',A',C',B') // Criação do sistema linear do espaço de estados para o observador
Kolq = (lqr(slo,Qo,Po))' //Definição da matriz Ko
 
