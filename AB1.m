clc
clear

num = 1;
den = [1 0 0];

G = tf(num,den);

[A,B,C,D] = tf2ss(num,den)

%% Verifique se o sistema é controlável e observável

%O posto de C M é igual ao número de linhas ou colunas linearmente independentes. O posto pode ser obtido determinando-se a
%submatriz quadrada de maior ordem que é não singular. O determinante de C M é – 1. Como o determinante é diferente de
%zero, a matriz 3 × 3 é não singular e o posto de C M é 3. Concluímos que o sistema é controlável, uma vez que o posto de C M é
%igual à ordem do sistema (Significa que eu posso controlar o sistema).

n = 2; % Ordem do sistema
C_m = [B A*B]

%rank vai dizer quantas linhas são linearmente independente
p = rank(C_m) %posto tem que ser igual a ordem do sistema para ser controlável.

%vamo garantir
det_C = det(C_m)

%como o determinante é diferente de 0 e o posto é igual a ordem do sistema
%o mesmo é controlável

%Matriz de observabilidade
O_m = [C; C*A]
%Se o posto for igual a ordem do sistema, o mesmo é observável
p_o = rank(O_m)

%Então como o posto é igual a matriz, o mesmo é observável e controlável

%% Posicione os polos do sistema controlado em s = −0, 707 ± j0, 707 e avalie a resposta do sistema para uma entrada do tipo degrau unitário


polos = [-0.707+i*0.707 -0.707-i*0.707]; %declarando os polos 


k = acker(A,B,polos) %Posicionamento de polos

A_c = A-B*k; % A controlado
B_c = B;
C_c = C;
D_c = 0;

%espaco de estados para FT para calcular o degrau

sis = ss(A_c, B_c, C_c, D_c);

step(sis); % Resposta para uma 

%% Projete um observador com as seguintes especificações de desempenho: ωn = 5 
%rad/s e ζ = 0, 5. Utilizando o Simulink, avalie o desempenho do observador
%comparando as variáveis de estado do sistema com as variáveis estimadas (1,5
%pts).

w_n = 5;
zeta = 0.5;

% equacao de um sistema de segunda ordem 
num_o = [w_n^2];
den_o = [1 2*w_n*zeta w_n^2];
O = tf(num_o, den_o);

%Encontrando os polos eu posso achar o l
poles_o = pole(O);

%Pra achar o l tem que ter o espaco de estados
[A_o, B_o, C_o, D_o] = tf2ss(num_o, den_o)

%Usa o espaço de estado da funcao de transferencia 
L = acker(A, B,poles_o)

%% Considere o sistema de velocidade do motor descrito 

num = [1];
den = [1 3];

Q = tf(num,den);

[A,B,C,D] = tf2ss(num,den)
%Projete um controlador por posicionamento de polos (realimentação de estados)
%que possua erro em regime permanente de 80% para uma entrada do tipo degrau
%unitário, i.e., y(t) = 0, 2 no estado estacionário. Mostre a curva da saída. (2,0
%pts).


%% Projete o sistema para ter controle integral e dois polos em s = −5. Mostre o
%desempenho do sistema comprovando que o mesmo apresenta erro nulo em regime
%permanente (2,0 pts).

%dados os 2 polos s = -5 temos:
w_n = 5;
zeta = 1;

num = [1];
den = [1 3]

Q = tf(num, den)

[A,B,C,D] = tf2ss(num,den)




