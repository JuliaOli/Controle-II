clear all
clc

Ts = 1;
num = [1];
den = [10 1];

G = tf(num, den)

G_z = c2d(G, Ts)

% Polos das funcoes
num_g_z = cell2mat(G_z.Numerator) 
den_g_z = cell2mat(G_z.Denominator)
den_g = cell2mat(G.Denominator)

%% Agora precisa achar os dados

%Calcular Polo desejado
pol = exp(-Ts/den_g(1))

% encontrar os n's
n_a = length(den_g_z)-1;

n_b = length(num_g_z)-1;

d = length(num_g_z)-1;

n_r = n_b + d -1
n_s = n_a - 1

% Polinomio desejado
P = [1 -pol]

%Encontrando o R
R = P(1)

%Encontrando o S
syms s
S = (num_g_z(2)*s + den_g_z(2)*R) == -pol
solve_S = solve(S)

S_s = 0
% Encontrar T: P  = 1 - 0,9048 // B = 0,095 // T = P(1)/B(1)
T = (P(1) + P(2))/num_g_z(2)
%%
G_c =feedback(G_z*(1/R),S_s)
%G_final = T*
figure(1)
step(G_c)
figure(2)
r = [zeros(1,100) 3*ones(1,100) 2*ones(1,100) 4*ones(1,100) 5*ones(1,100)]
t = 0:1:499;
lsim(G_c,r,t)
