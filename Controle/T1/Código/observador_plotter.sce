function plotter_observador(x0,A,C,Koal,Kolq)
    // Koal é a matriz de ganho para observador por alocação de polos
    //Kolq é a matriz de ganho para observador por controle LQR
    // Matriz de transição
    dt = 0.1
    nit = 100
    x1 = []
    x2 = []
    x3 = []
    x4 = []
    dt = 0.1
    nit = 500
    for i = 1:nit
        t = (i-1)*dt
        sigma = expm((A-Koal*C)*t)
        xal = sigma*x0
        x1al(i) = xal(1)
        x2al(i) = xal(2)
        x3al(i) = xal(3)
        x4al(i) = xal(4)
    end
    for i = 1:nit
        t = (i-1)*dt
        sigma = expm((A-Kolq*C)*t)
        xlq = sigma*x0
        x1lq(i) = xlq(1)
        x2lq(i) = xlq(2)
        x3lq(i) = xlq(3)
        x4lq(i) = xlq(4)
    end
    t = 0:dt:(nit-1)*dt
    disp('Os polos do controlador por alocação de polos são:')
    disp(spec(A-Koal*C))
    disp('Os polos do controlador por método LQR são:')
    disp(spec(A-Kolq*C))
    scf(0)
    plot2d(t,x1al)
    plot2d(t,x1lq, style = 5)
    legend('Alocação de Polos', 'LQR')
    xtitle('Gráfico do erro de observação da velocidade v (m/s)')
    xlabel('Tempo (s)')
    ylabel('Velocidade v (rad/s)')
    xgrid()
    scf(1)
    plot2d(t,x2al)
    plot2d(t,x2lq, style = 5)
    legend('Alocação de Polos', 'LQR')
    xtitle('Gráfico do erro de observação da velocidade angular p (rad/s)')
    xlabel('Tempo (s)')
    ylabel('Velocidade angular p (rad/s)')
    xgrid()
    scf(2)
    plot2d(t,x3al)
    plot2d(t,x3lq, style = 5)
    legend('Alocação de Polos', 'LQR')
    xtitle('Gráfico do erro de observação da velocidade angular r (rad/s)')
    xlabel('Tempo (s)')
    ylabel('Velocidade angular r (rad/s)')
    xgrid()
    scf(3)
    plot2d(t,x4al)
    plot2d(t,x4lq, style = 5)
    legend('Alocação de Polos', 'LQR')
    xtitle('Gráfico do erro de observação da ângulo phi (rad)')
    xlabel('Tempo (s)')
    ylabel('Ângulo phi (rad)')
    xgrid()
endfunction

//Exemplo de aplicação
x0 = [0;1;0;1]
plotter_observador(x0,A,C,Koal,Kolq)
