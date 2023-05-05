

clc
clear variable
close all
format long
%% 
group_number=26;
f=8;
M1=4;
M2=7;
M3=10;
M4 =-2;
iteration=9;
%% 1
f_fundamental = 2*pi*f; %fundamental frequency
T = 1/f_fundamental; %period
t=0:T/1e+3:2*T;
s = @(t) M1*sin(2*pi*f*t) + M2*cos(5*pi*f*t) + M3*cos(7*pi*f*t) + M4;
%% 2
plot(t, s(t), 'r', 'LineWidth', 1);
grid on;
%% 3
% Calculating the Fourier coefficients
a = zeros(1,iteration+1);
b = zeros(1,iteration+1);
s_f = @(t) M1*sin(2*pi*f*t) + M2*cos(5*pi*f*t) + M3*cos(7*pi*f*t) + M4;
for i = 0:iteration
a_n_integral = @(t) s_f(t) .* cos(2*pi*i*t/T);
b_n_integral = @(t) s_f(t) .* sin(2*pi*i*t/T);
a(i+1) = (2/T)*integral(a_n_integral, -T/2, T/2);
b(i+1) = (2/T)*integral(b_n_integral, -T/2, T/2);
end
%% 4
f_t = zeros(size(t));
for n = 0:iteration
f_t = f_t + a(n+1) * cos(2*pi*n*t/T) + b(n+1) * sin(2*pi*n*t/T);
end
%% 5
reconstructed_signal = fourier_exp(s(t),t, T, iteration);
%% 6
figure;
% Plot the original signal
subplot(3, 1, 1);
plot(t, s(t));
title('Original Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;
% Plot the summation calculated in the fourth step
subplot(3, 1, 2);
plot(t, f_t);
title('Fourier Series Summation');
xlabel('Time');
ylabel('Amplitude');
grid on;
% Plot the reconstructed signal in the fifth step
subplot(3, 1, 3);
plot(t, reconstructed_signal);
title('Reconstructed Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;
%% 7
save(['exp2_group',num2str(group_number),'.mat'],'T','s','a','b')