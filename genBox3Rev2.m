function genBox3Rev2(pos,l,w,h,color)
% First three inputs are position of the center
% Second three inputs have to do with the rotation angles of the body fixed
% coordinate system

% If the center of the body were the origin, how would it rotate
p{1} = [-w/2;l/2;h/2];
p{2} = [w/2;l/2;h/2];
p{3} = [-w/2;l/2;-h/2];
p{4} = [w/2;l/2;-h/2];
p{5} = [-w/2;-l/2;h/2];
p{6} = [w/2;-l/2;h/2];
p{7} = [-w/2;-l/2;-h/2];
p{8} = [w/2;-l/2;-h/2];

% Homogeneous transformation of points from {B} to {A}
aRb = rotMatFRev2('z',pos(4))*rotMatFRev2('y',pos(5))*rotMatFRev2('x',pos(6));
T = [aRb [pos(1);pos(2);pos(3)]];
T = [T;[0 0 0 1]];
for i=1:length(p)
pr{i} = T*[p{i};1];
end

% Plot the body
plot3([pr{1}(1),pr{2}(1)],[pr{1}(2),pr{2}(2)],[pr{1}(3),pr{2}(3)],color)
hold on
plot3([pr{1}(1),pr{3}(1)],[pr{1}(2),pr{3}(2)],[pr{1}(3),pr{3}(3)],color)
plot3([pr{1}(1),pr{5}(1)],[pr{1}(2),pr{5}(2)],[pr{1}(3),pr{5}(3)],color)

plot3([pr{2}(1),pr{4}(1)],[pr{2}(2),pr{4}(2)],[pr{2}(3),pr{4}(3)],color)
plot3([pr{2}(1),pr{6}(1)],[pr{2}(2),pr{6}(2)],[pr{2}(3),pr{6}(3)],color)

plot3([pr{3}(1),pr{4}(1)],[pr{3}(2),pr{4}(2)],[pr{3}(3),pr{4}(3)],color)
plot3([pr{3}(1),pr{7}(1)],[pr{3}(2),pr{7}(2)],[pr{3}(3),pr{7}(3)],color)

plot3([pr{4}(1),pr{8}(1)],[pr{4}(2),pr{8}(2)],[pr{4}(3),pr{8}(3)],color)

plot3([pr{5}(1),pr{6}(1)],[pr{5}(2),pr{6}(2)],[pr{5}(3),pr{6}(3)],color)
plot3([pr{5}(1),pr{7}(1)],[pr{5}(2),pr{7}(2)],[pr{5}(3),pr{7}(3)],color)

plot3([pr{7}(1),pr{8}(1)],[pr{7}(2),pr{8}(2)],[pr{7}(3),pr{8}(3)],color)
plot3([pr{6}(1),pr{8}(1)],[pr{6}(2),pr{8}(2)],[pr{6}(3),pr{8}(3)],color)
