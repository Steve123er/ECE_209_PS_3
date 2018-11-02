%robot movements
%write down the kinematic equations using the two controls as input
%wheel distances 85mm wd
%radius 20mm r
%Input the two velocity arguments, come up with a new state.
%ICC=[x-R*sin(o),y+R*cos(o)]

%In this example, we have the y axis be north, with north bearing being
%angle 0.  

%According to the spec sheet the maximum rpm is 130, given a radius of 20mm
%and pi, that corresponds to a maximum speed of 272 mm/sec.  


function state = robot_movement(v1,v2,t,state)
l=85;%in mm distance between wheels
if v1==v2 %case where the bearing angle is the same just keep the same angle
    %Update the time based on the absolute bearing angle.
    %Also see if it is backwards or forwards
    x=state(2);
    y=state(1);
    angle=state(3);
    
    switch(angle)%Break this movement based on bearing angle.
        case (angle > 315) || (angle<45)%north
            x=x+sind(angle)*v1*t;
            y=y+cosd(angle)*v2*t; 
        case (angle > 45) && (angle<135)%east
            x=x+sind(angle)*v1*t;
            y=y+cosd(angle)*v2*t;
        case (angle > 135) && (angle<225)%south
            x=x+sind(angle)*v1*t;
            y=y+cosd(angle)*v2*t;
        otherwise %west
            x=x+sind(angle)*v1*t;
            y=y+cosd(angle)*v2*t;
    end
    state(2)=x;
    state(1)=y;
    state(3)=angle;
elseif v1~=v2
    fprintf('sat')%we may assume that only one wheel maybe moving to account for
    %turning
    w=(v2-v1)/l;%angular velocity
    x=state(2);
    y=state(1);
    angle=state(3);
    
    switch(angle)%Break this movement based on bearing angle.
        case (angle > 315) || (angle<45)%north
            x=x+sind(angle)*v1*t;
            y=y+cosd(angle)*v2*t; 
            angle=angle+w*t;
        case (angle > 45) && (angle<135)%east
            x=x+sind(angle)*v1*t;
            y=y+cosd(angle)*v2*t;
            angle=angle+w*t;
        case (angle > 135) && (angle<225)%south
            x=x+sind(angle)*v1*t;
            y=y+cosd(angle)*v2*t;
            angle=angle+w*t;
        otherwise %west
            x=x+sind(angle)*v1*t;
            y=y+cosd(angle)*v2*t;
            angle=angle+w*t;
    end
    state(2)=x;
    state(1)=y;
    state(3)=angle;

end
end