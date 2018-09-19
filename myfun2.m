function f = myfun2(x)
global mb comLinAcc g


f = norm(mb*comLinAcc-[x(1);x(5);x(9)]-[x(2);x(6);x(10)]-[x(3);x(7);x(11)]-[x(4);x(8);x(12)]+mb*g);

