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



% Notch filter
a1 = 1.37624044;  % nilai a
a2 = -0.44587111; % nilai a
b0 = 0.73401885;  % nilai b
b1 = -1.37624044; % nilai b
b2 = 0.71185226;  % nilai b

yy_filtered_notch = zeros(size(signal));
yy_filtered_notch(1) = b0 * signal(1);
yy_filtered_notch(2) = b0 * signal(2) + b1 * signal(1) + a1 * yy_filtered_notch(1);
for ii = 3:length(signal)
    yy_filtered_notch(ii) = a1 * yy_filtered_notch(ii - 1) + a2 * yy_filtered_notch(ii - 2) + b0 * signal(ii) + b1 * signal(ii - 1) + b2 * signal(ii - 2);
end

% Plot the notch-filtered signal
figure;
plot(t, yy_filtered_notch);
xlabel('time');
ylabel('amplitude');
title('IIR Filtered Signal');

%Recursive Filter
q0 = 0.76;
r1 = 0.734424385; % nilai r
r2 = 0.251131313; % nilai r

RR_filtered = zeros(size(signal));
RR_filtered(1) = signal(1)*q0;
RR_filtered(2) = signal(2)*q0 + r1*RR_filtered(1);

for ii = 3:length(signal)
    RR_filtered(ii) = signal(ii)*q0 + r1*RR_filtered(ii-1) + r2*RR_filtered(ii-2);
end

% Plot the notch-filtered signal
figure;
plot(t, RR_filtered);
xlabel('time');
ylabel('amplitude');
title('Recursive Filtered Signal');

%Konvolusi
g = 1;  %nilai g
n = 40;
h = zeros(1, n);
h(1:2) = [r1,r2];

y = zeros(1, n);

y(1) = h(1);
for i = 2:n
    y(i) = h(i) + g * y(i - 1);
end
convole = conv(signal,y,"same");

figure;
plot(y)
xlabel("time (n)")
ylabel("Amplitude")
title("Response Impulse")

figure;
plot(t, convole);
xlabel('time');
ylabel('amplitude');
title('Convolution Filtered Signal');