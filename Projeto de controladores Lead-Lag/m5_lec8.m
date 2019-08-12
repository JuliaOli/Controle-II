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

num = 1;
den = [1 1 0];
G = tf(num,den);
H = 1;
% phase margin (PM) is at least 45 degrees
% error for a unit ramp input is ≤ 0.1.
% s → 0, C(s) → K
% Steady state error for unit ramp input is 1/K
% 1/K = 0.1
K = 10

syms w_g
equ = 1 -100/(w_g^2 *(1+w_g^2)) == 0
equ_sol = solve(equ, w_g)
W_G = equ_sol(2) %deu certo aqui

phase = -90 - atan(W_G)*180/pi

