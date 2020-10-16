function plotter_controlador(x0,A,B,Kal,Klq)
    // Kal é a matriz de ganho para alocação de polos
    //Klq é a matriz de ganho para controle LQR
    // Matriz de transição
    dt = 0.1
    nit = 100
    x1 = []
    x2 = []
    x3 = []
    x4 = []
    dt = 0.1
    nit = 1400
    for i = 1:nit
        t = (i-1)*dt
        sigma = expm((A-B*Kal)*t)
        xal = sigma*x0
        x1al(i) = xal(1)
        x2al(i) = xal(2)
        x3al(i) = xal(3)
        x4al(i) = xal(4)
    end
    for i = 1:nit
        t = (i-1)*dt
        sigma = expm((A-B*Klq)*t)
        xlq = sigma*x0
        x1lq(i) = xlq(1)
        x2lq(i) = xlq(2)
        x3lq(i) = xlq(3)
        x4lq(i) = xlq(4)
    end
    t = 0:dt:(nit-1)*dt
    disp('Os polos do controlador por alocação de polos são:')
    disp(spec(A-B*Kal))
    disp('Os polos do controlador por método LQR são:')
    disp(spec(A-B*Klq))
    scf(0)
    plot2d(t,x1al)
    plot2d(t,x1lq, style = 5)
    legend('Alocação de Polos', 'LQR',[4])
    xtitle('Gráfico velocidade v (m/s)')
    xlabel('Tempo (s)')
    ylabel('Velocidade v (rad/s)')
    xgrid()
    scf(1)
    plot2d(t,x2al)
    plot2d(t,x2lq, style = 5)
    legend('Alocação de Polos', 'LQR',[4])
    xtitle('Gráfico velocidade angular p (rad/s)')
    xlabel('Tempo (s)')
    ylabel('Velocidade angular p (rad/s)')
    xgrid()
    scf(2)
    plot2d(t,x3al)
    plot2d(t,x4lq, style = 5)
    legend('Alocação de Polos', 'LQR',[4])
    xtitle('Gráfico velocidade angular r (rad/s)')
    xlabel('Tempo (s)')
    ylabel('Velocidade angular r (rad/s)')
    xgrid()
    scf(3)
    plot2d(t,x4al)
    plot2d(t,x4lq, style = 5)
    legend('Alocação de Polos', 'LQR',[4])
    xtitle('Gráfico ângulo phi (rad)')
    xlabel('Tempo (s)')
    ylabel('Ângulo phi (rad)')
    xgrid()
endfunction

//Exemplo de aplicação
x0 = [1;0;0;0]
plotter_controlador(x0,A,B,Kcal,Kclq)
