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
<<<<<<< HEAD

%Condicoes
%Equ1 = w_3 >= 0
%Equ2 = w_2 >= 0
%Equ3 = b1 >= 0
%Equ4 = c1 = w_0 >= 0
=======
% s1_matrix = [w_3,w_1; w_2,w_0];
% s1 = det(s1_matrix)/s1_matrix
% 
% s0_matrix = [w_2,w_0;s1,0];
% s0 = det(s0_matrix)/s1
D = @(s1, s2, s3, s4)((s1*s4)-(s2*s3))/s3;
%encontrando B1 e C1
B_1 = D(w_3, w_1, w_2, w_0);
C_1 = D(w_2, w_0, B_1, 0);

eqnT = C_1 == 0;
solveT = solve(eqnT,T);

%Vc achou esse T_MAX = 100/837 e ficou outras duas fun��es em fun��o de K e T, n�o foi?
% O que voc� precisa fazer depois disso �: 
% 
% 1 - usar solve(eq, K) nessas equa��es que sobraram (ainda sem substituir T);
% 2 - transformar o resultado dos solves em fun��es usando a fun��o do matlab "matlabFunction(Solved)"
% 3 - aplicar os valores de T nessas fun��es acima: 0:0.0001:T_MAX

eqnK = B_1 == 0;
solveK = solve(eqnK,K);
B_K = matlabFunction(solveK);

start_t = 0;
end_t   = 8; % end of simulation time
Ts      = 0.0001;

vector_time = solveT/Ts
t_tempo = start_t:Ts:solveT;
%%
vector_B = zeros(vector_time,1);

for count = 1:vector_time
    vector_B(count) = B_K(count)
end

%Equacao generica de Routh-Hurwitz
D = @(s1,s2,s3,s4) (-1)*((s1*s4)-(s2*s3))/s3;

%% Encontrando c_0 que é igual a w_0
B_1 = D(w_3, w_1, w_2, w_0)
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
Q_1 = matlabFunction(Equ_sol_2)
Q_2 = matlabFunction(Equ_sol_3(1)) %ignorando raizes negativas, porque não dá bom

Ts = double([0:0.001:T_final])
K_final_1 = arrayfun(Q_1, Ts)
K_final_2 = arrayfun(Q_2, Ts)

%% Cada valor de K em relacao a T
%Valores de K para que a funcao seja estável pelo critério de Routh-Hurwitz
%T é o sample time p/ cada valor de K é estável

figure(1)
semilogy(Ts,K_final_1, 'k')

hold on
semilogy(Ts,K_final_2, 'r')
xlabel('T(Sample Time)')
ylabel('K(K possible values)')

