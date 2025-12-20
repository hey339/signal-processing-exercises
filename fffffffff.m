clc; clear; close all;

N = 1024;                  % nombre de points par période
T = 2*pi;                  % période

t = linspace(-pi, pi, N);  % vecteur temps pour une période
f = zeros(size(t));         % initialiser f

f(t >= 0) = t(t >= 0);      % pour 0 <= t < pi, f(t)=t
% pour t<0, f reste 0

t_periods = linspace(-3*pi, 3*pi, 3*N);   % temps pour 3 périodes
f_periodic = repmat(f, 1, 3);             % répéter 3 fois

figure;
plot(t_periods, f_periodic, 'LineWidth', 1.5);
title('Signal périodique : f(t) = 0 pour t<0, f(t)=t pour t>=0');
xlabel('t');
ylabel('f(t)');
grid on;
