close all
%este programa implementa un método RK explícito con paso constante
%c=[0,1];b=[1/2,1/2];%es preciso cargar las matrices c, b, 
%A del correspondiente tablero de Butcher del método
A=[0 0; 1 0];
c=[0,1/2,1/2,1];
b=[1/6,1/3,1/3,1/6];
A=[0 0 0 0;0.5 0 0 0;0 0.5 0 0;0 0 1 0];
% A = [0 0 0 0 0 0 0
%     1/5 0 0 0 0 0 0
%     3/40 9/40 0 0 0 0 0
%     44/45 -56/15 32/9 0 0 0 0
%     19372/6561 -25360/2187 64448/6561 -212/729 0 0 0
%     9017/3168 -355/33 46732/5247 49/176 -5103/18656 0 0
%     35/384 0 500/1113 125/192 2187/6784 11/84 0
%     ];
% b = [5179/57600 0 7571/16695 393/640 -92097/339200 187/2100 1/40];
% c = [0 1/5 3/10 4/5 8/9 1 1];
m=length(c); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t0=0; %instante inicial
T=30; %el tiempo final hasta el que integramos es tf=t0+T.
deltat=1/1000;
N = T/deltat;
t=t0+deltat*(0:N); %este vector guarda los tiempos %discretos y es útil a efectos de representación gráfica.
u0 = [5;-30;5]; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

U=zeros(size(u0,1),N+1); %la matriz U es m x N y guarda en sus columnas %las %aproximaciones obtenidas; esta matriz es útil %únicamente %para efectos de representación gráfica
F = zeros(size(u0,1),m);
u=u0; %condición inicial
U(:,1) = u;
for n=1:N
    tn=t(n);
    F(:,1)=funcionec(tn+deltat*c(1),u);
    for j=2:m
        KK=F(:,1:j-1)*diag(A(j,1:j-1));
        KE=sum(KK,2);
        F(:,j)=funcionec(tn+deltat*c(j),u+deltat*KE);
    end
    u=u+deltat*sum(F*diag(b),2);
    U(:,n+1) = u;
end

u02 = u0 + 1.001; 

U2=zeros(size(u02,1),N+1); %la matriz U es m x N y guarda en sus columnas %las %aproximaciones obtenidas; esta matriz es útil %únicamente %para efectos de representación gráfica
F = zeros(size(u02,1),m);
u=u02; %condición inicial
U2(:,1) = u;
for n=1:N
    tn=t(n);
    F(:,1)=funcionec(tn+deltat*c(1),u);
    for j=2:m
        KK=F(:,1:j-1)*diag(A(j,1:j-1));
        KE=sum(KK,2);
        F(:,j)=funcionec(tn+deltat*c(j),u+deltat*KE);
    end
    u=u+deltat*sum(F*diag(b),2);
    U2(:,n+1) = u;
end

%% Segunda opcion
%% Resolvemos con la funcion de matlab ode45 para comparar
[t,Y] = ode45(@funcionec,t',u0);
[t,Y2] = ode45(@funcionec,t',u02);
%% Representacion de la solucion
%% Componentes por separado en una sola gráfica
close all
figure(1)
subplot(3,1,1);
plot(t,U(:,1),'b')
hold on
plot(t,U2(:,1),'g')
title('Componente X')
legend('U0 = [5 -30 5]', 'U0 = [5.001 -30.001 5.001]');

subplot(3,1,2);
plot(t,U(:,2),'b')
hold on
plot(t,U2(:,2),'g')
title('Componente Y')
legend('U0 = [5 -30 5]', 'U0 = [5.001 -30.001 5.001]');

subplot(3,1,3)
plot(t,U(:,3),'b')
hold on
plot(t,U2(:,3),'g')
title('Componente Z')
legend('U0 = [5 -30 5]', 'U0 = [5.001 -30.001 5.001]');

%% Comparacion con la funcion de matlab ode45 para comparar
for j=1:size(U,1)
    figure(j+1)
    subplot(2,1,1);
    plot(t,U(:,j),'b')
    hold on
    plot(t,U2(:,j),'g')
    title('Calculo con el algoritmo implementado')
    subplot(2,1,2);
    plot(t,Y(j,:)','b')
    hold on
    plot(t,Y2(j,:)','g')
    title('Calculo con el algoritmo de MATLAB ode45')
end

figure(5)
plot3(U(1,:),U(2,:),U(3,:),'b')
title('Trayectoria 3D - u0 = [5;-30;5]')

figure(6)
plot3(U2(1,:),U2(2,:),U2(3,:),'g')
title('Trayectoria 3D - u0 = [5.001;-30.001;5.001]')
