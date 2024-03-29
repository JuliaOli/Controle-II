clear all
clc

% Assume that the characteristic equation is as follows,
% P(z)= a_0*z^n + a_1*z^{n-1} +...+ a_{n-1}*z + a_n , where a_0 > 0. 
% Condicoes de estabilidade
% a0 > 0 ok
% |an| < a0
% P(z)|z=1 > 0
% P(z)|z=-1 > 0 p/ n par e P(z)|z=-1 < 0 for n impar
% |b(n-1)| > |b0|
% |c(n-2)| > |c0|
% Tamanho da Tabela de Jury: 2n - 3 = 3

%Equacao
%P(z) = z³ + a1*z² + a2*z + a3 = 0
%Equacao por jury
%P(z)= a_0*z^n + a_1*z^{n-1} +...+ a_{n-1}*z + a_n

%% Variaveis
syms K;
T = 0.1;

a0 = 1;
a1 = 111.6*T^2 + 16.74*T - 3;
a2 = 3 - 33.48*T + 1.395*10^(-4)*K*T^3;
a3 = 1.395*10^(-4)*K*T^3 + 16.74*T - 111.6*T^2 - 1;

%% Jury Stability Test 
%Equ1 = an = a3 > |a0| (=1)

Equ_1 = a3 == a0;
Equ_sol_1 = solve(Equ_1,K);

%% P(z)|z=1 > 0;
%P(z) = z³ + a1*z² + a2*z + a3

Equ_2 = 1 + a1 + a2 + a3 == 0;
Equ_sol_2 = solve(Equ_2,K);

%% P(z)|z=-1 > 0 p/ n par e P(z)|z=-1 < 0 for n impar
%sistema é de terceira ordem logo é impar e a condicao: P(z)|z=-1 < 0 for n impar

Equ_3 = -1 + a1 - a2 + a3 == 0;
Equ_sol_3 = solve(Equ_3,K);

%% Condicao da tabela |b(n-1)| > |b0|
b0 = [a3,a2;a0,a1];
D_b0 = det(b0);
Equ_b_0 = matlabFunction(abs(D_b0));

%%
b2 = [a3,a0;a0,a3]
D_b2 = det(b2)
Equ_b_2 = matlabFunction(abs(D_b2));

%%
% Os valores possíveis de K em relação a o a0 encontrado
Ts = double([0:1000:Equ_sol_1]);

K_final_1 = arrayfun(Equ_b_0, Ts);
K_final_2 = arrayfun(Equ_b_2, Ts);

figure(1)

plot(Ts, K_final_1, 'b')
hold on
plot(Ts, K_final_2, 'r')
title('Teste de Estabilidade de Jury')
xlabel('K(Sample Time)')
ylabel('B0 and B2 Values')

%PARA UM T=0.1s, K TEM QUE TER UM VALOR MENOR DO QUE AQUELE PONTINHO QUE EU
%ACHEI NO ṔLOT E TA MARCADO LA, PARA PODER SER ESTÁVEL
%Os valores máx encontrados pelo criteiro de Routh-Hurwitz deram
%aproximados do valores pelo Teste de Estabilidade de Jury
