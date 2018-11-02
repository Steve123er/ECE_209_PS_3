%simulate robot
%This function takes a model of the robot and with some model of slippage
%and of measurement noise then simulates how the robot will be driving
%around the track.  
a=90;
t=0.1;
v=10;
F=[1 0 0;-v*sind(a)*t 1 0;v*cosd(a) 0 1];
W=[t 0;0 cosd(a)*t;0 sind(a)*t];
Q=[100;100];