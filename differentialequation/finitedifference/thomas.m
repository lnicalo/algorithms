function x=thomas(a,b,c,y)
%resuelve sistema tridiagonal con segundo miembro y
x=zeros(size(y));K=length(x);
for k=1:K-1
    factor=a(k)/b(k);
    b(k+1)=b(k+1)-c(k)*factor;
    y(k+1)=y(k+1)-y(k)*factor;
end
x(K)=y(K)/b(K);
for k=K-1:-1:1
    x(k)=(y(k)-c(k)*x(k+1))/b(k);
end
