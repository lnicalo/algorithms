% Using LSODE to solve the ODE system.
clear all
close all
t = linspace(0,25,1e3); X0 = [0,1,1.05];
[X,T,MSG]=lsode(@lorenzatt,X0,t);
T
MSG
plot3(X(:,1),X(:,2),X(:,3))
view(45,45)