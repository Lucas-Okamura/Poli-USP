clear all
clc 

// Grupo 11
// Gabriel de Sousa Araujo - 9299341 - gabriel_araujo@usp.br
// Gustavo Lopes Oliveira - 10335490 - gustavo.l.oliveira@usp.br
// Herval Pereira de Castro Junior - 10335792 - hervalcastro@usp.br
// Leonardo Silva Almeida Serra - 10335656 - leonardoserra@usp.br
// Lucas Hideki Takeuchi Okamura - 9274315 - lucasokamura@usp.br

// Tarefa 0

// Parâmetros do motor de corrente contínua:
J=0.01;
b=0.1;
K=0.01;
L=0.5;
R=1;

// Modelo no espaço de estados:
A=[-b/J K/J;-K/L -R/L];
B=[0;1/L]
C=[1 0];
D=0;
motor=syslin('c',A,B,C,D);

// Função de transferência do motor:
Gmotor=ss2tf(motor);

// Compensador PID
KP=100;
KI=200;
KD=10;
s=poly(0,'s');
Gpid=syslin('c',KP+(KI/s)+KD*s);

// Conexão em série do compensador PID e do motor (malha aberta):
Gma=Gpid*Gmotor;

// Fechamento da malha (feedback), com feedback unitário:
Gfb=syslin('c',s/s); // feedback unitário

// Fechando a malha (Gmf é a função de transferência de malha fechada):
Gmf=Gma/.Gfb;

// Simulação para entrada degrau unitário:
DT=0.001;
Tf=10;
t=0:DT:(Tf-DT);
u=ones(t);
x0=[0;0;0];
y=csim(u,t,Gmf,x0);
scf(0)
plot2d(t,y);
xtitle('Saida controlada por PID: Método do trapézio','t (s)','y (rad/s)');

scf(1)
plot2d(t,y);     // Repetindo plot no tempo contínuo para comparação
xtitle('Saida controlada por PID: Método Para trás','t (s)','y (rad/s)');

// Tarefas 1 e 2

// Modelo em tempo discreto do motor de corrente contínua usando o
// segurador de ordem zero (ZOH):
T=[0.25, 0.1, 0.05] // Períodos de amostragem

// Realizando um loop para cada valor de período de amostragem
for k = 1:length(T)
    // dscr obtém o modelo em tempo discreto de uma planta no espaço de estado
    // usando o ZOH.
    motorD=dscr(motor,T(k));
    
    // função de transferência do motor em tempo discreto (ZOH):
    GmotorD=ss2tf(motorD);
    
    // Simulando o sistema com compensador PID usando as equações de diferenças:
    
    // Equações de diferenças para o modelo em tempo discreto do motor de corrente
    // contínua:
    nMD=coeff(GmotorD.num);
    dMD=coeff(GmotorD.den);
    n=length(nMD);
    d=length(dMD);
    
    if d>n then
        p=d;
    else
        p=n;
    end
    
    // Condições iniciais - motor
    for i=1:(p-1)
        um(i)=0;
        ym(i)=0;
        e(i)=1;
    end
    
    // Equações de diferenças:
    
    // Considerando a regra do trapézio tem-se: 1/s -> 2/T*(z+1)/(z-1)
    // Então para o PID com U/E = Kp + Ki/s + Kds:
    // Z--> U/E = Kp + Ki*2/T*(z+1)/(z-1) + Kd*T/2*(z-1)/(z+1)
    KP=1;
    KI=2;
    KD=0.1;
    
    z=poly(0,'z');
    GpidD = syslin('d',((KP+T(k)*KI/2+KD/T(k))*z^2+(T(k)*KI/2-KP-2*KD/T(k))*z+KD/T(k))/(z*(z-1)))
    
    nPD=coeff(GpidD.num);
    dPD=coeff(GpidD.den);
    u=ones(t);
    
    for i = p:length(t)
         e(i) = e(i-1);
         um(i) = -dPD(:,1:$-1)*um(i-(p-1):i-(p-2)) + nPD*e(i-(p-1):i);
         ym(i) = -dMD(:,1:$-1)*ym(i-(p-1):i-(p-2)) + nMD*um(i-(p-n):i); 
         e(i) = u(i) - ym(i);  
    end
    scf(0)
    plot2d(t,ym,2*k+1);
    
    // Para o método de "Backward Rule", o equacionamento altera-se ligeiramente, sendo 
    // que o tem-se para o valor de s: 1/s = T / (z-1)
    // Para o PID considerado, então, tem-se:
    // Z--> U/E = Kp + Ki*T/(z-1) + Kd*(z-1)/T
    // Distributiva do PID encontrado pelo metodo backward
    GpidD2 = syslin('d',((KP + KD/T(k))*z^2 +(T(k)*KI-KP-2*KD/T(k))*z+KD/T(k))/(z*(z-1)))
    
    // E, repetindo os passos anteriores para encontrar a resposta no tempo:
    nPD=coeff(GpidD2.num);
    dPD=coeff(GpidD2.den);
    u=ones(t);  
    
    for i = p:length(t)
         e(i) = e(i-1);
         um(i) = -dPD(:,1:$-1)*um(i-(p-1):i-(p-2)) + nPD*e(i-(p-1):i);
         ym2(i) = -dMD(:,1:$-1)*ym(i-(p-1):i-(p-2)) + nMD*um(i-(p-n):i); 
         e(i) = u(i) - ym(i);  
    end
    
    // Elaborando o grafico para método para tras
    scf(1)
    plot2d(t,ym2,2*k+1);
end

scf(0)
legend("Tempo Contínuo", "Discreto T = 0.25 s", "Discreto T = 0.1 s", "Discreto T = 0.05 s", 4)

scf(1)
legend("Tempo Contínuo", "Discreto T = 0.25 s", "Discreto T = 0.1 s", "Discreto T = 0.05 s", 4)
