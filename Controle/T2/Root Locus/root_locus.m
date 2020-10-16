%% TRABALHO DE CONTROLE - T2 - 2020
% Controle de movimentos laterais de uma aeronave

clear all
clc
syms s

%% Função de transferência

%Escolheu-se como entrada a deflexão do aileron e como saída 
%H(s):
Numerador_11 = 0.0005759 + 0.0096525*s - 0.0038725*s^2
%P(s):
Denominador = 0.0000237 + 0.0013412*s +0.027388*s^2 + 0.34822398*s^3 + s^4 

G_11 = tf(sym2poly(Numerador_11), sym2poly(Denominador))
H = 1

GH_11 = G_11*H

%% Polos e Zeros

Zeros_11 = vpasolve(Numerador_11  == 0, s)
Polos = vpasolve(Denominador  == 0, s)

figure(1)
pzmap(GH_11)

% Ganho Proporcional
figure(2)
rlocus(GH_11)
Kp = 0.094

% Ganho Integral
GH_i = tf(sym2poly(Numerador_11), sym2poly(s*(Denominador + Kp*Numerador_11)))
figure(3)
rlocus(GH_i)
Ki = 0.0022

% Ganho Derivativo
GH_d = tf(sym2poly(s^2*Numerador_11), sym2poly(s*Denominador + (Kp*s + Ki)*Numerador_11))
figure(4)
rlocus(GH_d)
Kd = 1.06

Gc = pid(Kp, Ki, Kd)
GH_Gc = series(Gc, GH_11)
MF = feedback(GH_Gc, 1)
Degrau_MF = stepDataOptions('InputOffset', 0, 'StepAmplitude', 19.1)
figure(5)
hold on
step(MF, Degrau_MF)

%% Polos e zeros malha fechada RL
polos = pole(MF)
zeros = zero(MF)
disp("Os polos de malha fechada RL são:")
disp(polos)
disp("Os zeros de malha fechada RL são:")
disp(zeros)
