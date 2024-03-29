clear all
clc

%The stability analysis using bilinear transformation,
%we first substitute z = (w+1)/(w-1) in the characteristics equation P(z) = 0 
%and simplify it to get the characteristic equation in w -plane as Q(w) = 0. 
%Once the characteristics equation is transformed as Q(w) = 0, 
%Routh stability criterion is directly used in the same manner as in a continuous time system. 

%P(z) = z³ + a2*z² + a1*z + a0 = 0
%z = (w+1)/(w-1);
%Q(w) = (1+a2+a1+a0)w^3 + (3 + a2 - a1-3a0)w^2 + (3-a2-a1+3a0)w + (1-a2+a1-a0)

syms T K;

a0 = 1.395*10^(-4)*K*T^3 + 16.74*T - 111.6*T^2 - 1;
a1 = 3 - 33.48*T + 1.395*10^(-4)*K*T^3;
a2 = 111.6*T^2 + 16.74*T - 3;

w_3 = (1+a2+a1+a0);
w_2 = (3+a2-a1-3*a0);
w_1 = (3-a2-a1+3*a0);
w_0 = (1-a2+a1-a0);


%% Routh-Hurwitz

%Condicoes
%Equ1 = w_3 >= 0
%Equ2 = w_2 >= 0
%Equ3 = b1 >= 0
%Equ4 = c1 = w_0 >= 0

%Equacao generica de Routh-Hurwitz
D = @(s1,s2,s3,s4) (-1)*((s1*s4)-(s2*s3))/s3;

%% Encontrando c_0 que é igual a w_0
B_1 = D(w_3, w_1, w_2, w_0);
C_1 = D(w_2, w_0, B_1, 0);

Equ_4 = C_1 == 0;

Equ_sol_4 = solve(Equ_4,T);

T_final = Equ_sol_4;

%% Encontrando w_3

Equ_1 = w_3 == 0
Equ_sol_1 = solve(Equ_1,K);

%% Encontrando w_2

Equ_2 = w_2 == 0;
Equ_sol_2 = solve(Equ_2, K);

%% Encontrando b1
Equ_3 = B_1 == 0
Equ_sol_3 = solve(Equ_3, K);

%% Equations pra plotar grafico

%Encontrar K em relation a T (sao dois)
Q_1 = matlabFunction(Equ_sol_2);

%Q2 possui raizes negativas
%Como procuramos estabilidade ignoramos a parte negativa
Q_2 = matlabFunction(Equ_sol_3(1));

%Definindo o intervalo de tempo com T maximo como valor final
Ts = double([0:0.001:T_final]) 

%Existem dois valores de K posseveis para estabilidade
K_final_1 = arrayfun(Q_1, Ts)
K_final_2 = arrayfun(Q_2, Ts)

%% Cada valor de K em relacao a T
%Valores de K para que a funcao seja estável pelo critério de Routh-Hurwitz

figure(1)
semilogy(Ts,K_final_1, 'k')
hold on
semilogy(Ts,K_final_2, 'r')
title('Routh-Hurwitz')
xlabel('T(Sample Time)')
ylabel('K (Possible Values)')

