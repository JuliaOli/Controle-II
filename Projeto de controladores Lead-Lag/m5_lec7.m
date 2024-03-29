clear all
clc

%A typical lead compensator has the following transfer function.
% C(s) = K*((τs + 1)/(ατ s + 1), where, α < 1
% 1/α is the ratio between the pole zero break point (corner) frequencies. 

%Magnitude of the lead compensator is K (√(1 + α^2*ω^2*τ^2))/(√(1 +
%α^2*ω^2*τ^2)) And the phase contributed by the lead compensator is given by
% φ = atan(ωτ) − atan(αωτ)

%It can be shown that the frequency where the phase is maximum is given by
% ω max = 1/τ√α

%The maximum phase corresponds to sinφmax = (1-α)/(1+ α)
% ⇒ α = (1 − sin(φ max ))/ (1 + sin(φ max ))
% The magnitude of C(s) at ωmax is K/√α

%% Exemplo 1
%Design a lag compensator so that the phase margin (PM) is at least 50o and steady state error to a unit step input is ? 0.1.

num = 1;
den = [0.5 1.5 1];
G = tf(num,den);
H = 1;

%Steady state error for unit step input is 1/(1 + lims?0 C(s)G(s)) = 
%1/( 1+ C(0)) = 1/( 1 + K?)
%Thus, 1/( 1 + K?) = 0.1, or, K = 9.

K_alpha = 9
%%
syms w_g

Mag = 0.715*w_g^2 - 1.5*w_g - 1.43 == 0
Mag_sol = solve(Mag, w_g)
W_G = Mag_sol(2) %deu certo aqui
W_G = 2.8

%Novo K
K = 5.1;
alpha = 9/K
tau = 10/W_G

% Lead Compensator

num = [tau 1];
den = [tau*alpha 1];

C = tf(num, den)

margin(C*9)

%% Exemplo 2

s=tf('s');
gc=1/(s*(1+0.1*s)*(1+0.2*s));
gz=c2d(gc,0.1,'zoh')
aug=[0.1 1];
gwss = bilin(ss(gz),-1,'S_Tust',aug);
gw=tf(gwss)

%Since Gw(0) = 1, K? = 9 for 0.1 steady state error.
aug=[0.1 1];

gwss = bilin(ss(gz),-1,'S_Tust',aug);
gw=tf(gwss)

%Since Gw(0) = 1, K? = 9 for 0.1 steady state error.
margin(gw)



