% In this script we will load the second binary data(p2394.dat) into matlab
% and will plot the friction co-efficient vs time and normal stress vs time
% using a short time limit to get a close up figure for checking the relation 
% between friction co-efficient and normal stress. 
close all
clear all
clc

% load binary data 'p2394.dat'into matlab.

fid = fopen('p2394.dat','rb'); % open the binary data into matlab
second_data = fread(fid, Inf, 'double'); % save the data to a veriable name 
%(second_data is just a veriable name)

assert(isa(second_data,'double'),'Product is not type double.') % data must be of double type

data_final = reshape(second_data, [9 88599]); % Reshape the data from vector
% form to matrix form using reshape and save the matrix, give a name for
% the matrix(i.e. data_final), here it will save the vector second_data to 
% a matrix having 88599 columns and 9 rows

data_final = data_final'; % since we need the matrix (as our first matrix) 
% having 9 columns, take the traspose of data_final. The transpose 
% operation switches the rows and columns in a matrix

fclose(fid); % close the fid.

%save different types of components data from data matrix as vectors

load_p_displacement = data_final(:, 1); % save load point displacement as a vect or, unit (micro meter)
shear_stress = data_final(:, 2); % save shear stress as a vector, (MPa) 
layer_thickness = data_final(:,3); % layer_thickness, unit (micro meter)
time = data_final(:,5); % save time vector, unit (seconds)
friction_coefficient = data_final(:,6); % unitless 
normal_stress = data_final(:,4); % unit, (MPa)
shear_strain = data_final(:,7); % unit less
e_c_displacement = data_final(:,8); % elstically correlated displacement,% unit, (micro meter)
v_acceleration = data_final(:,9); % vibration acceleration, unit(Volt)

% plot friction co-efficient and normal stress vs time in two subplots
% use xlim to fix a limit to get a close up figure within this limit for both components to compare

figure(1)
subplot(2,1,1)
plot (time, normal_stress)
xlabel('Time, s')
ylabel('Normal Stress, MPa')
xlim([3730 3820])
title('Normal Stress and Friction Co-efficient vs Time')

subplot(2,1,2)
plot (time, friction_coefficient)
xlabel('Time, s')
ylabel('Friction Co-efficient') 
xlim([3730 3820])
