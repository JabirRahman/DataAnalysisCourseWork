% In this script we will load the dataset 'p1894.dat' and will call our
% functions to conduct various tasks that were wanted in the question
close all
clear all
clc
% Load first ASCII data (p1894.dat) into Matlab and assign different data
% sets as vectors. Also plot shear stress(column two) as a function of 
% time (column 5) 

data_one = load('p1894.dat');  % load binary data
shear_stress = data_one(:, 2); % save shear stress values from the matrix 
                               % as vaector
time = data_one(:, 5);         % save time values as vector
figure(1)
plot(time, shear_stress)       % plot shear_stree as a function of time
xlabel('Time, s')
ylabel('Shear Stress, MPa')

% Plotting Different parts of shear stress (vs time) as subplots to have a
% better look
figure(2)
subplot(2,2,1)
plot(time, shear_stress)       % plot shear_stress as a function of time
xlim([1000 1499])              % time range from 1000 sec to 1499 seconds
xlabel('Time, s')
ylabel('Shear Stress, MPa')

subplot(2,2,2)
plot(time, shear_stress)
xlim([1500 2500])
xlabel('Time, s')
ylabel('Shear Stress, MPa')

subplot(2,2,3)
plot(time, shear_stress)
xlim([2500 4000])
xlabel('Time, s')
ylabel('Shear Stress, MPa')

subplot(2,2,4)
plot(time, shear_stress)
xlim([4000 5500])
xlabel('Time, s')
ylabel('Shear Stress, MPa')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Call the time derivative function to get the time of stick slip events  
% and average time between vents. Also plot time derivative of shear stress 
% vs time. Set a threshold value for the time derivative of shear stress  
% as (min_d) to identify the events   
min_d = - .1;

% Event time = Respective time of each event
% Average time = the average waiting time between events
[Event_time, Average_time] = time_derivative(shear_stress, time, min_d);
Average_time % display average time
assert(Average_time > 0) % average time can't be negative or zero, if it's zero,
% it becomes actually a non varying continuous process
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Look at the layer thickness as a function of time and remove effect of 
% material loss save layer thickness values from the data matrix  as vector
layer_thickness= data_one(:, 3);

% Call the funcion to get the values using both (polyfit and detrend) methods
[poly_fit_result, detrend_result] = remove_effect(layer_thickness, time);

% Check two random values from the results of both methods to be confirmed 
% that we got the same results
Polyfit_v = poly_fit_result(2000, 1) % one random value from polyfit method
Detrend_v = detrend_result(2000, 1) % one random (same index) value from detrend method

% plot both results with respect to time to check if we got the same
% results
figure(4)
plot(time, layer_thickness,'g')
hold on
plot(time,poly_fit_result,'--k')
plot(time,detrend_result,'r')
xlabel('Time, s')
ylabel('Layer Thickness, micro meter')
title('Layer Thickness and Modified Layer Thickness vs Time')
legend('Original layer thickness','modified(polyfit)','modified(detrend)')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save the amplitudes of vibration (Volt) data as a vector and plot vs time
vibration = data_one(:,9);

min_v =(40000);  % minimum amplitude of vibration, set that to pass to 
%function, unit (volt)
% call the function and get the lower limt(l_time) and upper limit (u_time) 
% of time range
[l_time, u_time] = vibrated_time(time, vibration, min_v, Average_time);
figure (5)
plot(time, shear_stress)
% use the lower and upper limit to plot only that portion to focus on the
% stick slip even while there was a vibration applied to the apparatus 
xlim([l_time, u_time])     
xlabel('Time, s')
ylabel('Shear Stress, MPa')
