// Polos e Zeros
sl = syslin('c',A,B,C,D)
h = ss2tf(sl)
disp(h)
plzr(h(1,1))
s = poly(0,'s')
matr = s*eye(4,4) - A
disp(matr)
disp(C*inv(matr)*B)
disp(roots(det(matr)))
