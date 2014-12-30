function lambda = armijo(x, p, g, theta, alpha, beta, par)
% Armijo's algorithm
% 
% beta: intial value of lambda
% alpha: reduction of lambda in each step -> lambda = lambda * alpha
m = g' * p;
if ((norm(g) == 0) || (m >= 0))
    lambda = 0;
else
    
% Unitial value lambda
lambda = beta;

% Initial objective function value
phi = objective(x, par);
% Shifted objective function value
philambda = objective(x + lambda * p,par);
% Difference
dif = phi + lambda * m * theta - philambda;
while(dif <= 0)
    lambda = alpha * lambda;
    philambda = objective(x + lambda * p, par);
    dif = phi + lambda * m * theta - philambda;
end
end
