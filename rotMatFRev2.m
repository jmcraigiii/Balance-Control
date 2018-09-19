function rotMat = rotMatFRev2(dir,angle)
% Angle must be in degrees

if strcmp(dir,'x')
    rotMat = [1 0 0;0 cos(angle) -sin(angle);0 sin(angle) cos(angle)];
elseif strcmp(dir,'y')
    rotMat = [cos(angle) 0 sin(angle);0 1 0;-sin(angle) 0 cos(angle)];
elseif strcmp(dir,'z')
    rotMat = [cos(angle) -sin(angle) 0;sin(angle) cos(angle) 0;0 0 1];
else
    disp('Invalid direction');
    rotMat = [0 0 0;0 0 0;0 0 0];
end