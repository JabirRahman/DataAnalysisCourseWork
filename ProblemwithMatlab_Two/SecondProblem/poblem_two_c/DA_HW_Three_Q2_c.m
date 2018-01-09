% In this script we will take the derivative of shear stress to find
% the time of stick slip events. Then will calculate the average time of 
% stick slip event and will see if the time between stick slip events
% changed from first experiment for applied normal stress or not.

clear all
close all
clc

% load binary data 'p2394.dat'into matlab.
fid = fopen('p2394.dat','rb'); % open the binary data into matlab
second_data = fread(fid, Inf, 'double'); % save the data to a veriable 
%('second_data' is just a veriable name)


data_final = reshape(second_data, [9 88599]); % Reshape the data from vector form
%to matrix form using reshape and save the matrix, give a name for
% the matrix(i.e. data_final), here it will save the vector second_data to 
% a matrix having 88599 columns and 9 rows.

assert(isa(second_data,'double'),'Product is not type double.') % data must be of double type

data_final = data_final'; % since we need the matrix (as our first matrix)
% having 9 columns, take the traspose of data_final. The transpose 
% operation switches the rows and columns in a matrix 
fclose(fid); % close the fid.

% define shear stress, normal stress and time as vectors
shear_stress = data_final(:, 2);
time = data_final(:,5);
normal_stress = data_final(:,4);

dx = shear_stress(2: end) - shear_stress(1:end-1);

dt = time(2:end) - time(1: end-1);

derivative = (dx./dt); 

% Calculate time between stick slip events
% fix a minimum value for the derivative to calculate the events and to get
% the respective time for that event

min_deri_value = -0.01; % Our fixed minimum value for the derivative to calculate the number of events

assert(min_deri_value <0); % we will only count those derivative values as events that are less than zero

event_time = time(derivative < min_deri_value); % time vector contatining
% all the time values when there was an event

% Detemine minimum and maximum time value from the event_time vector
min_v_time = event_time(1); 
max_v_time = event_time(end);

Average_time = (max_v_time - min_v_time)/ (length(event_time) - 1)
assert (Average_time > 0) % average waiting time should be greater than zero

% Plot normal stress vs time and Derivative vs time to see if there is a
% relation between normal stress application and derivative value reduction
subplot(2,1,1)
scatter(time, normal_stress)
xlabel('Time, s')
ylabel('Normal Stress, MPa')
xlim([3000 3100])
ylim([0 6])
title('Normal Stress vs Time')
subplot(2,1,2)
scatter (time([2:end]), derivative)
xlim([3000 3100])
ylim([-6 1])
xlabel('Time, s')
ylabel('Derivative, MPa/s')
title('Derivative vs Time')
