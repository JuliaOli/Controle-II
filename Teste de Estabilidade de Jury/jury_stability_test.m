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
%P(z)= a_0*z^n + a_1*z^{n-1} +...+ a_{n-1}*z + a_n , where a_0 > 0. 


%Equ2 = w_2 >= 0
%Equ3 = b1 >= 0
%Equ4 = c1 = w_0 >= 0


syms K;
T = 0.1;

a0 = 1;
a1 = 111.6*T^2 + 16.74*T - 3;
a2 = 3 - 33.48*T + 1.395*10^(-4)*K*T^3;
a3 = 1.395*10^(-4)*K*T^3 + 16.74*T - 111.6*T^2 - 1;

%% Jury Stability Test 

%Equ1 = an = a3 < a0(=1)

Equ_1 = a3 == a0;
Equ_sol_1 = solve(Equ_1,K);

%P(z)|z=1 > 0; P(z) = z³ + a1*z² + a2*z + a3
Equ_2 = 1 + a1 + a2 + a3 == 0;
Equ_sol_2 = solve(Equ_2,K);

% P(z)|z=-1 > 0 p/ n par e P(z)|z=-1 < 0 for n impar
%sistema é de terceira ordem logo é impar e a condicao: P(z)|z=-1 < 0 for n impar
% P(z) = z³ + a1*z² + a2*z + a3
Equ_3 = -1 + a1 - a2 + a3 == 0;
%Equ_sol_3 = solve(Equ_3,K);

%Condicao da tabela
D = @(s1,s2,s3,s4) ((s1*s4)-(s2*s3));
% |b(n-1)| > |b0|
b0 = D(a3,a2,a0,a1) == 0;
Equ_sol_b_0 = solve(b0,K)

b1 = D(a3,a1,a0,a2) == 0;
Equ_sol_b_1 = solve(b1,K)

b2 = D(a3,a0,a0,a3) == 0;
Equ_sol_b_2 = solve(b2,K)
Equ_sol_b_2_1 = abs(Equ_sol_b_2(1)) %peguei só a parte que deu certo descartei a outra

% |c(n-2)| > |c0|
%tem duas raizes deu ruim faz duas vezes!!!!
%pega as maiores raizes e usa elas
c0 = D(b1,b0,b0,b1) == 0
%Equ_sol_c = solve(c0,K)

%Equacao generica de Routh-Hurwitz
D = @(s1,s2,s3,s4) (-1)*((s1*s4)-(s2*s3))/s3;

% %% Encontrando c_0 que é igual a w_0
% B_1 = D(w_3, w_1, w_2, w_0);
% C_1 = D(w_2, w_0, B_1, 0);
% 
% Equ_4 = C_1 == 0;
% 
% Equ_sol_4 = solve(Equ_4,T);
% 
% T_final = Equ_sol_4;
% 
% %% Encontrando w_3
% 
% Equ_1 = w_3 == 0
% Equ_sol_1 = solve(Equ_1,K);
% 
% %% Encontrando w_2
% 
% Equ_2 = w_2 == 0;
% Equ_sol_2 = solve(Equ_2, K);
% 
% %% Encontrando b1
% Equ_3 = B_1 == 0
% Equ_sol_3 = solve(Equ_3, K);
% 
% %% Equations pra plotar grafico
% 
% %Encontrar K em relation a T (sao dois)
% Q_1 = matlabFunction(Equ_sol_2);
% 
% %Q2 possui raizes negativas
% %Como procuramos estabilidade ignoramos a parte negativa
% Q_2 = matlabFunction(Equ_sol_3(1));
% 
% %Definindo o intervalo de tempo com T maximo como valor final
% Ts = double([0:0.001:T_final]) 
% 
% %Existem dois valores de K posseveis para estabilidade
% K_final_1 = arrayfun(Q_1, Ts)
% K_final_2 = arrayfun(Q_2, Ts)
% 
% %% Cada valor de K em relacao a T
% %Valores de K para que a funcao seja estável pelo critério de Routh-Hurwitz
% 
% figure(1)
% semilogy(Ts,K_final_1, 'k')
% hold on
% semilogy(Ts,K_final_2, 'r')
% xlabel('T(Sample Time)')
% ylabel('K (Possible Values)')
% 
