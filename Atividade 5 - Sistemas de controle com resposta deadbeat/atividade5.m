close all
clc

Ts = 1;
num = [1 0.5];
den = [1 -2.05 1.325 -0.252];

G_p = tf(num,den,1)
G_p = G_p*0.05
%%
ordem_den = length(den)
ordem_num = length(num)
n = ordem_den - ordem_num

%%
M = tf('z', Ts);
M = M^(-n)

%%
G_aux = G_p^(-1)
M_aux = M/(1-M)
%%
D_c = M_aux*G_aux;

C = (D_c*G_p)/(1+D_c*G_p)

step(C, 100, 'r')
hold on
step(G_p, 100, 'k')
