% In this problem we are going to get a solution for the one was wave equation.
% This script is our final master script where we are going to call all three
% functions and plot the results. For that, first we need to define all the input
% variables that our three functions will require.

clc
close all
clear all


delt = 0.005;     %this is our Time steps over the axis
delx = 0.01;      %it's the diffrence between two spacial points
                       
t = 0;            %initial time when we start calculation
velocity = 1;     %velocity of wave is = 1
N = 100;          %total number of time steps (given)
tmax = (N*delt);  %total time. We have 100 time steps and every step is 
                  %0.005. So,100*0.005 = 0.5

x_minimum = 0;    %Since, spatial domain is x[0 1], minimum value of x = 0

x_maximum = 1;    %and maximum value for x = 1

%setting our spatial axis (x axis values) so that we can use it for the
x = (x_minimum:delx:x_maximum);

%initial condition equation, given in the question. we also want to keep 
%that in our figure to have a comparision between the initial values and 
%the final values of (u)
u_old = exp((-(x-0.25).^2)./0.005);

% Boundary condition is given in the question. According to this condition the
%value for every time step will be zero
u(1) = 0;
                                   
%here calculating the solution values using the function that will use the 
%looping procedure
                                    
solution_using_loop = looping_solution(delt, delx, tmax, x_minimum, x_maximum); 
                                    
%Now, calculating the solution values using the function that will use
%vectorization rather than looping procedure

solution_using_vectorization = vecotorization(delt, delx, tmax, x_minimum, x_maximum);
                                    
%here calculating the solution values using the function that will use 
%vectorization along with metrix multiplication rather than looping procedure

solution_using_matrix_multiplication = matrix_multiplication(delt, delx, x_minimum, x_maximum );

%values of u for the first time step, we calculated it using the initial 
%condition equation (exponential equation),

% we are plotting three separate figures for three methods
figure (1)  

subplot (3, 1, 1)
%plot for old values of u, keeping that for comparision with new values 
plot (x, u_old, '--r');             
hold on
plot (x, solution_using_loop, '*b');
hold off
xlabel('x(Spatial Domain), Problem 1 (a)')
ylabel('u(x)')
title('One Way Wave Equation in 1D')



subplot (3, 1, 2)
plot (x, u_old, '--r');               
hold on
plot (x, solution_using_vectorization, '*b');
hold off
xlabel('x(Spatial Domain), Problem 1(b)')
ylabel('u(x)')
legend('Old Solution', 'Updated Solution')



subplot (3, 1, 3)
plot (x, u_old, '--r');               
hold on
plot (x, solution_using_matrix_multiplication, '*b');
hold off
xlabel('x(Spatial Domain), Problem 1(c)')
ylabel('u(x)')



% Elapsed time is 0.001940 seconds.
% Elapsed time is 0.005181 seconds.
% Elapsed time is 0.013853 seconds.
