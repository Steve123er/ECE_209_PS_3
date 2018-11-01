%robot movements
%write down the kinematic equations using the two controls as input
%wheel distances 85mm wd
%radius 20mm r
%Input the two velocity arguments, come up with a new state.
function state = robot_movement(v1,v2,state)
if v1==v2 %case where the bearing angle is the same just keep the same angle
    %Update the time based on the absolute bearing angle.
    %Also see if it is backwards or forwards
    switch(angle)%Break this movement based on bearing angle.  
        case (angle > 315) || (angle<45)%north

        case (angle > 45) && (angle<135)%east

        case (angle > 135) && (angle<225)%south
            
        otherwise %west
            
    end
elseif v1>v2
    fprintf('sat')%we may assume that only one wheel maybe moving to account for
    %turning
elseif v1<v2
    fprintf('fat')
end
end