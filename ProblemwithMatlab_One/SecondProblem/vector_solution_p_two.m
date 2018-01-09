
% Here we are going to define a function that will use the heat solution 
% equation at point T(m,n). But for this purpose, we will use a 
% while condition but we will get rid of the for loops this time and vectorize
% our code iterate our solution over all spatial points under the domain 
% specified. We will also define the boundary conditons given in the 
% question. The function will return the temperature solution that we will 
% plot as 3D using surf command under the master script. The function will
% also return the time required toexecute the code.

function [ solution2 ] = vector_solution_p_two( x_minimum, x_maximum, y_minimum, y_maximum, delx )
        
% We can set our spatial axises here ince we know all the values needed.
        x = x_minimum: delx: x_maximum;
        y = y_minimum: delx: y_maximum;

% We can also get the toal spatial points by deviding the x value by delx
        spatial_points = (x_maximum - x_minimum)/delx;

% We are setting up a mtrix of zeros that has a dimension of 101 * 101 to
% represent our spatial domain. Since, we have 101 delx values including 
% zero, we are taking a matrix of this dimension.  
        primary_temperature = zeros(101, 101);

% Now we need to set up our boundary conditions. Conditions are specified
% in the question for all of our four sides of spatial domain.

% according to first condition, for first row, all the column temperature
%value must be equal to 4y(1-y).
        primary_temperature(1, :) = 4*y.* (1-y).^2;

% Our second condition states that in our temperature matrix, for last row 
% and for all the columns temperature value will be one.
        primary_temperature(101, :) = 1;

% Third condition states that for column one and for all the row values 
% Temperature must be 0.
        primary_temperature(:, 1) = 0;

% Fourth condition states that for last column and for all the rows, the 
% temperature value is equal to x.
        primary_temperature(:, 101) = x;

% now for our solution we need to set up a new matrix of non zero values
% and calculate the updated solution from the equation for T (m,n).
        u_temp = ones(101,101);

% Defining m and n so that we can use them to define our array to modify
% that. 
        m = 2:100;
        n = 2:100;
        tic
% Initializing the while loop. According to the condition, the loop will 
% if the difference between the updated matrix and the previous matrix for 
% each point is greater than (10^-6).
        while max(max(abs( primary_temperature - u_temp))) > 10^-6

              u_temp = primary_temperature ;
      
              primary_temperature(m,n) = 0.25.*(primary_temperature(m+1,n) + primary_temperature(m-1, n) + primary_temperature(m, n+1) + primary_temperature (m, n-1));
        end
        
        solution2 = primary_temperature;
        toc
end




