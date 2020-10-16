// Criação das matrizes K do controlador e do observador via LQR
Qc = [1,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1] // Matriz Q do controlador
Pc = 10*[1,0;0,1] // Matriz P do controlador
Rc = ricc(A, B*inv(Pc)*B', Qc, "cont")
Kclq = inv(Pc)*B'*Rc // Definição da matriz Kc

Qo = [30,0,0,0;0,60,0,0;0,0,1,0;0,0,0,30] // Matriz Q do observador
Po = 80*[1,0;0,1] // Matriz P do observador
Ro = ricc(A', C'*inv(Po)*C, Qo, "cont")
Kolq = Ro*C'*inv(Po) //Definição da matriz Ko