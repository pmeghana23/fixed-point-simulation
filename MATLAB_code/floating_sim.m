% This code simulates the floating point implementation of y = ax + b
clear all
clc
a = 3.2;
b = 2.7;
x = 0:10;
for i = 1:length(x)
    y(i) = a*exp(-x(i))+b;
end
figure;
title('Plot of y using floating-point (double)')
plot(y); 
