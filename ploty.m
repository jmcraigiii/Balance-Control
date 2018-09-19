function ploty(posArray,desArray,linAccArray,Fy)
% Plots all plots related to the y direction

% y position: actual vs. desired
figure
plot(posArray{2},'ro')
hold on
plot(desArray{2},'b')
title('y position')
legend('Actual','Desired')

% y acceleration: commanded
figure
plot(linAccArray{2},'ro')
title('y acceleration')

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