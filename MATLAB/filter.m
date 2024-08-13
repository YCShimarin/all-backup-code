close all

% Define parameters
N = 1000;
dt = 1.0 / N;
t = 0:dt:1.0;

% Compute the original signal
f1 = 2.0;
f2 = 50.0;
A1 = 1.0;
A2 = 0.2;

signal = A1 * sin(2 * pi * f1 * t) + A2 * sin(2 * pi * f2 * t);

% Plot the original signal
figure;
plot(t, signal);
xlabel('time');
ylabel('amplitude');
title('Original Signal');

% Low-pass filter
a1 = 0.96906992;
b0 = 0.01546504;
b1 = 0.01546504;
yy_filtered = zeros(size(signal));
yy_filtered(1) = b0*signal(1);
yy_filtered(2) = b0*signal(2) + b1*signal(1);
for ii = 3:length(signal)
    yy_filtered(ii) = a1 * yy_filtered(ii - 1) + b0 * signal(ii) + b1 * signal(ii - 1);
end

disp(yy_filtered(1:5))
% Plot the filtered signal
figure;
plot(t, yy_filtered);
xlabel('time');
ylabel('amplitude');
title('lpf Filtered Signal');

% Notch filter
a1 = 1.37624044;
a2 = -0.44587111;
b0 = 0.73401885;
b1 = -1.37624044;
b2 = 0.71185226;

yy_filtered_notch = zeros(size(signal));
yy_filtered_notch(1) = b0 * signal(ii);
yy_filtered_notch(2) = b0 * signal(2) + b1 * signal(1) + a1 * yy_filtered_notch(1);
for ii = 3:length(signal)
    yy_filtered_notch(ii) = a1 * yy_filtered_notch(ii - 1) + a2 * yy_filtered_notch(ii - 2) + b0 * signal(ii) + b1 * signal(ii - 1) + b2 * signal(ii - 2);
end

% Plot the notch-filtered signal
figure;
plot(t, yy_filtered_notch);
xlabel('time');
ylabel('amplitude');
title('Notch Filtered Signal');

%Recursive Filter
q0 = 1;
r1 = 0.734424385;
r2 = 0.251131313;

RR_filtered = zeros(size(signal));
RR_filtered(1) = signal(ii)*q0;
RR_filtered(2) = signal(ii)*q0 + r1*RR_filtered(ii-1);

for ii = 3:length(signal)
    RR_filtered(ii) = signal(ii)*q0 + r1*RR_filtered(ii-1) + r2*RR_filtered(ii-2);
end

% Plot the notch-filtered signal
figure;
plot(t, RR_filtered);
xlabel('time');
ylabel('amplitude');
title('Recursive Filtered Signal');

%Butterworth LPF 

% Design a low-pass filter
lowpass_cutoff_frequency = 2; % Adjust this value for your desired cutoff frequency
p1 = 2*3.1415*lowpass_cutoff_frequency;
c1 = 0.078; % Adjust as needed

yyy_lpf(1) = signal(1);

for ii = 2:length(signal)
    yyy_lpf(ii) = c1 * (signal(ii) + p1 * yyy_lpf(ii-1)) + signal(ii);
end

% Plot the low-pass filtered signal
figure;
plot(t, yyy_lpf);
xlabel('time');
ylabel('amplitude');
title('Butterworth Filtered Signal');

%FIR 
v1 = 0.421213;
v2 = 0.132312;
v3 = 0.01233;
yyy_fir(1) = signal(1);
yyy_fir(2) = v1*signal(1) + v2*yyy_fir(1);

for ii = 3:length(signal)
    yyy_fir(ii) = v3*yyy_fir(ii-1) +  yyy_fir(ii-2);
end

figure;
plot(t,yyy_fir)

%Konvolusi
h = [1 ,2 ,1,2,3,2,6];
n = 100;
h = zeros(1, n);
h(1) = 1;
y = zeros(1, n);

for i = 1:n
    if i == 1
        y(i) = h(i);
    else
        y(i) = h(i) + a * y(i - 1);
    end
end
convole = conv(signal,h);

figure;
plot(convole);
