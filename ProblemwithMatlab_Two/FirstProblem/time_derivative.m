function [t,tt] = time_derivative(shear_stress, time, min_d )
% This function will calculate the derivative of shear stress and identify
% the stick-slip event time and average waiting time between events

% inputs: 
        % shear stress = pass shear stress values from data matrix as a 
        % vector
        % time = pass time values from data matrix as a vector
        % min_d = The threshold value of time derivate that will be used
        % for identifying events. Derivative value less than that threshold
        % value will be counted as an event, (user defined)
% output:
        % t = time of the stick-slip event
        % tt = average waiting time between events
        
% Steps:
        % rearrange shear stress vector to get the difference of each point
        % and previous point as (dx)
        % rearrange time vector to get the difference of each time point
        % and previous point as (dt)
        % Calculate (v) = time derivative of shear stress

        dx = shear_stress(2:end) - shear_stress(1:end-1); % Shear Stress  
        % difference between each point and privious point

        assert (min_d < 0);

        dt = (time(2:end) - time(1:end-1)); % time difference between each 
        % point and privious point

        v = dx./dt; % Time derivative of Shear Stress 
       
        t = time (v < min_d); % t = time of stick slip event
        tt = (t(end) - t(1))/(length(t) - 1); %average waiting time between 
                                              %events 
        
end

