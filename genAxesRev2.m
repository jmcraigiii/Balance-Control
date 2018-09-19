function genAxesRev2(pos)
% First three inputs of pos are position of the center
% Second three inputs  of pos have to do with the rotation angles of the 
% body fixed coordinate system

% If the center of the body were the origin, how would it rotate
p{1} = [0;0;0];
p{2} = [1;0;0];
p{3} = [0;1;0];
p{4} = [0;0;1];
for i=1:length(p)
pr{i} = rotMatFRev2('z',pos(4))*rotMatFRev2('y',pos(5))*rotMatFRev2('x',pos(6))*p{i};
end

% Translate the coordinates to be relative to the x,y,z center (move from
% origin
for i=1:length(p)
pr{i} = [pos(1);pos(2);pos(3)]+pr{i};
end

plot3([pr{1}(1),pr{2}(1)],[pr{1}(2),pr{2}(2)],[pr{1}(3),pr{2}(3)],'r') % x axis
hold on
plot3([pr{1}(1),pr{3}(1)],[pr{1}(2),pr{3}(2)],[pr{1}(3),pr{3}(3)],'g') % y axis
plot3([pr{1}(1),pr{4}(1)],[pr{1}(2),pr{4}(2)],[pr{1}(3),pr{4}(3)],'b') % z axis
