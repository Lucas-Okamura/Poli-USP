%% TRABALHO DE CONTROLE - T2 - 2020
% Controle de movimentos laterais de uma aeronave

clear all
clc
syms s

%% Função de transferência

%Escolheu-se como entrada a deflexão do aileron e como saída a velocidade 
%lateral

%H(s):
Numerador_11 = 0.0005759 + 0.0096525*s - 0.0038725*s^2
%P(s):
Denominador = 0.0000237 + 0.0013412*s +0.027388*s^2 + 0.34822398*s^3 + s^4 

G_11 = tf(sym2poly(Numerador_11), sym2poly(Denominador))
H = 1

GH_11 = G_11*H

%% Polos e Zeros

Zeros = zero(GH_11)
Polos = pole(GH_11)

figure(1)
pzmap(GH_11)

%% Estabilidade por Routh-Hurwitz

% Já feito no T1

%% Análise de tipo e erro em regime permanente para a(s) FT(S) escolhidas

% Escolheu-se a primeira FT ( H(s)/P(s) )

% Ordem: maior grau da equação característica
Ordem = 4
% Tipo:  número de integrações
Tipo = 0

Kp_11 = vpa(limit(Numerador_11/Denominador, s, 0))
Erro_11 = 1 /(Kp_11 + 1)

%% Resposta em malha aberta da(s) FTS mais importantes

% Escolheu-se novamente a primeira FT ( H(s)/P(s) )

figure(2)
step(GH_11)

%% Métodos de Ziegler e Nichols

figure(3)
step(GH_11)

% Determinação do ponto de inflexão
[y,t] = step(GH_11);
ypp = diff(y,2);

Valor = 1000
for i = 1:length(ypp)
    if abs(ypp(i)) < Valor
        Valor = ypp(i)
        I = i
    end
end

hold on
scatter(t(I), y(I), 'ro')

% Determinação da reta
a = ( (y(I)-y(I-1))/(t(I)-t(I-1)) + (y(I)-y(I+1))/(t(I)-t(I+1)) )/2
b = y(I) - a*t(I)

pontosx = 5:0.1:75
pontosy = a*pontosx + b

hold on
plot(pontosx, pontosy)

% Determinação da intersecção entre a reta e o eixo x
Valor = 1000
for i = 1:length(pontosy)
    if abs(pontosy(i)) < Valor
        Valor = abs(pontosy(i))
        I2 = i
    end
end

% Determinação da intersecção entre a reta e a reta horizontal y = K
Valor = 1000
for i = 1:length(pontosy)
    if abs(pontosy(i) - y(length(y))) < Valor
        Valor = abs(pontosy(i)- y(length(y)))
        I3 = i
    end
end

% Determinação dos parâmetros
tan_theta = a
L = pontosx(I2)
T = t(I) - L

Kp_ZN = 1.2*T/L;
Ti_ZN = 2*L;
Td_ZN = L/2;
Ki_ZN = Kp_ZN/Ti_ZN
Kd_ZN = Kp_ZN*Td_ZN

Gc_ZN = pid(Kp_ZN, Ki_ZN, Kd_ZN)

% Resposta
G1_ZN = series(Gc_ZN, GH_11)
T1_ZN = feedback(G1_ZN, 1)

figure(4)
step(T1_ZN)

%% Alocação de Polos

Kp_AP = 0.1203
Ki_AP = 0.00305
Kd_AP = 0.9835

Gc_AP = pid(Kp_AP, Ki_AP, Kd_AP)

G1_AP = series(Gc_AP, GH_11)
T1_AP = feedback(G1_AP, 1)

figure(5)
step(T1_AP)

%% Controle ótimo ITAE

Kp_ITAE = 0.1
Ki_ITAE = 0.004
Kd_ITAE = 1.76

Gc_ITAE = pid(Kp_ITAE, Ki_ITAE, Kd_ITAE)

G1_ITAE = series(Gc_ITAE, GH_11)
T1_ITAE = feedback(G1_ITAE, 1)

figure(6)
step(T1_ITAE)

%% Lugar das Raízes

% Ganho Proporcional
figure(7)
rlocus(GH_11)
Kp_RL = 0.094

% Ganho Integral
GH_i = tf(sym2poly(Numerador_11), sym2poly(s*(Denominador + Kp_RL*Numerador_11)))
figure(8)
rlocus(GH_i)
Ki_RL = 0.0022

% Ganho Derivativo
GH_d = tf(sym2poly(s^2*Numerador_11), sym2poly(s*Denominador + (Kp_RL*s + Ki_RL)*Numerador_11))
figure(9)
rlocus(GH_d)
Kd_RL = 1.06

Gc_RL = pid(Kp_RL, Ki_RL, Kd_RL)
G1_RL = series(Gc_RL, GH_11)

T1_RL = feedback(G1_RL, 1)

figure(10)
step(T1_RL)

% Polos e zeros malha fechada RL
polos_RL = pole(T1_RL)
zeros_RL = zero(T1_RL)
disp("Os polos de malha fechada RL são:")
disp(polos_RL)
disp("Os zeros de malha fechada RL são:")
disp(zeros_RL)

%% Critério de Estabilidade de Nyquist

%Ziegler Nichols
figure(11)
nyqlog(G1_ZN)

%Alocação de Polos
figure(12)
nyqlog(G1_AP)

%ITAE
figure(13)
nyqlog(G1_ITAE)

%Lugar das Raízes
figure(14)
nyqlog(G1_RL)

%% Estabilidade Relativa Usando Bode

%Ziegler Nichols
figure(15)
margin(G1_ZN)

%Alocação de Polos
figure(16)
margin(G1_AP)

%ITAE
figure(17)
margin(G1_ITAE)

%Lugar das Raízes
figure(18)
margin(G1_RL)

%% Capacidade de Seguir Sinal e Rejeitar Distúrbios e 
%  Comparação entre o Desempenho sem Controle e o com Controladores


% Deflexão no aileron determinado: pi/4 rad
Degrau_MA = stepDataOptions('InputOffset', 0, 'StepAmplitude', pi/4)

figure(20)
step(GH_11, Degrau_MA)

% Pela gráfico, tal deflexão causa uma variação de 19.1 m/s.
Degrau_MF = stepDataOptions('InputOffset', 0, 'StepAmplitude', 19.1)

hold on
step(T1_ZN, Degrau_MF)
hold on
step(T1_AP, Degrau_MF)
hold on
step(T1_ITAE, Degrau_MF)
hold on
step(T1_RL, Degrau_MF)

legend("Malha aberta", "Ziegler Nichols", "Alocação de Polos", "ITAE", "Lugar das Raízes")

% Informações sobre os gráficos
disp("Malha aberta")
stepinfo(GH_11)
disp("Ziegler Nichols")
stepinfo(T1_ZN)
disp("Alocação de Polos")
stepinfo(T1_AP)
disp("ITAE")
stepinfo(T1_ITAE)
disp("Lugar das Raízes")
stepinfo(T1_RL)

% Logo, os melhores controladores são o por ITAE e o por lugar das raízes

%% Comparação para Métodos no Domínio do Tempo e Frequência

% Escolheu-se o método por ITAE para realizar a comparação

figure(21)
step(T1_ITAE)