
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

%Konvolusi
n = 100;
h = zeros(1, n);
h(1) = 1;
h(2) = 2;
h(3) = 1;
y = zeros(1, n);

for i = 1:n
    if i == 1
        y(i) = h(i);
    else
        y(i) = h(i) + 1 * y(i - 1);
    end
end
convole = conv(signal,y,"same");

figure;
plot(t, convole);
figure;
plot(y)