function [f, E, A] = update(model, m, u)
% initializations 
T = model.T;
L = model.L;

% non linear functions
f = [m(1) + T*u(1)*cos(m(3));...
     m(2) + T*u(1)*sin(m(3));...
     m(3) + (T/L)*(u(1)*tan(u(2)))];
 
% Jacobian of f respect to mu  
A = [1 0 -T*u(1)*sin(m(3));...
     0 1 T*u(1)*cos(m(3));...
     0 0 1];
 
% Jacobian of f respect to noise
E = [T*cos(m(3)) 0;...
     T*sin(m(3)) 0;...
     (T/L)*tan(u(2)) (T/L)*u(1)*(sec(u(2))^2)]; 
end

