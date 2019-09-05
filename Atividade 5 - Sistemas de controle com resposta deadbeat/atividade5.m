%%Projetar um sistema controlado com ganho: G = [-0,654 0,486] ; xe(0) != x(0)
%A saída de pt.4 tem que convergir para referência. (Realimentação com ganho)
%Projetar um Observador de estados, implementar as equacões do sistema controlado.
%Entra no observador, calcula a variável estimada, entra no ganho, joga no sistema calculado fica neste ciclo até que a saída pareca com a referência.
%Como implementar as equações do sistema controlado da pt.4
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
