# CERI 7104/8104 Data Analysis in Geophysics
# HW 1
# File contains 4 functions: newton_poly, poly_eval, poly_der, and test_newton_poly
# if run as a script, code will execute the test function on code

# newton_poly is the main function to use Newton's method to find the root of a polynomail
# poly_eval is a helper function to evaluate the polynomial
# poly_der is a helper funtion to evalutate the polynomial derivative
# test_newton_poly is the test function

################################################################################

def newton_poly(p, x0, tol, nmax):
    'The function will receive p and x0 (as well as tol, nmax), will evaluate p with x0'
    
    assert type (p) is list, "input must be a list"

    x_i = x0
    for i in range (0, nmax, 1):
        'The loop repeats the process nmax times'
        
        if abs(poly_eval(p, x_i)) < tol:  
            'if absolute value of polynomial for x_i is less than the tolerance, the loops breaks here'
            break

        else:
            x_new = (x_i - (poly_eval(p,x_i)/poly_der(p,x_i))) # here loop calculates the new guess value
            difference= abs(x_i-x_new) # difference between old guessed value and new guessed value( calculated value)

            if difference< tol:
                'if the difference between these two guessed values is less than the tolerance, loop breaks here'
                break
            
            else:
                x_i = x_new  # Setting up the new value to x_i to start the loop again using new value 

                iteration = i #to keep track of the number of our iteration
    
    if iteration == nmax - 1:
        'If iteration reaches to nmax times without converging, we dont need repeat the loop any further'
        raise ValueError ()
                
    return (x_i, iteration+1)
    

################################################################################

# Helper functions

def poly_eval(p, x):
    "Evaluates the list using guessed values"
    
    assert type (p) is list, "input must be a list" 
    value1 = float (0) #initial value of value1 is zero 
    for n in range(0, len(p),1):
        'evaluating each term of the polynomial using x value'
        value1 = value1 + p[n]*x**(len(p)-n-1) 
        
    return value1 
 

#function for derivative
def poly_der(p, x):
    "Find the derivative of the polynomial"
    assert type (p) is list, "input must be a list"
    value2 = float (0) 
    for n in range (0, len(p)-1, 1): #directly evaluatng the derivative for x value
        value2 = value2 + (len(p)-n-1)*p[n]*x**(len(p)-n-2)
        if value2 == 0:
          'Prints value error for derivative of f(x) = 0'
          raise ValueError("Derivative Value is Zero")

    return value2

###############################################################################
# personal test
#def main():
        #fx = (poly_eval(poly, x)) 
        #print (poly_der(poly, x))

#main()
###############################################################################

# functions for performing tests

def test_newton_poly(testfunc):
    "tests cases for newton_poly, printing out result of each test"

    correct = 0

    tol = 2.e-16
    nmax = 100

    # successful tests

    poly = [[1., 0., -1.], [1., 0., -1.],[2., -4., 6., -8., 2.]]
    guess = [0.01, -0.01, 1000.]
    root_expect = [1., -1., 1.4872581163007652]

    print "tests where a root should be found"

    for p, g, expect in zip(poly, guess, root_expect):

        try:
            root, niter = testfunc(p, g, tol, nmax)
            if abs(root-expect) <= tol:
                result = 'PASSED'
            else:
                result = "FAILED"
        except:
            result = "FAILED"

        # sum up score

        if result == "PASSED":
            correct += 1

        print "Test: polynomial", p, "guess", g, "expected", expect, "actual", root, "result: "+result

    # unsuccessful tests

    nmax = 10

    poly = [[2., -4., 6., -8., 2.]]
    guess = [1000.]

    print "tests where code should fail"

    for p, g in zip(poly, guess):

        try:
            result = "FAILED"
            root, niter = testfunc(p, g, tol, nmax)
        except ValueError:
            result = "PASSED"
        except:
            pass

        if result == "PASSED":
            correct += 1

        print "Test: polynomial", p, "guess", g, "result: "+result

    print "\nCode scored", correct, "out of 4 tests"

if __name__ == '__main__':

    test_newton_poly(newton_poly)
