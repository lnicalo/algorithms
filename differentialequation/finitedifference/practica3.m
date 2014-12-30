%% Diferencias finitas centradas de segundo orden en espacio y Euler implicito

%este programa aproxima u_t = Du_{xx}+f junto con condiciones de contorno
%[a,b] de tipo Dirichlet y dato inicial dado
D=0.1;         % Coeficiente de difusion
a=0; b=1;       % Limites del intervalo en el espacio
L=b-a;          % Longitud en el intervalo

J = 1000;         % Numero de nosods en el espacio
dx=L/J;         % Espaciado nodos en espacio. Delta de x
x=(0:dx:L)';    % Nodos discretos en el espacio

t0=0;tf=1;    % Tiempos inicial y final
T=tf-t0;        % Duracion del tiempo de analisis
N = 100;       % Numero de puntos en el tiempo
dt=T/N;         % Espaciado de los nodos en el tiempo


mu=dt/dx^2;
muD=mu*D;

t=(t0:dt:T)';   % Nodos discretos en el tiempo

% Condicion inicial
u0=sin(3*pi*x);
% u0=1*(abs(x - 1/2) < 1/4) + 0*(abs(x - 1/2) >= 1/4);
% u0=0*x+1;

% Condiciones de contorno
ga=zeros(N+1,1);
gb=zeros(N+1,1); 


%f=-t+x.^2;%expresion de f
U=zeros(J+1,N+1);%matriz que guarda en columnas las soluciones para cada
%tiempo discreto
U(:,1)=u0;
uold=u0;
unew=uold;

for n=2:N+1
    %unew es la aproximacion en t_n y uold lo es en t_{n-1}
    unew(1)=ga(n);
    unew(J+1)=gb(n);
    F=zeros(J-1,1);%termino complementario en t_n sobre los nodos
    %intermedios
    FF=uold(2:J)+dt*F;
    FF(1)=F(1)+muD*ga(n);
    FF(J-1)=F(J-1)+muD*gb(n);
    uu=thomas(-muD*ones(J-2,1),1+2*muD*ones(J-1,1),-muD*ones(J-2,1),FF);
    unew(2:J)=uu;
    U(:,n)=unew;
    uold=unew;
end
figure(1)
[XX,tt]=meshgrid(x,t);
mesh(XX,tt,U')
title('Dif. finita orden 2 + Euler implicito')

%% Diferencias finitas por la regla del punto medio y euler implicito
%este programa aproxima u_t = Du_{xx}+f junto con condiciones de contorno
%[a,b] de tipo Dirichlet y dato inicial dado

ga = zeros(N+2,1);
gb = zeros(N+2,1);

%f=-t+x.^2;%expresion de f
U2=zeros(J+1,N+1);%matriz que guarda en columnas las soluciones para cada
%tiempo discreto
U2(:,1)=u0;
uold=u0;
unew=uold;

for n=2:N+1
    %unew es la aproximacion en t_n y uold lo es en t_{n-1}
    unew(1)=ga(n);
    unew(J+1)=gb(n);
    
    FF=zeros(J-1,1);%termino complementario en t_n sobre los nodos intermedios
    
    % Funcion G. Ver aclaracion de el documento adjunto
    G=2*uold(2:J) + dt*FF;
    G(1)=2*uold(1) + dt*FF(1) + 1/2*muD*(ga(n)+ga(n+1));
    G(J-1)=2*uold(J+1) + dt*FF(J-1) + 1/2*muD*(gb(n)+gb(n+1));
       
    th=thomas(-1/2*muD*ones(J-2,1),1+muD*ones(J-1,1),-1/2*muD*ones(J-2,1),G);
    unew(2:J)=-uold(2:J) + th;
    U2(:,n)=unew;
    uold=unew;
end
figure(2)
[XX,tt]=meshgrid(x,t);
mesh(XX,tt,U2')
title('Regla del pto medio + Euler implicito')



%% Comparacion de ambos metodos
figure(3)
plot(x,U(:,15),x,U2(:,15));
title('Temperatura')
legend('Euler Implícito','Punto Medio')
xlabel('x');
ylabel('Temp.');
