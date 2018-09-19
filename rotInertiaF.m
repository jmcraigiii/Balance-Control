function oIb = rotInertiaF(currentOrient,l,w,h,m)
% Given the euler angles relative to the earth fixed frame, this function
% calculates the Rotational Inertia matrix oIb
%
% The inputs are the roll, pitch, and yaw of the body, which are contained
% in the currentOrient vector as well as the dimensions and mass of the
% body
% The output is the rotational inertia matrix needed to use Euler's Law
%
% Assumes uniform density
%
% currentOrient must be in radians

% Find rotation matrix from earth frame to body frame using euler angles
oRb = rotMatFRev2('z',rad2deg(currentOrient(1)))*rotMatFRev2('y',rad2deg(currentOrient(2)))*rotMatFRev2('x',rad2deg(currentOrient(3)));
% Find rotation matrix from body frame to earth frame using inverse
bRo = inv(oRb);
% Calculations for bIb from page 181 in the Robotics textbook
Ixx = (m/3)*(l^2+h^2);
Iyy = (m/3)*(w^2+h^2);
Izz = (m/3)*(l^2+w^2);
Ixy = (m/4)*w*l;
Ixz = (m/4)*h*w;
Iyz = (m/4)*h*l;
bIb = [-Ixx -Ixy -Ixz;
    -Ixy Iyy -Iyz;
    -Ixz -Iyz Izz];
% Multiply the above matrices
oIb = oRb*bIb;
oIb = oIb*bRo; %#ok<MINV>
