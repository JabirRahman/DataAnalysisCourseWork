function [t2, t3] = vibrated_time( time, vibration, min_v, Average_time)
% This function will give us lower limit and upper limit of a time range  
% within what at least one vibration was applied to the apparatus. We can 
% use this limits to plot shear stress within this time range

% Input: time - pass time values from data matrix as vector, seonds
%        vibration- pass vibration amplitude values from data matrix as
%                   vector, volt
%        min_v = pass the min vibration amplitude value, volt 
%        Average_time = pass average time between events, it is calculated  
%                   using another function      
       
% Output: t2 = lower limt of time range 
%         t3 = upper limit of time range

% process: Since when vibration was applied, the amplitude of vibration 
%          must increased, we will set a minimum limit for amplitude to  
%          identify these times and will take a time from these time values 
%          and will determine a lower and upper limt from it.

assert(min_v >0);

vibration_time = time(vibration > min_v); % find all the time values when 
% vibration amplitude is greater than a min defined (user defined) value

t_1 = vibration_time(end); % take any value from these time values, we are
%                taking the last value

t2 = t_1 - (Average_time*50); % lower limit of our time range
t3 = t_1 + (Average_time*50); % upper limit of our time range

%t3 = -t3; check if assertion works or not

assert(t3 > t2); % upper limit must be greater than the lower limt

end

