% Define the input signal
fs = 1000;  % Sampling frequency (Hz)
t = 0:1/fs:1;  % Time vector from 0 to 1 second
x = cos(2*pi*50*t) + cos(2*pi*150*t);  % A signal with 50Hz and 150Hz components

% Design the FIR filter
order = 50;  % Filter order
fc = 80;  % Cutoff frequency (Hz)

b = fir1(order, fc / (fs/2));  % Design the filter coefficients

% Apply the FIR filter to the input signal
y = filter(b, 1, x);

% Plot the original and filtered signals
figure;
subplot(2, 1, 1);
plot(t, x);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(t, y);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Frequency response of the FIR filter
figure;
freqz(b, 1, 1024, fs);
title('Frequency Response of FIR Filter');

