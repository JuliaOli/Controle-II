clear all
clc

%The stability analysis using bilinear transformation,
%we first substitute z = (w+1)/(w-1) in the characteristics equation P(z) = 0 
%and simplify it to get the characteristic equation in w -plane as Q(w) = 0. 
%Once the characteristics equation is transformed as Q(w) = 0, 
%Routh stability criterion is directly used in the same manner as in a continuous time system. 

%P(z) = z³ + a2*z² + a1*z + a0 = 0
%z = (w+1)/(w-1);
%Q(w) = (1+a2+a1+a0)w³ + (3 + a2 - a1-3a0)w² + (3-a2-a1+3a0)w + (1-a2+a1-a0)

syms T K;

a0 = 1.395*10^(-4)*K*T^3 + 16.74*T - 111.6*T^2 - 1;
a1 = 3 - 33.48*T + 1.395*10^(-4)*K*T^3;
a2 = 111.6*T^2 + 16.74*T - 3;

w_3 = (1+a2+a1+a0);
w_2 = (3+a2-a1-3*a0);
w_1 = (3-a2-a1+3*a0);
w_0 = (1-a2+a1-a0);


%% Routh-Hurwitz
s1_matrix = [w_3,w_1; w_2,w_0];
s1 = det(s1_matrix)/s1_matrix(3

s0_matrix = [w_2,w_0;s1,0];
s0 = det(s0_matrix)/s1





