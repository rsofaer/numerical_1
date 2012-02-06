
function result = polynomial12 (x)
  result = x^3 - 2.5*x - 4.011;
endfunction

function result = dpoly12(x)
  result = 3*x^2 - 2.5;
endfunction

function result = polynomial13b (x)
  result = x^7 - 7*x^6 + 21*x^5 - 35*x^4 + 35*x^3 - 21*x^2 + 7*x - 1;
endfunction

function result = polynomial13c (x)
  result = (x-1)^7;
endfunction

function result = dpoly13c (x)
  result = 7*(x-1)^6;
endfunction

function [a, b] = bisect (maxit, a0, b0, f)
  a = a0;
  b = b0;
  if f(a)*f(b)>=0
    error("Function has the same sign at both sides of the given interval.");
    return;
  endif

  for i = 1:maxit
    new = a + (b-a)/2;
    value = f(new);
    if value == 0
      a = new;
      b = new;
      printf("Found 0 at %f.", [new]);
      return;
    elseif value*f(a) < 0
      b = new;
    elseif value*f(b) < 0
      a = new;
    else
      error("Failure.");
    endif 

    format = "After iteration %d, the interval of uncertainty is %f, from a = %f to b = %f, with values f(a) = %f and f(b) = %f.\n";
    printf(format, [i, abs(b-a), a, b, f(a), f(b)]);
  endfor
endfunction

function x = newton (maxit, f, fp, x0)
  x = x0;
  slope = fp(x);
  value = f(x);
  for i = 1:maxit
    x = (value-slope*x)/(-slope);
    slope = fp(x);
    value = f(x);
    printf("After iteration %d, x = %f, f(x) = %f, and f'(x) = %f.\n", [i, x, value, slope]);
    if abs(value) <= 10^(-15)
      disp("abs(f(x)) <= 10^(-15), stopping iteration.")
      return;
    endif
  endfor
endfunction

function x = secant (maxit, f, x0, x1)
  for i = 1:maxit
    slope = (f(x0) - f(x1))/(x0-x1);
    x2 = (slope*x0 - f(x0))/slope;

    x0 = x1;
    x1 = x2;
    printf("After iteration %d, x = %f and f(x) = %f.\n", [i, x1, f(x1)]);

    if abs(f(x1)) <= 10^(-15)
      disp("abs(f(x)) <= 10^(-15), stopping iteration.")
      return;
    endif
  endfor
endfunction

secant(100, @polynomial12, 3.1, -2)
%newton(15, @polynomial13c, @dpoly13c, 2.1)

