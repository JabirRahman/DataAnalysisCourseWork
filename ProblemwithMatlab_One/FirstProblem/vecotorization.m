
% In this function we are using the matrix vectorization tecnique. We will
% vectorize the u matrix values for the spacial domain and get rid of that
% inner loop used in the first loopin method. First, we will assign the
% initial (u) values to appropriate vector positions and then will move the 
% vector elements one step forward so that we can calcualte the difference
% according to the solution equation for every time step. The values of (u)
% will then updated and the loop is circulated for the next time step with 
% updated values of (u). Finallly, when the loop is over, final (u) value
% will be stored as solution2 that we will use to plot.

function [ solution2 ] = vecotorization( delt, delx, tmax, x_minimum, x_maximum )
% Again, we are defining our spatial domain here.
        tic
        x = (x_minimum:delx:x_maximum);
        
        % c is a constant taken for easy writing and calculation.
        c = (delt/delx);  
        
        % initial value of (u). the initial condition equation is used to 
        % calculate the values.
        u0 = exp((-(x-0.25).^2)./0.005);
        
        % setting up the initial values so that when (u) enters the loop,
        % can use this values to calculate the next values
        u = u0;
        u_next = u0; 
        
        % Time steps can be calculated using this equation or if it's given
        % in the question, that value can also be used.
        time_steps = tmax/delt; 
        
        % In this mehtod, we have only one loop (the for loop for time 
        % steps). It will circualte the loop for 100 times and will give us 
        % the final values of (u) after the final time step that we will use
        % for our plot.
        for n = (1:time_steps)
            
            % defining initial vector.here, we are assigning the (u) values
            % to a vector elements. That way we can get rid of the inner 
            % loop 
            new_u = u_next.* (ones(1,101));             
            
            % Defining shifted vector. Here the vector will be shifted to
            % one step forward and will be used to calculate the difference
            % to get the next updated values of (u).
            vector_new_u = new_u([end 1:end-1]);        
            
            % calculating updated values of (u) according to the equation
            % new_u is stands for actual values of (u) and vector_new_u for
            % one step forwarded values
            final_vector = new_u - (c.*(new_u - vector_new_u)); 
            
            % Storing the updated values of (u) to be used for the next
            % loop circle 
            u_next = final_vector;  
        end
        
        % Storing the values of (u) that we got after the last loop circle
        % for the final time step. This values will be used for plotting.
        solution2 = final_vector;
        toc
end
