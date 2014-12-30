function g=gradiente(x,par)
g =[2*par(1)*(x(2)-x(1)^2)*(-2)*x(1)-2*(par(2)-x(1));2*par(1)*(x(2)-x(1)^2)];
% f = par(1)*(x(2) - x(1)^2)^2 + (par(1) - x(1))^2;
% % g1 = f + 1;
% % g2 = log(g1 + 1);
% % g3 = log(g2 + 1);
% % g = 1/g3*1/g2*1/g1*df;
% g1 = f + 1;
% g2 = log(g1 + 1);
% g = (1/g1)*(1/g2)*df;
% g = [2*par(1)*x(1);2*x(2)];
end
