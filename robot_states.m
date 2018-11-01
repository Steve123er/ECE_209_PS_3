%Problem Set #3
%Define the state space
%Discretize based on mm order movement so that the calculations go to the
%nearest mm.  
% arena=ones(500,750);
% states=ones(500,750,3600);%360 is the theta from 0.1 to 360
%For each sensor, get the expected output as a function of the state.  
%We also have to consider the bearing of the robot itself.  
%Assume we have a known state, then we have a measurement model
%The north is given in terms of y units with angle defined as the angle
%relative to true north given by the IMU.  decreasing y value is more north
%Draw a measurement from the normal distribution using a percent error

function [mF,mR,mA] = robot_states(states)
    mF=measureFront(states);
    mR=measureRight(states);
    mA=measureAngle(states);
end
function measurementF = measureFront(state)
%Range sensor looking right in front
%Make cases for each of the four cardinal directions north south east west
angle=mod(state(3),360);
measurementF=1;
y=state(1);
x=state(2);
accuracy=0.05;
w=500;
l=750;
switch(angle)
    case (angle > 315) || (angle<45)%north
        bA=0;
        y=y/cosd(angle-bA);
        measurementF=normrnd(y,accuracy*y);
        if measurementF<1
            measurementF=1;
        end
    case (angle > 45) && (angle<135)%east
        bA=90;
        x=x/cosd(angle-bA);
        measurementF=normrnd(w-x,accuracy*(w-x));
        if measurementF<1
            measurementF=1;
        end
    case (angle > 135) && (angle<225)%south
        bA=180;
        y=y/cosd(angle-bA);
        measurementF=normrnd(l-y,accuracy*(l-y));
        if measurementF<1
            measurementF=1;
        end
    otherwise %west
        bA=270;
        x=x/cosd(angle-bA);
        measurementF=normrnd(x,accuracy*(x));
        if measurementF<1
            measurementF=1;
        end
end

end
function measurementR= measureRight(state)
%Range sensor looking to the right of robot
angle=mod(state(3),360);
measurementR=1;
y=state(1);
x=state(2);
accuracy=0.05;
w=500;
l=750;
switch(angle)
    case (angle > 315) || (angle<45)%north measure the east
        %define the center of the bearing angle at 0 degrees representing
        %true north
        bA=0;
        x=x/cosd(angle-bA);
        measurementR=normrnd(w-x,accuracy*(w-x));
        if measurementR<1
            measurementR=1;
        end
    case (angle > 45) && (angle<135)%east measure 
        bA=90;%bearing angle
        y=y/cosd(angle-bA);
        measurementR=normrnd(l-y,accuracy*(l-y));
        if measurementR<1
            measurementR=1;
        end
    case (angle > 135) && (angle<225)%south
        bA=180;
        x=x/cosd(angle-bA);
        measurementR=normrnd(x,accuracy*(x));
        if measurementR<1
            measurementR=1;
        end
    otherwise %west
        bA=270;
        y=y/cosd(angle-bA);
        measurementR=normrnd(y,accuracy*(y));
        if measurementR<1
            measurementR=1;
        end
end
end
function angle = measureAngle(state)
    %Account for noise in the IMU.
    angle=state(3);
    accuracyA=0.05;
    angle=normrnd(angle,(angle*accuracyA));
    if angle<1
        angle=1;
    end
end


