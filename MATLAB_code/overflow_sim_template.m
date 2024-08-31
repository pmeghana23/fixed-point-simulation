% This code (when completed) simulates the fixed point implementation of
%  y = a x + b 
% for a fixed-point processor (5510 or 5515).
% The result of this fixed-point implementation is compared with
% floating-point implementation.
% There are two variants (1) and (2). Experiment with the Overflow option to understand the difference between Wrap and Saturate.
%
close all
clear all
clc
%% (1) Floating point values with b = -260.7
%{
a = 3.2;
b = -260.7;
x = 5101:5200;
%% Fixed-point values
% Create the fixed-point number representation for the floating point values
% defined above.
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
math = fimath('OverflowAction','Saturate',...
    'RoundingMethod','Floor',...
    'ProductMode','KeepMSB',...
    'ProductWordLength',16,...
    'SumWordLength',16 ...
    );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% WORK BELOW %%%%%%%%%%%%%%%%%%%%%%%%%
% If needed update the math function to achieve results that match
% floating-point values

% Fraction lengths has to be figured out by
% students.
af = fi(a, 1, 16, 13);
bf = fi(b, 1, 16, 6);
xf = fi(x, 1, 16, 2);

temp = fi(0, 1, 16, 0);
temp1 = fi(0, 1, 16, 0);
for i = 1:length(x)
    temp = fi(af*xf(i), 1, 16, 0);     % Temp. variable for product. Complete it.
    temp1 = fi(temp+bf, 1, 16, 0);% Temp. vairable for sum output. Complete it.
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
stem(abs(double(y)-double(yf)))
%}
%% (2) Floating point values with b=0

a = 3.2;
b = 0;
x = 5101:5200;
%% Repeat (1). Do the same 'math' options work well for these set of values.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% WORK BELOW %%%%%%%%%%%%%%%%%%%%%%%%%
% If needed update the math function to achieve results that match
% floating-point values

% Fraction lenghts has to be figured out by
% students.

math = fimath('OverflowAction','Saturate',...
    'RoundingMethod','Floor',...
    'ProductMode','KeepMSB',...
    'ProductWordLength',16,...
    'SumWordLength',16 ...
    );
af = fi(a, 1, 16, 13, math);
bf = fi(b, 1, 16, 14, math);
xf = fi(x, 1, 16, 2, math);

temp = fi(0, 1, 16, 0, math);
temp1 = fi(0, 1, 16, 0, math);
for i = 1:length(x)
    temp = fi(af*xf(i), 1, 16, 0);     % Temp. variable for product. Complete it.
    temp1 = fi(temp+bf, 1, 16, 0);% Temp. vairable for sum output. Complete it.
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
stem(abs(double(y)-double(yf)))

