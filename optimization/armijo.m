function lambda=armijo(x,p,g,theta,alpha,beta,par)
%g=gradiente(x,par);
%p=direccion(x,g,par);
m=g'*p;
lambda=beta;
phi=objetivo(x,par);
philambda=objetivo(x+lambda*p,par);
dif=phi+lambda*m*theta-philambda;
if ((norm(g)==0) || (m>=0))
    lambda=0;
else
while(dif<=0)
    lambda=alpha*lambda;
    philambda=objetivo(x+lambda*p,par);
    dif=phi+lambda*m*theta-philambda;
end
end
