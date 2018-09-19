function plotz(posArray,desArray,linAccArray,Fz)
% Plots all plots related to the z direction

% z position: actual vs. desired
figure
plot(posArray{3},'ro')
hold on
plot(desArray{3},'b')
title('z position')
legend('Actual','Desired')

% z acceleration: commanded
figure
plot(linAccArray{3},'ro')
title('z acceleration')

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