function F=update(E,u,v,rango)
if (rango==0)
    F=E;
end
if (rango ==1)
    delta=v-E*u;
    esc=u'*delta;
    if (esc<=0)
        F=E;
    else
        mu=1/esc;
        R=mu*delta*delta';
        F=E+R;
    end
end
if (rango== 2)
    esc=u'*v;
    if (esc<=0)
        F=E;
    else
        n=length(u);I=eye(n);
        gamma=1/esc;
        S=gamma*v*v';
        P=gamma*u*v';
        F=(I-P')*E*(I-P)+S;
    end
end
