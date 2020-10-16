function plotter_separacao(x0_c, x0_ob ,A,B,K,Ko)
    lambda = [[A-B*K B*K];
                 [zeros(size(A,1), size(A,1)) A-Ko*C]]
    polos = spec(lambda)
    polos_cont = polos(1:size(A,1))
    polos_obs = polos(size(A,1)+1:2*size(A,1))
    disp('Os polos do controlador são:')
    disp(polos_cont)
    disp('Os polos do observador são:')
    disp(polos_obs)
    scf(0)
    scatter(real(polos_cont),imag(polos_cont), marker = '.')
    scatter(real(polos_obs),imag(polos_obs), marker = 'filled diamond')
    legend('Polos do controlador', 'Polos do observador')
    //Matriz de transição
    dt = 0.1
    nit = 1400
    x1 = []
    x2 = []
    x3 = []
    x4 = []
    xob1 = []
    xob2 = []
    xob3 = []
    xob4 = []
    for i = 1:nit
        t = (i-1)*dt
        sigma = expm(lambda*t)
        x = sigma*[x0_c;x0_ob]
        x1(i) = x(1)
        x2(i) = x(2)
        x3(i) = x(3)
        x4(i) = x(4)
        xob1(i) = -x(5)+x(1)
        xob2(i) = -x(6)+x(2)
        xob3(i) = -x(7)+x(3)
        xob4(i) = -x(8)+x(4)
        end
    t = 0:dt:(nit-1)*dt
    scf(1)
    plot2d(t,x1)
    plot2d(t,xob1, style = 5)
    legend('Velocidade v', 'Estimativa Velocidade v',[4])
    xtitle('Gráfico velocidade v (m/s)')
    xlabel('Tempo (s)')
    ylabel('Velocidade v (rad/s)')
    xgrid()
    scf(2)
    plot2d(t,x2)
    plot2d(t,xob2, style = 5)
    legend('Velocidade angular p', 'Estimativa Velocidade angular p',[4])
    xtitle('Gráfico velocidade angular p (rad/s)')
    xlabel('Tempo (s)')
    ylabel('Velocidade angular p (rad/s)')
    xgrid()
    scf(3)
    plot2d(t,x3)
    plot2d(t,xob3, style = 5)
    legend('Velocidade angular r', 'Estimativa Velocidade angular r',[4])
    xtitle('Gráfico velocidade angular r (rad/s)')
    xlabel('Tempo (s)')
    ylabel('Velocidade angular r (rad/s)')
    xgrid()
    scf(4)
    plot2d(t,x4)
    plot2d(t,xob4, style = 5)
    legend('Ângulo phi', 'Estimativa ângulo phi',[4])
    xtitle('Gráfico ângulo phi (rad)')
    xlabel('Tempo (s)')
    ylabel('Ângulo phi (rad)')
    xgrid()
endfunction

//Exemplo de aplicação
x0_c = [1;0;0;0]
x0_ob = [0;1;0;1]
plotter_separacao(x0_c, x0_ob,A,B,Kclq,Kolq)
