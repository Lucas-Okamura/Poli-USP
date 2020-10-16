// Verifica a controlabilidade e a observabilidade do sistema

Ct = [B A*B A*A*B A*A*A*B] // Matriz de controlabilidade
if rank(Ct) >= size(A) then // Verifica se o posto da matriz de controlabilidade é igual
    // ou superior à dimensão da matriz A
    disp('O sistema é controlável!')
else
    disp('O sistema não é controlável!')
end

Ob = [C;C*A;C*A*A;C*A*A*A]
if rank(Ob) >= size(A) then
    disp('O sistema é observável!')
else
    disp('O sistema não é observável!')
end
