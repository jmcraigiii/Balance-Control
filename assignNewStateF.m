function [currentPos,currentOrient] = assignNewStateF(xODE)
% This function takes the output of ODE45 and uses it to assign the
% resulting position and orientation of the body
%
% It was created simply to make the overall code easier to read

currentPos(1) = xODE(end,1);
currentPos(2) = xODE(end,3);
currentPos(3) = xODE(end,5);
currentPos(4) = xODE(end,2);
currentPos(5) = xODE(end,4);
currentPos(6) = xODE(end,6);
currentOrient(1) = xODE(end,7);
currentOrient(2) = xODE(end,9);
currentOrient(3) = xODE(end,11);
currentOrient(4) = xODE(end,8);
currentOrient(5) = xODE(end,10);
currentOrient(6) = xODE(end,12);