function f = myfun(x)
global mb comLinAcc g oIb comAngAcc oWb footPos currentPos

f = norm(mb*comLinAcc-[x(1);x(5);x(9)]-[x(2);x(6);x(10)]-[x(3);x(7);x(11)]-[x(4);x(8);x(12)]+mb*g)+...
    norm(oIb*comAngAcc+cross(oWb,oIb*oWb)-...
    cross(footPos{1}-[currentPos(1);currentPos(2);currentPos(3)],[x(1);x(5);x(9)])-...
    cross(footPos{2}-[currentPos(1);currentPos(2);currentPos(3)],[x(2);x(6);x(10)])-...
    cross(footPos{3}-[currentPos(1);currentPos(2);currentPos(3)],[x(3);x(7);x(11)])-...
    cross(footPos{4}-[currentPos(1);currentPos(2);currentPos(3)],[x(4);x(8);x(12)]));

