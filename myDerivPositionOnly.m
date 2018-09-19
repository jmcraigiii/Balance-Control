function xDot = myDerivPositionOnly(t,x,F,mb,g)
% inputs are the time t, the vector x, which contains x0 and xd0t
% x1 = x    = x(1)
% x2 = xDot = x(2)
% x3 = y    = x(3)
% x4 = yDot = x(4)
% x5 = z    = x(5)
% x6 = zDot = x(6)

% Sum of Forces
%x
x1Dot = x(2);
x2Dot = (1/mb)*(F(1,1)+F(1,2)+F(1,3)+F(1,4));
%y
x3Dot = x(4);
x4Dot = (1/mb)*(F(2,1)+F(2,2)+F(2,3)+F(2,4));
%z
x5Dot = x(6);
x6Dot = (1/mb)*(F(3,1)+F(3,2)+F(3,3)+F(3,4))-g(3);

xDot = [x1Dot; x2Dot; x3Dot; x4Dot; x5Dot; x6Dot];





