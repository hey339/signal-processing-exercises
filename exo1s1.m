

x = -pi:0.001:pi;      

u = sin(pi/4 * x);      
v = cos(pi/4 * x);       
plot(x, u, 'b', 'LineWidth', 1.5); hold on;
plot(x, v, 'r', 'LineWidth', 1.5);
xlabel('x');
ylabel('Amplitude');
legend('u(x) = sin(\pi/4 x)','v(x) = cos(\pi/4 x)');

grid on;
 