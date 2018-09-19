function xDot = myDeriv(t,x,F,mb,g,footPos,currentPos,oWb,oIb)
% inputs are the time t, the vector x, which contains x0 and xd0t
% x1 = x    = x(1)
% x2 = xDot = x(2)
% x3 = y    = x(3)
% x4 = yDot = x(4)
% x5 = z    = x(5)
% x6 = zDot = x(6)
% x7 = alpha = x(7)
% x8 = alphaDot = x(8)
% x7 = beta = x(9)
% x8 = betaDot = x(10)
% x7 = gamma = x(11)
% x8 = gammaDot = x(12)

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


% Sum of Moments
mat = cross((footPos{1}-[currentPos(1);currentPos(2);currentPos(3)]),[F(1,1);F(2,1);F(3,1)])+...
cross((footPos{2}-[currentPos(1);currentPos(2);currentPos(3)]),[F(1,2);F(2,2);F(3,2)])+...
cross((footPos{3}-[currentPos(1);currentPos(2);currentPos(3)]),[F(1,3);F(2,3);F(3,3)])+...
cross((footPos{4}-[currentPos(1);currentPos(2);currentPos(3)]),[F(1,4);F(2,4);F(3,4)])-...
cross(oWb,oIb*oWb);

oWbDot = oIb\mat;

%alpha / psi
x7Dot = x(8);
x8Dot = oWbDot(3);
%beta / theta
x9Dot = x(10);
x10Dot = oWbDot(2);
%gamma / phi
x11Dot = x(12);
x12Dot = oWbDot(1);

xDot = [x1Dot; x2Dot; x3Dot; x4Dot; x5Dot; x6Dot; x7Dot; x8Dot; x9Dot; x10Dot; x11Dot; x12Dot;];





