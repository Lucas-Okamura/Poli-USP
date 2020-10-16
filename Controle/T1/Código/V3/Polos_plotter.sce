Contr_LQ = (spec(A-B*Kclq))
Contr_AL = (spec(A-B*Kcal))

Obs_LQ = (spec(A-Kolq*C))
Obs_AL = (spec(A-Koal*C))

Contr_LQy = [imag(Contr_LQ(1)), imag(Contr_LQ(2)), imag(Contr_LQ(3)), imag(Contr_LQ(4))]
Contr_LQx = [real(Contr_LQ(1)), real(Contr_LQ(2)), real(Contr_LQ(3)), real(Contr_LQ(4))] 

Contr_ALy = [imag(Contr_AL(1)), imag(Contr_AL(2)), imag(Contr_AL(3)), imag(Contr_AL(4))]
Contr_ALx = [real(Contr_AL(1)), real(Contr_AL(2)), real(Contr_AL(3)), real(Contr_AL(4))] 

Obs_LQy = [imag(Obs_LQ(1)), imag(Obs_LQ(2)), imag(Obs_LQ(3)), imag(Obs_LQ(4))]
Obs_LQx = [real(Obs_LQ(1)), real(Obs_LQ(2)), real(Obs_LQ(3)), real(Obs_LQ(4))] 

Obs_ALy = [imag(Obs_AL(1)), imag(Obs_AL(2)), imag(Obs_AL(3)), imag(Obs_AL(4))]
Obs_ALx = [real(Obs_AL(1)), real(Obs_AL(2)), real(Obs_AL(3)), real(Obs_AL(4))] 

scf(1)
plot2d(Contr_ALx, Contr_ALy, -4, rect=[-0.85,-0.4, 0,0.4])
plot2d(Obs_ALx, Obs_ALy, -9, rect=2*[-0.85,-0.4, 0,0.4])
title(["Polos do Observador e Controlador - Alocação de Polos"], "fontsize", 4)
legends(["Controlador", "Observador"], [-4, -9], 3, "fontsize", 4)

scf(2)
plot2d(Contr_LQx, Contr_LQy, -4)
plot2d(Obs_LQx, Obs_LQy, -9)
title(["Polos do Observador e Controlador - Método LQ"], "fontsize", 4)
legends(["Controlador", "Observador"], [-4, -9], 4, "fontsize", 4)
