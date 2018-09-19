function x = getForces
% Uses fmincon to get the forces based on the commanded accelerations


lb = [-1000,-1000,-1000,-1000,-1000,-1000,-1000,-1000,0,0,0,0];
ub = [1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000];
A = [];
b = [];
Aeq = [];
beq = [];
x0 = [10,10,10,10,10,10,10,10,50,50,50,50]; 
nonlcon = @frictionConF;
x = fmincon(@myfun,x0,A,b,Aeq,beq,lb,ub,nonlcon);