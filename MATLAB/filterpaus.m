% Parameters
fs = 44100;               % Sampling frequency in Hz
f_cutoff = 60;            % Cutoff frequency in Hz
max_display_frequency = 500;  % Maximum frequency to display in the spectrum plot

% Read the MP3 file
[input_signal_stereo, fs_original] = audioread('suarapaushhh.mp3');

% Extract left and right channels
leftChannel = input_signal_stereo(:, 1);
rightChannel = input_signal_stereo(:, 2);
input_signal = (leftChannel + rightChannel) / 2;

% If the original sampling rate is different, resample the input signal
if fs_original ~= fs
    input_signal = resample(input_signal, fs, fs_original);
end

% Design a first-order low-pass Butterworth filter
order = 2;
[b, a] = butter(order, f_cutoff/(fs/2), 'low');

% Apply the filter to the signal using a custom function (renamed to myFilter)
filtered_signal = filter(b, a, input_signal);

% Plot the original and filtered signals
t = (0:length(input_signal)-1) / fs;
figure;

subplot(3,1,1);
plot(t, input_signal);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(t, filtered_signal);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Compute and plot the frequency spectrum (non-dB) using FFT
nfft = length(input_signal);
frequencies = (0:nfft-1) * fs / nfft;
subplot(3,1,3);
original_spectrum = abs(fft(input_signal, nfft));
filtered_spectrum = abs(fft(filtered_signal, nfft));

% Limit the spectrum view to frequencies up to 500 Hz
idx_limit = frequencies <= max_display_frequency;

plot(frequencies(idx_limit), original_spectrum(idx_limit), 'b', 'LineWidth', 1.5);
hold on;
plot(frequencies(idx_limit), filtered_spectrum(idx_limit), 'r', 'LineWidth', 1.5);
hold off;
title('Frequency Spectrum');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
legend('Original Signal', 'Filtered Signal');

% Plot the frequency response of the filter in rad/s
figure;
freqz(b, a, 'half', 1024, fs);
title('Frequency Response of Low-Pass Butterworth Filter');
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');

% Display the transfer function coefficients
disp('Numerator coefficients (B):');
disp(b);
disp('Denominator coefficients (A):');
disp(a);

% Compute and display the transfer function
sys = tf(b, a, 1/fs);
disp('Transfer Function:');
disp(sys);

% Mencari respons impuls
[impulse_response ,t] = impulse(sys);

% Plot respons impuls
figure;
plot(t, impulse_response);
title('Impulse Response');
xlabel('Time (s)');
ylabel('Amplitude');