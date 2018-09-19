% General Notes:


% Includes all aspects, but it not working

% Might want to group the plots by component: for example, all x plots
% together or all theta plots together

% Basic outline
    % 1) Receives input parameters
    % 2) Receives starting and desired position
    % 3) Computes commanded acceleration using PD feedback control
    % 4) Uses fmincon to determine forces tha result in those accelerations
    % 5) Integrates forward in time to find new position and orientation
    % 6) Repeats 3-5
    % 7) Position and orientation are tracked throughout. Plots include a
    % live animation of the body moving, plots of the actual versus desired
    % x,y,z locations and euler angles, plots of the leg forces over time

% Suspected Issues
    % 1) Gain values. The system seems to be going unstable. Could be due 
    % to bad gain values
    % 2) Angular calculations. I was confused about these throughout. It
    % could be that these associated forces are disrupting everything
    
    
% Question: why does the y location decrease when the force is always
% positive???
% Why does the x position increase when the net force is usually negative

clear; clc; close all
global mb comLinAcc g oIb comAngAcc oWb mu footPos currentPos F
%% input parameters

% Misc
g = [0;0;9.81]; % gravity
mu = 0.3; % friction coefficient

% Body characteristics
l = 1.5; % meters
w = 0.5; % meters
h = 0.5; % meters
mb = 25; % kg

% Foot Positions
footPos{1} = [-w/2;l/2;-h/2]; % front left
footPos{2} = [w/2;l/2;-h/2]; % front right
footPos{3} = [-w/2;-l/2;-h/2]; % back left
footPos{4} = [w/2;-l/2;-h/2]; % back right

% Gains
KpLin = 20; % Proportional gain for linear acceleration
KdLin = 10; % Derivative gain for linear acceleration
KpAng = 20; % Proportional gain for angular acceleration
KdAng = 10; % Derivative gain for angular acceleration

% Options
dispForces=1;

% Counters
forceCount=1;

%% State of Body

% Starting Position
% [x,y,z,xdot,ydot,zdot,xddot,yddot,zddot];
currentPos = [0,0,0,0,0,0]; % current
desiredPos = [0,0,0,0,0,0,0,0,0]; % desired, currently the same throughout

% Starting Orientation
% [psi,theta,phi,psidot,thetadot,phidot,psiddot,thetaddot,phiddot];
currentOrient = [0,0,0,0,0,0]; % current
desiredOrient = [0,0,0.2,0,0,0,0,0,0]; % desired

% Keep track of x,y,z, throughout the motion. This gets initial position
for k=1:3
posArray{k}(1) = currentPos(k); %#ok<SAGROW>
desArray{k}(1) = desiredPos(k); %#ok<SAGROW>
orientArray{k}(1) = currentOrient(k); % arrays for x,y,z after each loop
desOrientArray{k}(1) = desiredOrient(k); % array for desired position
end

%% Forever Loop
for i = 1:100
%% Compute commanded accelerations
% Linear acceleration
comLinAcc = getCommanedLinAcc(currentPos,desiredPos,KpLin,KdLin);
% Angular acceleration
comAngAcc = getCommandedAngAcc(currentOrient,desiredOrient,KpAng,KdAng);

%% Compute inertias and angular velocity
% Inertia
oIb = rotInertiaF(currentOrient,l,w,h,mb);
% Angular Velocity
oWb = angVelocityF(currentOrient);

%% Compute Forces using Fmincon
xF = getForces;

%% Translate into Leg Forces (for visualization purposes)
for j=1:4
F(:,j) = [xF(j);xF(j+4);xF(j+8)];
end

% Display Forces (optional)
if dispForces==1
displayForces
end

% Track forces over time
for j=1:4
Fx{j}(forceCount) = F(1,j); %#ok<SAGROW>
Fy{j}(forceCount) = F(2,j); %#ok<SAGROW>
Fz{j}(forceCount) = F(3,j); %#ok<SAGROW>
end
forceCount=forceCount+1; % increase forceCounter

%% Step forward in time
t0 = 0;
tend = 0.01; % 10ms

% Initial conditions
IC = [currentPos(1),currentPos(2),currentPos(3),...
    currentOrient(1),currentOrient(2),currentOrient(3),...
    currentPos(4),currentPos(5),currentPos(6),...
    currentOrient(4),currentOrient(5),currentOrient(6)]; % [x,y,z,alpha,beta,gamma,xDot,yDot,zDot,alphaDot,betaDot,gammaDot]

% ODE45
[tODE,xODE] = ode45(@(t,x) myDeriv(t,x,F,mb,g,footPos,currentPos,oWb,oIb), [t0 tend],IC);

% Assign new position and orientation
[currentPos,currentOrient] = assignNewStateF(xODE);

% Keep track of positions,accels,orientation over time
for k=1:3
posArray{k}(1+i) = currentPos(k); % arrays for x,y,z after each loop
desArray{k}(1+i) = desiredPos(k); % array for desired position

orientArray{k}(1+i) = currentOrient(k); % arrays for x,y,z after each loop
desOrientArray{k}(1+i) = desiredOrient(k); % array for desired position

linAccArray{k}(i) = comLinAcc(k); % commanded linear acceleration
angAccArray{k}(i) = comAngAcc(k); % commande angular acceleration
end

%% Animate motion
% inputs for functions
pos = [currentPos(1) currentPos(2) currentPos(3) currentOrient(1) currentOrient(2) currentOrient(3)]; % current position
posD = [desiredPos(1) desiredPos(2) desiredPos(3) desiredOrient(1) desiredOrient(2) desiredOrient(3)]; % desired
    
% Plot Current
clf
genBox3Rev2(pos,l,w,h,'k')
genAxesRev2(pos)
axis([-1 1 -1 1 -1 1])

% Plot Desired
genBox3Rev2(posD,l,w,h,'b--')
drawnow

end

%% Plot Position
% x position: actual vs. desired
figure
plot(posArray{1},'ro')
hold on
plot(desArray{1},'b')
title('x position')
legend('Actual','Desired')
% y position: actual vs. desired
figure
plot(posArray{2},'ro')
hold on
plot(desArray{2},'b')
title('y position')
legend('Actual','Desired')
% z position: actual vs. desired
figure
plot(posArray{3},'ro')
hold on
plot(desArray{3},'b')
title('z position')
legend('Actual','Desired')

%% Plot Orientation
% Psi Angle: actual vs. desired
figure
plot(orientArray{1},'ro')
hold on
plot(desOrientArray{1},'b')
title('psi angle')
legend('Actual','Desired')
% Theta Angle: actual vs. desired
figure
plot(orientArray{2},'ro')
hold on
plot(desOrientArray{2},'b')
title('theta angle')
legend('Actual','Desired')
% Phi Angle: actual vs. desired
figure
plot(orientArray{3},'ro')
hold on
plot(desOrientArray{3},'b')
title('phi angle')
legend('Actual','Desired')

%% Plot Commanded Linear Accelerations
% x acceleration: commanded
figure
plot(linAccArray{1},'ro')
title('x acceleration')
% y acceleration: commanded
figure
plot(linAccArray{2},'ro')
title('y acceleration')
% z acceleration: commanded
figure
plot(linAccArray{3},'ro')
title('z acceleration')

%% Plot Commanded Angular Accelerations
% psi acceleration: commanded
figure
plot(angAccArray{1},'ro')
title('psi acceleration')
% theta acceleration: commanded
figure
plot(angAccArray{2},'ro')
title('theta acceleration')
% phi acceleration: commanded
figure
plot(angAccArray{3},'ro')
title('phi acceleration')

%% Plot Forces
% x forces
figure
plot(Fx{1},'r--')
hold on
plot(Fx{2},'b--')
plot(Fx{3},'g--')
plot(Fx{4},'m--')
plot(Fx{1}+Fx{2}+Fx{3}+Fx{4},'k')
title('x Forces')
legend('Foot1','Foot2','Foot3','Foot4','Net')
% y forces
figure
plot(Fy{1},'r--')
hold on
plot(Fy{2},'b--')
plot(Fy{3},'g--')
plot(Fy{4},'m--')
plot(Fy{1}+Fy{2}+Fy{3}+Fy{4},'k')
title('y Forces')
legend('Foot1','Foot2','Foot3','Foot4','Net')
% z forces
figure
plot(Fz{1},'r--')
hold on
plot(Fz{2},'b--')
plot(Fz{3},'g--')
plot(Fz{4},'m--')
plot(Fz{1}+Fz{2}+Fz{3}+Fz{4},'k')
title('z Forces')
legend('Foot1','Foot2','Foot3','Foot4','Net')

%% 
plotx(posArray,desArray,linAccArray,Fx)
%%
ploty(posArray,desArray,linAccArray,Fy)
%%
plotz(posArray,desArray,linAccArray,Fz)



