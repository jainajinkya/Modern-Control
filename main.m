clc
clear

global A B Q R t_f SMat
A = [0,1;0,0];
B = [0,1]';
Q = eye(2);
R = 1;
F= eye(2);
x0 = [1,2]';
t_f = 10;
dt = 0.001;
X = zeros(2,t_f/dt);

x0 = [1,0]';
X(:,1) = x0;
S0 = zeros(4,1);
tSpan = [t_f 0-dt];
steps = t_f/dt;

[~,S] = rk4fixed(@finiteLQR, tSpan, S0, steps+1);
S = flipud(S);

for i= 1:steps-1
   i
   SVec = S(i,:);
   SMat = (reshape(SVec,[2,2]))';
   tfiter = i + dt;
   tSpan = [i tfiter];
%    SMat = S(:,:,i+1);
%    SMat = [1.7321, 1; 1, 1.7321];
   [t_res, x_res] = ode15s(@dynamics, tSpan, x0);
   x0 = x_res(end,:);
   X(:,i+1) = x0;
end

% 
% plot(t_vec, X(1,:));
% hold on
% plot(t_vec, X(2,:), 'r');
% hold off
% 

%%
t_vec= linspace(0, t_f, t_f/dt);
fig = figure(1);
% set(fig,'Position',[1800 -320 1200 1000])
clear title
clear legend
plot(t_vec,X(1,:),'-k','LineWidth',1.5)
hold on
plot(t_vec,X(2,:),'-r','LineWidth',1.5)
title('Finite Time LQR')
xlabel('$Time\hspace{0.05in}(s)$','Interpreter','Latex','FontSize',12)
ylabel('$States\hspace{0.05in}(m)$','Interpreter','Latex','FontSize',12)
legend('X_1','X_2')
print('Q3_3_3','-djpeg','-r100')
