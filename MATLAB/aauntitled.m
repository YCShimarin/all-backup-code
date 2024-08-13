%Butterworth LPF 
signal = [1,3,2,4,3,5,4,6,5,7,6,8]
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
subplot(2,1,1)
stem(signal)
subplot(2,1,2)
stem(yyy_lpf);
xlabel('time');
ylabel('amplitude');
title('Filtered Signal');
