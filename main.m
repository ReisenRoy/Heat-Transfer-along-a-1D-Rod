clear; clc; clf;

n = input('index of summation: ');
L = input('length of the rod: ');
a = input('the conductivity parameter: ');
t_step = input('time step: ');
x_step = input('x step/step on the rod: ');
t = 0:t_step:2;
x = 0:x_step:L;

u = zeros(length(t),length(x));
% initial and boundary conditions
u(1,:) = 23*sin(3*pi*x);
u(:,1) = 0;
u(:,L+1) = 0;

fun = @(x) 23*sin(3*pi*x).*sin(n*pi.*x./L);
An = 2./L.*integral(fun,0,5);


figure(1)
for i=1:length(t)
    for k=1:1:length(x)
        u(i,k) = sum( An.*exp(-(pi.*n./L).^2.*a.*t(i)) .* sin(pi.*n.*x(k)./L) );
    end
    plot(x,u(i,:),'DisplayName',strcat('t=',num2str(t(i))) );
    hold on;
end
legend('show');
grid on;
xlabel('x');
ylabel('u(x,t)');

figure(2)
X1=kron(ones(length(t),1),x);
T1=kron(ones(1,length(x)),t');
surf(X1,T1,u);
xlabel('x');
ylabel('t');
zlabel('u(x,t)');