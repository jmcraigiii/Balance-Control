function comLinAcc = getCommanedLinAcc(currentPos,desiredPos,KpLin,KdLin)
% Based on the current and desired position of the body in xyz earth fixed 
% coordinates, this function returns the commanded linear acceleration for 
% the body as calculated by PD control
%
% Inputs are current position, desired position, and the linear gains
% Output is the commanded linear acceleration
%
% currentPos = [x,y,z,xdot,ydot,zdot,xddot,yddot,zddot]
% desiredPos = desired value of [x,y,z,xdot,ydot,zdot,xddot,yddot,zddot]
%
% Note: all positions, current and desired, are give with respect to the
% earth fixed frame

% x
comLinAcc(1,1) = KpLin*(desiredPos(1)-currentPos(1))+KdLin*(desiredPos(4)-currentPos(4))+desiredPos(7);
% y
comLinAcc(2,1) = KpLin*(desiredPos(2)-currentPos(2))+KdLin*(desiredPos(5)-currentPos(5))+desiredPos(8);
% z
comLinAcc(3,1) = KpLin*(desiredPos(3)-currentPos(3))+KdLin*(desiredPos(6)-currentPos(6))+desiredPos(9);
