%Phase margin (PM) is at least 45 degrees, crossover frequency around 10 rad/sec and the velocity error constant Kv is 30.
%% Exemplo 1
num = 1;
den = [0.2 0.3 1 0];
G = tf(num,den)
K = 30
%G = G*K
margin(G*K)
%Dados apresentados na questão não batem com os produzidos
%**Since the PM of the uncompensated system with K is negative. We need a lead compensator to compensate for the negative PM and achieve the desired phase margin.
%We design the lead part ?rst. From Figure 2, it is seen that at 10 rad/sec the phase angle of the system is ?198o. Since the new ?g should be 10 rad/sec, the required additional phase at ?g, to maintain the speci?ed PM, is 45?(180?198) = 63º. With safety margin 2º.***
phi_max = 63;
alpha = (1-sin(phi_max*pi/180))/(1+sin(phi_max*pi/180))
w_max = 10;
tau = 1/(w_max*(alpha)^(1/2))

num = [tau 1];
den = [tau*alpha 1];
C_lead = tf(num, den)
%A introdução desse compensador aumentará a frequência de crossover de ganho, onde a característica da fase será diferente da designada.
% Resposta de frequência do sistema no Exemplo 1 com apenas um compensador
% de avanço.%
%**Novamente é apresentado resultados diferentes
margin(K*C_lead)
%Em altas frequências, a magnitude da parte do compensador de atraso é 1 / ?.
20 log 10 ? 1 = 12 . 6 ?? 1 = 4 . 27
%%
syms alpha_1
alpha_high = 20*log10(alpha_1) == 12.6;
alpha_solve = solve(alpha_high)
alpha_solve = 4.2
tau = 1/0.25
num = [tau 1];
den = [tau*alpha_solve 1];
C_comp = tf(num, den)
margin(C_comp)
C_final = K*C_comp*C_lead
margin(C_final)
Exemplo 2
%% 
s= tf('s'); 
gc=1/(s*(1+0.1*s)*(1+0.2*s)); 
gz=c2d(gc,0.1,'zoh')
aug=[0.1,1]; 
gwss = bilin(ss(gz),-1,'S_Tust',aug);
gw=tf(gwss)
margin(30*gw)
phi_max = 66;
alpha_2 = (1-sin(phi_max*pi/180))/(1+sin(phi_max*pi/180))
w_max = 10;
tau = 1/(w_max*(alpha_2)^(1/2))
num = [tau 1];
den = [tau*alpha_2 1];
C_lead = tf(num, den)
margin(30*C_lead)
syms alpha_1
alpha_high = 20*log10(alpha_1) == 14.2;
alpha_solve = solve(alpha_high)
alpha_solve = 5.12;
tau = 1
num = [tau 1];
den = [tau*alpha_solve 1];
C_comp = tf(num, den)
margin(30*C_lead*C_comp)