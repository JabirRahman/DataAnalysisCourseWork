% In this function we will use it to calculate the solution using matrix vectorization.
% For that we need to find a matrix for multiplication with our initial solution
% equation. After getting that matrix, we can  simply update our solution using
% matrix power. Since, Matlab is very efficient in matrix operation, that way we can
% compute our solution in  a faster way. To find that matrix, we can rearrange the solution
% equation is a way that it becomes just a matrix multiplication equation. It will also
% help us get rid of both for loops.

function [solution3] = matrix_multiplication(delt, delx, x_minimum, x_maximum)
        tic
        %We are defining our spatial domain here. spatial doamin is given
        %as x[0 1]. So the minimum value is zero and maximum value is one.
        %It can change according to the question.
        x = (x_minimum:delx:x_maximum); 
        
        % c is a constant taken for easy writing and calculation.             
        c = (delt/delx);
        
        % Storing c values as a vector so that we can use it later to make 
        % a diagonal matrix.
        c =  c.*ones(1,101);
        
        % another constant. We will also make a vector for (d) to make
        % another diagonal matrix
        d = (1-c);                          
        d = d.*ones(1,101);                                   
 
        % initial value of (u). the initial condition equation is used to 
        % calculate the values.
        u0 = exp((-(x-0.25).^2)./0.005);    
        u = u0;
                 
        % Now, we are turning u0 to  a column vector to match with the 
        % matrix multiplication requirement (matching dimensions)                                         
        u_vector = [u0];  
        
        % Turning it to be a column vector.
        u_vector = u_vector.'; 

        % initializing two vectors so that us them to make two diagonal
        % matrices. We will mi
        A = ones(1,101);                    
        B = ones(1, 101);
                                    
        % turning the matrices to diagonal matrices and multiplying with 
        % constant c and d. That way we will get two diagonal matrices
        % having the values of c and d respectively in their diagonals.
        A = c.*(diag(A));                   
        B =  d.*(diag(B));
        
        % creating a zero vector. We need a zero vector because we need the
        % first row of our two diagonal matrices to be of zeros so that it
        % fulfills the boundary condition.
        zero_matrix= zeros(1,101);          

        % inserting a row of zeros above the first row of both of the 
        % matrices and making it the first row.
        A_new = [zero_matrix; A];           

        B_new = [zero_matrix; B];                    
                                    
        % modifying one matrix and inserting column of zeros as the first 
        % column. This way we can get a matrix that will have its diagonal 
        % values shifted for one step on right side. Since we need to make
        % a final matrix that will have (c) values as its diagonal values
        % and d values just on the associated right positions of the
        % diagonal.
        A_with_zeros = [zeros(size(A_new,1),1) A_new];

        % But after inserting a zero column as the first column we increased 
        % the column number by one. Now we need to reduce one column to 
        % match both dimensions of both matrices so that we can add them.                          
        A_zeros_last = A_with_zeros(:, 1:end-1); 
        
        % We need a final matrix that will contain both c and d values. And
        % for that we now added both matrices to make the final matrix.
        final_matrix = B_new + A_zeros_last;
        
        % Well, there is one problem now, to raise a matrix to its power
        % we need a square matrix. To make it square, we are decreasing one
        % column from last so that we can raise its power.
        final_matrix_two = final_matrix(1:end-1, :);

        %finally multiplying the matrix with our initial column vector. This
        % multiplication will give us the values of (u) directly for the
        % final time step. We don't need any loop here. Just a matrix
        % multiplication. the final values of (u) are stored as solution3
        % to be used for plotting.
        solution3 = ((final_matrix_two)^100) * u_vector;
        toc

end
