// Polos e Zeros
sl = syslin('c',A,B,C)
plzr(sl)
s = poly(0,'s')
matr = s*eye(4,4) - A
disp(matr)
disp(roots(det(matr)))
