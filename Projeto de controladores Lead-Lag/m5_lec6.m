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
%margem de fase do sistema sem compensao para o valor de K dado. PM = 18
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

Ts = 0.2;
num = [0.0187 0.0175];
den = [1 -1.8187 0.8187];
G_z = tf(num, den, Ts)

%The bi-linear transformation will transfer G z (z) into w-plane, as 
%We need first design a phase lead compensator so that PM of the compensated system is at
%least 50 0 with K v = 2 . The compensator in w-plane is

num = [-1/3000 - 29/300 1];
den = [1 1 0];
G_w = tf(num, den)
K = 2
margin(G_w*K)
%%
PM = 31.6;

%the additional phase lead required to maintain PM=45 at  ω g = 3.1 rad/sec is 
phi_max = 50 - PM
phi_max = phi_max + 11.6

alpha = (1-sin(phi_max*pi/180))/(1+sin(phi_max*pi/180))
%%
w_max = 1.75 %nem sei de onde veio

tetazinho = 1/(w_max*(alpha)^(1/2))

num = [tetazinho 1];
den = [tetazinho*alpha 1];

C = tf(num, den)
C = K*C
margin(C)


% num = [2.55 2.08];
% den = [1 -0.53];
% num = [0.99 1];
% den = [0.327 1];
% C_w = tf(num, den)
% margin(K*C_w)


