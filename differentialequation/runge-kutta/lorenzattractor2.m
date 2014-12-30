%% Main program: Save the program in a separate .m file and run it.
clear all; % clear all variables
t=linspace(0,100,10000)'; % time variables
y0=[0;2;0]; % Initial conditions
[t,Y] = ode45(@myLorenz,t,y0); %Invoking built-in solver 'ode45'

%% Representacion
figure(1)
plot3(Y(:,1),Y(:,2),Y(:,3));  % Plot results
grid on;

figure(2)
hold on
for j=1:size(Y,2)
    subplot(size(Y,2),1,j);
    plot(t,Y(:,j),'b')
end