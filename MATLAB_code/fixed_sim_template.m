% This code simulates the fixed point implementation of y = a x + b 
% for a fixed-point processor (5510 or 5515)
% The result of this fixed-point implementation is compared with
% floating-point implementation.
clear all
clc
%% Floating point values
a = 3.2;
b = 2.7;
x = 3000:3099;
%% Fixed-point values
% Create the fixed-point number representation for the floating point values
% defined above
% Use a word-length (W) of 16, with 1 bit for sign (S). Also control the fraction
% length (F) and accordingly the integer word length (I).
% Do not let the total bits go beyond W. (i.e., W = S + I + F).
% When adding/multiplying numbers control the word length to remain at 16.
% Use fimath to setup appropriate intermediate behaviour.
% 
% 4th argument in fi can be used for setting the fraction length as shown
% below, q has W=16, S=1, F=2, I = 13
%  q = fi(0,1,16,2);
% Complete the code below to simulate computing of yf = af * xf + bf in
% fixed-point. Compare this result with y = a x + b.
math = fimath('RoundingMethod','floor',...
    'ProductMode','KeepMSB',...
    'ProductWordLength',16,...
    'SumWordLength',16);
af = fi(a, 1, 16, 13, math);
bf = fi(b, 1, 16, 13, math);
xf = fi(x, 1, 16, 3, math);
temp = fi(0, 1, 16, 1, math);
temp1 = fi(0, 1, 16, 1, math);
for i = 1:length(x)
    temp(:) = fi(af*xf(i), 1, 16, 1, math);     % Temp. variable for product. Complete it.
    bfshift = fi(bf, 1, 16, 1, math);           % Temp. variable for shifted b. Complete it.
    temp1(:) = fi(temp+bfshift, 1, 16, 1, math);% Temp. vairable for sum output. Complete it.
    yf(i) = temp1;                  % 
    y(i) = a*x(i) + b;              % Floating-point reference
end
% Plot floating-point output
figure; plot(y, 'k'); hold on; title('Plot of outputs y and yf')
% Overlay fixed-point output
plot(yf, 'r--')
legend('Floating-point ouptut', 'Fixed-point output')
% Plot the error (difference) between floating-point and fixed-point
figure; title('Error plot: Difference between floating-point and fixed-point')
stem(abs(double(y)-yf))