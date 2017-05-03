function xdot = dynamics(t, x)
global A B R SMat
K = inv(R)*B'*SMat;
u = -K*x;

xdot = A*x + B*u;
end
