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
%margem de fase do sistema sem compensação para o valor de K dado. PM é 18
margin(G*K)
% Defining The maximum phase corresponds to sin(φmax)

PM = 18;

%the additional phase lead required to maintain PM=45 at  ω g = 3.1 rad/sec is 
phi_max = 45 - PM;
phi_max = phi_max + 10

alpha = (1-sin(phi_max*180/pi))/(1+sin(phi_max*180/pi))

% finding τ

w_max = 4.41 %nem sei de onde veio

tetazinho = 1/(w_max*(alpha)^(1/2))

% Lead Compensator

num = [tetazinho 1];
den = [tetazinho*alpha 1];

C = tf(num, den)
C = K*C
%% Example 2

num = [1];
den = [1 1 1 0];
G_s = tf(num, den)
margin(G_s)

% num_z = [1 1];
% den_z = [1];
% Z = filt(num_z, den_z)
% 
% G_aux = c2d(G_s, 0.2)*Z
Ts = 0.2;
num = [0.0187 0.0175];
den = [1 -1.8187 0.8187];
G_z = tf(num, den, Ts)


%margin(G_z)












