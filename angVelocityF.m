function oWb = angVelocityF(currentOrient)
% Given the current orientation of the body, this function calculates the
% angular velocity
%
% This formula was found on: https://ocw.mit.edu/courses/aeronautics-and-astronautics/16-07-dynamics-fall-2009/lecture-notes/MIT16_07F09_Lec29.pdf

% wx
oWb(1,1) = currentOrient(6)*sin(currentOrient(2))*sin(currentOrient(1))+currentOrient(5)*cos(currentOrient(1));
% wy
oWb(2,1) = currentOrient(6)*sin(currentOrient(2))*cos(currentOrient(1))-currentOrient(5)*sin(currentOrient(1));
% wz
oWb(3,1) = currentOrient(6)*cos(currentOrient(2))+currentOrient(4);
