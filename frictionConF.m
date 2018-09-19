function [c,ceq] = frictionConF(x)
% Nonlinear friction constraint for fmincon
global mu

for i=1:4
%c(1) = sqrt(x(1)^2+x(5)^2) - mu*x(9);
c(i) = sqrt(x(i)^2+x(i+4)^2) - mu*x(i+8);
end

ceq = [];

