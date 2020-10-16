// Código para alocação de polos do controlador e do observador
pc = [-1,-1+0.5*%i,-1-0.5*%i,-0.8] // Polos desejados para o controlador
Kcal = ppol(A,B,pc) // Definição da matriz K do controlador
po = 2*pc // Polos desejados para o observador
Koal = (ppol(A',C',po))' // Definição da matriz K do observador
