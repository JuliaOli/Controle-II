%%Projetar um sistema controlado com ganho: G = [-0,654 0,486] ; xe(0) != x(0)
%A sa�da de pt.4 tem que convergir para refer�ncia. (Realimenta��o com ganho)
%Projetar um Observador de estados, implementar as equac�es do sistema controlado.
%Entra no observador, calcula a vari�vel estimada, entra no ganho, joga no sistema calculado fica neste ciclo at� que a sa�da pareca com a refer�ncia.
%Como implementar as equa��es do sistema controlado da pt.4

close all
clc 

Ts = 0:0.1:1;
x0 = [1; 0];
xe0 = [0; 1];
y0 = [1; 1];
ye0 = [1; 1];

xe = [xe0 zeros(2,length(Ts)-1)];
x = [x0 zeros(2,length(Ts)-1)];
ye = [ye0 zeros(2,length(Ts)-1)];
y = [y0 zeros(2,length(Ts)-1)];

A = [0 1; -1 1];
B = [0; 1];
C = [2 0];
Ge = [0.5; 0];
G = [-0.654 0.486];
R = ones(1,length(Ts)-1);

for i = 1:1:length(Ts)-1
    xe(1:end, i+1) = (A-Ge*C)*xe(1:end,i)+Ge*C*x(1:end,i)+B*R(i);
    x(1:end, i+1) = A*x(1:end,i)+B*R(i)-G*B*xe(1:end,i);
    ye(i) = C*xe(1:end, i)
    y(i) = C*x(1:end, i)
end

figure(1)
subplot(2,1,1)
plot(xe(1:end), 'k')
hold on
plot(x(1:end))
subplot(2,1,2)
plot(ye(1:end), 'k')
hold on
plot(y(1:end))

