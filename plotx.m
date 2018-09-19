function plotx(posArray,desArray,linAccArray,Fx)
% Provides all plots related to the x direction

% x position: actual vs. desired
figure
plot(posArray{1},'ro')
hold on
plot(desArray{1},'b')
title('x position')
legend('Actual','Desired')

% x acceleration: commanded
figure
plot(linAccArray{1},'ro')
title('x acceleration')

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