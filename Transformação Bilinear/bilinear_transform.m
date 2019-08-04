clear all
clc

%The stability analysis using bilinear transformation,
%we first substitute z = (w+1)/(w-1) in the characteristics equation P(z) = 0 
%and simplify it to get the characteristic equation in w -plane as Q(w) = 0. 
%Once the characteristics equation is transformed as Q(w) = 0, 
%Routh stability criterion is directly used in the same manner as in a continuous time system. 

%P(z) = zÂ³ + a2*zÂ² + a1*z + a0 = 0
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

%Vc achou esse T_MAX = 100/837 e ficou outras duas funções em função de K e T, não foi?
% O que você precisa fazer depois disso é: 
% 
% 1 - usar solve(eq, K) nessas equações que sobraram (ainda sem substituir T);
% 2 - transformar o resultado dos solves em funções usando a função do matlab "matlabFunction(Solved)"
% 3 - aplicar os valores de T nessas funções acima: 0:0.0001:T_MAX

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






