%We are going to use the looping method to calculate the solution. This is 
%our first method. In this process we will use two loops, one inside
%another

function [ solution1] = looping_solution(delt, delx, tmax, x_minimum, x_maximum)
        tic
        %We are defining our spatial domain here. spatial doamin is given
        %as x[0 1]. So the minimum value is zero and maximum value is one.
        %It can change according to the question.
        x = (x_minimum:delx:x_maximum);
        
        % c is just a constant, rather than writing delt/delx every time,
        % we are defining a new constant c here for easy writing and to
        % avoid confusion that should it be delt/delx or delx/delx and like
        % that.
        c = (delt/delx);                                                   
        
        %calculating u0 using our initial condition 
        %equation at t=0. We will use these values to  
        %next values of u.                                                                                                                                  
        u0 = exp((-(x-0.25).^2)./0.005);                                   
        
        %setting up our boundary conditions.This way u_next will take the 
        %values of u0 before it enters the loop for the first time.
                                                                                                                                                                                                     
        u = u0;                                                            
        u_next = u0;  
        
        %by deviding the maximum time with one time step, we can get the 
        %total number of time steps if it's not given in the question. But 
        %its also 100 in the question.
        time_steps = tmax/delt;                                            
        
        %our first loop is over 100 time steps and second loop inside the 
        %first loop is over all spacial points. Since we need to calcualte 
        %u(m-1), we must have to start (m) from 2 and to 101 to get 100 
        %spatial points. The inside loop will circulate for 100 values of
        % m and calculate the (u) values for a single time step. Then it 
        %will go back and for the second value of n, the next loop will 
        %start. The process continues for all values of n and finally the 
        % loop exists and we will get the final value of (u) for the last 
        %time step.
        
        for n = (1:time_steps)                                             
             
                 for m = (2:101)                                           
                 u_next(m) = u(m) - c*(u(m) - u(m-1));  
                 end                                                                                                             
    
                                                                           
                u = u_next; 
        end

        solution1 = u;
        toc
end    
