function g = gradient(x,par)
% Rosenbrok's function - gradient
g = [2*par(1)*(x(2) - x(1)^2)*(-2)*x(1)-2*(par(2)-x(1));
    2*par(1)*(x(2)-x(1)^2)];
end
