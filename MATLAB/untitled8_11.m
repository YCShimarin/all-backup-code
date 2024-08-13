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

% Design a low-pass filter
lowpass_cutoff_frequency = 2; % Adjust this value for your desired cutoff frequency
p1 = 2*3.1415*lowpass_cutoff_frequency;
c1 = 0.075; % Adjust as needed

yyy_lpf(1) = signal(1);

for ii = 2:length(signal)
    yyy_lpf(ii) = c1 * (signal(ii) + p1 * yyy_lpf(ii-1)) + signal(ii);
end

% Plot the low-pass filtered signal
figure;
plot(t, yyy_lpf);
xlabel('time');
ylabel('amplitude');
title('LPF Filtered Signal');
