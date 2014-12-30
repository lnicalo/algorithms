function p=direccion(x,g,B,rango,tipo)
%tipo =1 cuando en casi newwton aproximo el hessiano
%tipo =2 cuaando en casi newton aproximo el inverso del hessiano
if (tipo == 1)
    p=-B*g;
else
    p=-(B\g);
end