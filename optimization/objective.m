function y = objective(x,par)
% Rosenbrok's function
y = par(1)*(x(2) - x(1)^2)^2 + (par(2) - x(1))^2;
end
