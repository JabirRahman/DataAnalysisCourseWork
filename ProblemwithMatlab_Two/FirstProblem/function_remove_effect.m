function [ mod_layer_thickness, new_layerthickness] = remove_effect(layer_thickness, time)

% This function will plot the layer thickness as a function of time
% and will remove the effect of material loss using the 'polyfit'
% function (and subtraction from data)and also using built in 'detrend'function
% Inputs:
%       : layer_thickness - pass layer thickness values as a vector 
%                           from the matrix, micro meter
%       : time - pass time values from data matrix as vector, seconds

% Output:
%       : mod_layer_thickness = layer thickness values after removing the effect using
%                 polyfit function and subtraction from original data
%       : new_layerthickness = layer thickness values after removing the effect
%                 using detrend function

% fit a linear function to the thickness data as a function of time

% fit_function = here, polyfit will give us a polynomial  
% (first order (n = 1 here), having length = 2), of co-efficients 
% that will be a best fit for data in (layer_thickness)
fit_function = polyfit(time, layer_thickness,1);

% polyval returns the value of polynomial 'fit_function' evaluated at time
f_function = polyval(fit_function, time);

% Substract this values from the original layer thickness vector and that
% will remove the effect of material loss
mod_layer_thickness = layer_thickness - f_function;

% matlab builtin 'detrend' function will give us the same result
new_layerthickness = detrend(layer_thickness);
end

