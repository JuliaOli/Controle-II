%%Projetar um sistema controlado com ganho: G = [-0,654 0,486] ; xe(0) != x(0)
%A sa�da de pt.4 tem que convergir para refer�ncia. (Realimenta��o com ganho)
%Projetar um Observador de estados, implementar as equac�es do sistema controlado.
%Entra no observador, calcula a vari�vel estimada, entra no ganho, joga no sistema calculado fica neste ciclo at� que a sa�da pareca com a refer�ncia.
%Como implementar as equa��es do sistema controlado da pt.4

close all
clc 

x0 = [1; 0];
xe0 = [0; 1];

xe = [xe0 zeros(2,14)];
x = [x0 zeros(2,14)];

A = [0 1; -1 1];
B = [0; 1];
C = [2 0];

Ge = [-0.654 0.486];

for i = 1:14
    xe(1:2, i+1) = (A-Ge*C)*xe(1:2,i)+Ge*C*x(1:2,i)
    x(1:2, i+1) = A*x(1:2,i)
end


% 
% a2 = 1;
% a1 = -1;
% 
% P = [a1, 1; 1, 0] * [C; C*A];
% 
% A2 = P*A*(P^-1);
% B2 = P * B;
% C2 = C*P^-1;
% Q = eye(2);
% 
% Q*P)^(-1);
% 
% syms x_1 we
% 
% vpa([-0.654, 0.486]*[x_1; 0.5*we + x_1], 4)
