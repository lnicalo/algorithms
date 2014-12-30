% Quasi-newton method
% 
% Type 1: We
% Type 2: 


% rank:
% If rank = 1: Davidon-Fletcher-Powell (DFP)
% If rank = 2: Broyden, Fletcher, Goldfarb, Shanno(BFGS)
% If rank = 0: No correction.
rank = 2;

%%
% type = 1: inverse hessian approximation
% tipo = 2: hessian approximation. It is required to solve a linear system
% in each steo
type = 1;

%% Stop parameters
% Precision
tol = eps;
% Max. Iterations
nitermax = 10^5;

%% Armijo algorithm parameters
theta = 0.8; alpha = 0.9; beta = 1 / alpha;

%% Function parameters
% f(x,y)=a(y - x^2)^2 + (b - x)^2,
a = 100; b = 1; 
par = [a, b];

%% First iteration
niter = 1;
x0 = [-1.8; 2]; % Initial point
A = eye(length(x0)); % Initial update matrix
x_old = x0;
g_old = gradient(x_old,par);
p = direction(g_old,A,type);
lambda = armijo(x_old,p,g_old,theta,alpha,beta,par);
x_new = x_old + lambda*p;
delta_x = x_new - x_old;
g_new = gradient(x_new, par);
delta_g = g_new - g_old; 
 
while ((norm(delta_x)>tol) && (norm(g_new) > tol) && (niter <= nitermax))
    x_old = x_new;
    g_old = g_new;
    
    % Update inverse hessian approximate or hessian approximate
    if (type == 1)
        A = update(A, delta_g, delta_x, rank);    
    else
        A = update(A, delta_x, delta_g, rank);
    end
    
    % Direction
    p = direction(g_old, A, type);
    
    % Armijo algorithm
    lambda = armijo(x_old, p, g_old, theta, alpha, beta, par);    
    x_new = x_old + lambda * p;
    delta_x = x_new - x_old;
    
    % Gradient
    g_new = gradient(x_new, par);
    delta_g = g_new - g_old;
    
    niter = niter + 1;
end