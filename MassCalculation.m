% Adam Elkhanoufi
% 04/27/2022

global accuracy;
a = 2;
b = 4;
accuracy = 1e-5;
g = @(x) ((x-2).^4 + 3*x + 12) ./ (x + 4);
h = @(x) 9 - sqrt(1 + (x - 2).^3);
v = @(x, y) 8;
w = @(x, y) x + y + 2;
f = @(z, x, y) ((z.^3 .* cos(x + y + z))./(2*x + 3*z + 2)) + (z.^2 .* log(y.*sqrt(z + y.^3)));

mass = quad(@middle, a, b, accuracy, [], g, h, @inner, f, v, w);
fprintf('mass = %.4f\n', mass);

function middleIntegral = middle(x, g, h, inner, f, v, w)
    global accuracy;
    n = length(x);
    middleIntegral = zeros(1, n);

    for (k = 1:n)
        gVal = g(x(k));
        hVal = h(x(k));
        middleIntegral(k) = quad(inner, gVal, hVal, accuracy, [], x(k), f, v, w);
    end
end

function innerIntegral = inner(y, x, f, v, w)
    global accuracy;
    n = length(y);
    innerIntegral = zeros(1, n);

    for (k = 1:n)
        vVal = v(x, y(k));
        wVal = w(x, y(k));
        innerIntegral(k) = quad(f, vVal, wVal, accuracy, [], x, y(k));
    end
end
