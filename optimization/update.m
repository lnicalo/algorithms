function F  =  update(E, u, v, rank)
switch rank
    case 0 
        F = E;
    case 1
        % Davidon–Fletcher–Powell formula
        delta = v-E*u;
        esc = u'*delta;
        if (esc <= 0)
            F = E;
        else
            mu = 1 / esc;
            R = mu*(delta*delta');
            F = E + R;
        end
    case 2
        esc = u'*v;
        if (esc <= 0)
            F = E;
        else
            % Sherman-Morrison formula (wikipedia)
            n = length(u);I = eye(n);
            gamma = 1 / esc;
            S = gamma*(v*v');
            P = gamma*u*v';
            F = (I-P')*E*(I-P) + S;
        end
end
