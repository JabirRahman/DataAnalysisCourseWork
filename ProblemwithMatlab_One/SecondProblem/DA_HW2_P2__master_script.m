% In this problem we are going to determine the solution for heat transfer 
% using finite difference approximation. We will use boundary conditions 
% defined in the question. This is also called the relaxation method as the 
% solution relaxes towards its steady state values as we iterate. When the 
% solution stops changing as we iterate, we will take that the solutio has
% converged. This is a steady state condition. So, our solution will not
% depend on time (t). We will use two predefined functions to get the
% solution, one using for loops and another one using vectorization and the
% time to execute both the programs.


clc
close all
clear all
% spatial domain is given as [0 1]*[0 1]; That means our both x, y values
% ranges from zero to one.
tic
x_minimum = 0;
x_maximum = 1;

y_minimum = 0;
y_maximum = 1;


% grid spacing delx is given in the question as dlx = 0.01
delx = 0.01;

% Defining and x and y so that we can use them to plot our solution.
x = x_minimum: delx: x_maximum;
y = y_minimum: delx: y_maximum;


% Here we are just using our predefined function to use the matrix to
% update solution using two for loops under a while loop. It will calculate
% the updated solution and plot it in 3D and also will give us a time if
% run as script.

figure(1)
subplot(1,2,1)
first_solution = matrix_solution_p_two( x_minimum, x_maximum, y_minimum, y_maximum, delx );
surf (x,y, first_solution)
xlabel('x', 'LineWidth', 6)
ylabel('y', 'LineWidth', 6)
zlabel('Temperature')
title('Steady State Solution to Heat Equation in 2D', 'LineWidth', 12)
legend('Solution to temperature')

% Here we are just using our predefined function to vectorize our code and
% to do some array maths and to finally plot and show us the time needed
% for execution of the code.

subplot(1,2,2)
second_solution = vector_solution_p_two( x_minimum, x_maximum, y_minimum, y_maximum, delx );
surf (x,y, second_solution)
xlabel('x', 'LineWidth', 6)
ylabel('y', 'LineWidth', 6)
zlabel('Temperature')
title('Steady State Solution to Heat Equation in 2D', 'LineWidth', 12)
legend('Solution to temperature')


%Elapsed time is 0.900274 seconds.
%Elapsed time is 1.253465 seconds.

% Well, the elapsed time shows that it took less time for the function that
% used for loops than the other one. The time difference for the wave
% equation was also less in the loop function than the vectorized form. Anyway,
% from both the problems, we found that loops functions took less time than
% the normal vectorized function.
