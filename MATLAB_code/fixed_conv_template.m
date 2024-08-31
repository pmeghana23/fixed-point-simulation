% This code simulates the fixed point implementation of y = a * x, 
% where * is convolution.  
% (1) Use a word length of 4 for the input (xf) and filter coefficients (hf). 
% Obtain the fixed-point convolution output yf and compare it with the 
% floating-point implementation result y.
% (2) Use a word length of 16 the x, h, and y. Compare this fixed-point
% output with the output in (1) above and floating-point. 
clear all
clc
%% Floating point values
h = [1/3 1/3 1/3]';
x = [1/5 2/5 3/5 4/5]';
% Any other values needed can be initialized
% y = zeros(y_len,1);
%
x_conv = convmtx(x, length(h));
y = x_conv * h;
%% Fixed-point values
% Create the fixed-point number representation for the floating point values
% defined above
% Use a word-length (W) of 4, with 1 bit for sign (S). Also control the fraction
% length (F) and accordingly the integer word length (I).
% Do not let the total bits go beyond W. (i.e., W = S + I + F).
% When adding/multiplying numbers you can control the word length to be twice W.
% Use fimath to setup appropriate intermediate behaviour.
% 
% 4th argument in fi can be used for setting the fraction length as shown
% below, q has W=4, S=1, F=2, I = 2
%  q = fi(0,1,4,2);
% Complete the code below to simulate computing of yf = af * xf in
% fixed-point. Compare this result with y = a * x.
math = fimath('RoundingMethod','floor',...
    'ProductMode','KeepMSB',...
    'ProductWordLength',16,...
    'SumWordLength',16);
xf = fi(x, 1, 4, 3, math);
hf = fi(h, 1, 4, 3, math);
yf = fi(y, 1, 4, 3, math);

%% Write your code for convolution
% If needed you can create other variables
% Convolution has to be from scratch, this is an implementation using
% matrix multiplication 
x_convf = convmtx(xf, length(hf));
yf = x_convf * hf;
%
%% Plots for comparing outputs
figure;
% Plot of y using floating-point (double)
stem(y); hold on; title('Plot of outputs y and yf')
% Overlay fixed-point output
stem(yf, 'r--');
legend('Floating-point ouptut', 'Fixed-point output')
% Plot the error (difference) between floating-point and fixed-point
figure; title('Error plot: Difference between floating-point and fixed-point')
stem(abs(double(y)-yf))
