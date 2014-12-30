function lambda = armijo(x, p, g, theta, alpha, beta, par)
% Armijo's algorithm
m = g' * p;
lambda = beta;
phi = objective(x, par);
philambda = objective(x + lambda * p,par);
dif = phi + lambda * m * theta - philambda;
if ((norm(g) == 0) || (m >= 0))
    lambda = 0;
else
    
    
while(dif <= 0)
    lambda = alpha * lambda;
    philambda = objective(x + lambda * p, par);
    dif = phi + lambda * m * theta - philambda;
end
end
