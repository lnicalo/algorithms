%tipo =1 cuando en casi newton aproximo el inverso del hessiano
%es el formato de las matrices A´s y no hay necesidad de resolver
%ningún sistema lineal en cada etapa
%tipo =2 cuando en casi newton aproxima el hessiano; es le formato de las
%matrices B´s y hay que resolver un sistema lineal en cada etapa
 
%rango=rango de la corrección (1 ó 2); rango=0 significa no corrección
tipo =2;
rango=1;
tol=eps;%criterio de parada, precisión a la que aspiramos
nitermax=10000000;%no. máximo de etapas en en el proceso
niter=1;
theta=0.8;alpha=0.9;beta=1/alpha;
a=100;b=1; %estamos pensando en f(x,y)=a(y - x^2)^2 + (b - x)^2,
par=[a,b];
x0=[-1.8;2];

%en el programa las matrices se denotan siempre por A, pero se trataría
%de las matrices B cuando estemos en tipo =2;
A=eye(length(x0));%necesitamos una matriz de arranque definida positiva 
xold=x0;
gold=gradiente(xold,par);
p=direccion(xold,gold,A,rango,tipo);
lambda=armijo(xold,p,gold,theta,alpha,beta,par);
xnew=xold+lambda*p;
deltax=xnew-xold;
gnew=gradiente(xnew,par);
deltag=gnew-gold; 
 
while ((norm(deltax)>tol) && (norm(gnew) > tol) && (niter <= nitermax))
    xold=xnew;
    gold=gnew;
    if (tipo ==1)
        A=update(A,deltag,deltax,rango);    
    else
        A=update(A,deltax,deltag,rango);
    end
    p=direccion(xold,gold,A,rango,tipo);
    lambda=armijo(xold,p,gold,theta,alpha,beta,par);
    xnew=xold+lambda*p;
    deltax=xnew-xold;
    gnew=gradiente(xnew,par);
    deltag=gnew-gold;
    niter=1+niter;
end