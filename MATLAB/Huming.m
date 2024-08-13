% Parameters
N = 100;
fs = 1000;
cutoff_frequency = 100;

% Generate Hamming window
hamming_window = create_hamming_window(N);

% Plot Hamming window and ideal low-pass filter
plot_window_and_ideal_filter(hamming_window, cutoff_frequency, fs);

% Create Low Pass Filter using Hamming window
lpf = create_lpf(hamming_window, cutoff_frequency, fs);

% Plot Hamming window frequency response
plot_frequency_response(hamming_window, fs);

% Plot LPF frequency response
plot_frequency_response(lpf, fs);

% Plot Impulse Response of the LPF
plot_impulse_response(lpf);

% Generate a sine signal with component frequencies 2 Hz, 6 Hz, 20 Hz, and 60 Hz
t = 0:1/fs:1; % Time vector
sine_signal = sin(2*pi*2* t) + sin(2*pi*6* t) + sin(2*pi*20* t) + sin(2*pi*60 * t);

% Filter the sine signal with the low-pass filter
filtered_signal = filter(lpf, 1, sine_signal);

% Plot the original and filtered signals
figure;
subplot(2, 1, 1);
plot(t, sine_signal);
title('Original Sine Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(t, filtered_signal);
title('Filtered Sine Signal');
xlabel('Time (s)');
ylabel('Amplitude');

function hamming_window = create_hamming_window(N)
    hamming_window = hamming(N);
end

function plot_window_and_ideal_filter(window, cutoff_frequency, fs)
    ideal_lpf_response = ones(size(window));
    ideal_lpf_response(round(cutoff_frequency * length(window) / fs)+1:end) = 0;

    conv_result = conv(window, ideal_lpf_response, 'same');

    figure;
    subplot(3, 1, 1);
    plot(window);
    title('Hamming Window');
    xlabel('Sample');
    ylabel('Amplitude');

    subplot(3, 1, 2);
    plot(ideal_lpf_response);
    title('Ideal Low-Pass Filter Response');
    xlabel('Sample');
    ylabel('Amplitude');

    subplot(3, 1, 3);
    plot(conv_result);
    title('Convolution (Window * Ideal Filter)');
    xlabel('Sample');
    ylabel('Amplitude');
end

function plot_frequency_response(window, fs)
    freq_response = fft(window, 2048);
    freq_response_mag = abs(freq_response(1:length(freq_response)/2));
    freq_response_mag_db = 20 * log10(freq_response_mag / max(freq_response_mag));
    freq_axis = linspace(0, fs/2, length(freq_response_mag_db));

    figure;
    plot(freq_axis, freq_response_mag_db);
    title('Frequency Response');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    grid on;
end

function lpf = create_lpf(hamming_window, cutoff_frequency, fs)
    ideal_lpf_response = ones(size(hamming_window));
    ideal_lpf_response(round(cutoff_frequency * length(hamming_window) / fs)+1:end) = 0;

    lpf = conv(hamming_window, ideal_lpf_response, 'same');
    lpf = lpf / sum(lpf);
end

function plot_impulse_response(filter_response)
    impulse_response = filter(filter_response, 1, [1 zeros(1, length(filter_response)-1)]);
    figure;
    stem(impulse_response);
    title('Impulse Response');
    xlabel('Sample');
    ylabel('Amplitude');
end
