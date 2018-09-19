function comAngAcc = getCommandedAngAcc(currentOrient,desiredOrient,KpAng,KdAng)
% Based on the current and desired state of the body in zyx euler angles,
% this function returns the commanded linear velocity for the body as
% calculated by PD control
%
% Inputs are current orientation, desired orientation, and angular gains
% Output is the commanded angular velocity
%
% currentState = [psi,theta,phi,psidot,thetadot,phidot,psiddot,thetaddot,phiddot]
% desiredState = desired value of [psi,theta,phi,psidot,thetadot,phidot,psiddot,thetaddot,phiddot]
%
% Note: all angles, current and desired, are euler angles relative to earth
% frame

% psi (z axis)
comAngAcc(1,1) = KpAng*(desiredOrient(1)-currentOrient(1))+KdAng*(desiredOrient(4)-currentOrient(4))+desiredOrient(7);
% theta (y axis)
comAngAcc(2,1) = KpAng*(desiredOrient(2)-currentOrient(2))+KdAng*(desiredOrient(5)-currentOrient(5))+desiredOrient(8);
% phi (x axis)
comAngAcc(3,1) = KpAng*(desiredOrient(3)-currentOrient(3))+KdAng*(desiredOrient(6)-currentOrient(6))+desiredOrient(9);

