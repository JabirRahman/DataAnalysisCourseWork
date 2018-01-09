% In this script we will load the binary data as as well as the 
% first ASCII data and plot all the components vs time in two subplots to 
% check what components are behaving differently among them. 
close all
clear all
clc
% load binary data 'p2394.dat'into matlab.

fid = fopen('p2394.dat','rb'); % open the binary data into matlab

second_data = fread(fid, Inf, 'double'); % save the data to a veriable (second_data is just a veriable)

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
load_p_displacement = data_final(:, 1); % save load point displacement as a vector, unit (micro meter)

shear_stress = data_final(:, 2); % save shear stress as a vector, (MPa) 
layer_thickness = data_final(:,3); % layer_thickness, unit (micro meter)
time = data_final(:,5); % save time vector, unit (seconds)
friction_coefficient = data_final(:,6); % a unitless vector
normal_stress = data_final(:,4); % unit, (MPa)
shear_strain = data_final(:,7); % unit less
e_c_displacement = data_final(:,8); %elstically correlated displacement,unit, (micro meter)
v_acceleration = data_final(:,9); % vibration acceleration, unit(Volt)

% plot all the vectors vs time in a single figure to find out the
% difference between this experiment and the previous one
figure (1)
subplot(2,1,1)
plot(time, load_p_displacement,'*r')
hold on
plot(time, shear_stress,'y')
plot(time, layer_thickness,'c')
plot(time, friction_coefficient,'m')
plot(time, normal_stress, 'k')
plot(time, shear_strain,'g')
plot(time, e_c_displacement,'b')
plot(time, v_acceleration,'k')
xlabel('Time, s')
ylabel('load p displacement, micro meter')
title('load point displacement Vs Time, Second Case')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Now load the first ASCII data and save different component values as vectors

data_one = load('p1894.dat');  % load first experiment data

shear_stress1 = data_one(:, 2);
load_p_displacement1 = data_one(:, 1); % save load point displacement as a vector, unit (micro meter)
layer_thickness1 = data_one(:,3); % layer_thickness, unit (micro meter)
time1 = data_one(:,5); % save time vector, unit (seconds)
friction_coefficient1 = data_one(:,6); % a unitless vector
normal_stress1 = data_one(:,4); % unit, (MPa)
shear_strain1 = data_one(:,7); % unit less
e_c_displacement1 = data_one(:,8); %elstically correlated displacement,unit, (micro meter)
v_acceleration1 = data_one(:,9); % vibration acceleration, unit(Volt)

subplot(2,1,2)
plot(time1, load_p_displacement1,'*r')
hold on
plot(time1, shear_stress1,'y')
plot(time1, layer_thickness1,'c')
plot(time1, friction_coefficient1,'m')
plot(time1, normal_stress1, 'k')
plot(time1, shear_strain1,'g')
plot(time1, e_c_displacement1,'*b')
plot(time1, v_acceleration1,'k')

xlabel('Time,s')
ylabel('load p displacement, micro meter')
title('load point displacement Vs Time, First Case ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In this figure we will plot only the shear stress and normal stress vs
% time from the second binary data to show how the behavior of our shear 
% stress vs time plot changes with the application of normal stress
figure(2)

plot(time, shear_stress)
hold on
plot(time, normal_stress)
hold off
xlabel('Time, s')
title('Shear Stress and Normal Stress vs Time, Second Case')
ylabel('Shear Stress and Normal Stress, MPa')
legend('Shear Stress','Normal Stress')

% Description is on the word file
