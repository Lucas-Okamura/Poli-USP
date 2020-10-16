// Código para alocação de polos do controlador e do observador
s = poly(0,'s')
matr = s*eye(4,4)-A
pc = [-0.8,-0.35+0.35707*%i,-0.35-0.35707*%i,-0.0346] // Polos desejados para o controlador
Kcal = ppol(A,B,pc) // Definição da matriz K do controlador
po = 2*pc // Polos desejados para o observador
Koal = (ppol(A',C',po))' // Definição da matriz K do observador
disp(spec(A-B*Kcal))
