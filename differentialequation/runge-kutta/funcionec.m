function y=funcionec(t,x)
    sigma = 10; 
    rho = 28;
    beta = 8/3;
%     y(1) = sigma*(x(2) - x(1));
%     y(2) = x(1)*(rho - x(3)) - x(2);
%     y(3) = x(1)*x(2)-beta*x(3);
%     y=[y(1);y(2);y(3)];
    y=[ sigma*(x(2)-x(1));
    x(1)*(rho-x(3))-x(2);
    x(1)*x(2)-beta*x(3)];
end