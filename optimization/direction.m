function p = direction(g, B, type)
% type = 1: hessian approximation
% tipo = 2: inverse hessian approximation
if (type == 1)
    p = -B*g;
else
    p = -(B\g);
end 