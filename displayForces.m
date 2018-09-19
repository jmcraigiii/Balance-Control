function displayForces
% Displays the forces

global F

% Display Forces
clc
disp('Leg Forces:')
disp(F)

% Get net force in each direction
xForce=0;yForce=0;zForce=0;
for i=1:4
xForce = xForce+F(1,i);
yForce = yForce+F(2,i);
zForce = zForce+F(3,i);
end

disp(['Net X: ',num2str(xForce)])
disp(['Net Y: ',num2str(yForce)])
disp(['Net Z: ',num2str(zForce)])