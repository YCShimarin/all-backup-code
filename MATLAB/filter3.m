% Spesifikasi filter
Fs = 1000;  % Frekuensi sampling (Hz)
Fp = 50;    % Frekuensi cutoff (Hz) untuk lowpass dan highpass
Fp1 = 50;   % Frekuensi cutoff bawah (Hz) untuk bandpass
Fp2 = 200;  % Frekuensi cutoff atas (Hz) untuk bandpass
Fst1 = 30;  % Frekuensi stopband bawah (Hz) untuk stopband
Fst2 = 220; % Frekuensi stopband atas (Hz) untuk stopband
Rp = 1;     % Ripple dalam passband (dB)
Rs = 60;    % Atenuasi dalam stopband (dB)

% Desain filter
[butter_b_low, butter_a_low] = butter(2, Fp/(Fs/2), 'low');
[butter_b_high, butter_a_high] = butter(2, Fp/(Fs/2), 'high');
[butter_b_band, butter_a_band] = butter(2, [Fp1, Fp2]/(Fs/2), 'bandpass');
[butter_b_stop, butter_a_stop] = butter(2, [Fst1, Fst2]/(Fs/2), 'stop');
[b, a] = butter()

% Frekuensi respons filter
freq = 0:1:500;
H_low = freqz(butter_b_low, butter_a_low, freq, Fs);
H_high = freqz(butter_b_high, butter_a_high, freq, Fs);
H_band = freqz(butter_b_band, butter_a_band, freq, Fs);
H_stop = freqz(butter_b_stop, butter_a_stop, freq, Fs);

% Plot respons frekuensi filter
figure;

subplot(4, 1, 1);
plot(freq, 20*log10(abs(H_low)));
title('Lowpass Filter Response');
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');
grid on;

subplot(4, 1, 2);
plot(freq, 20*log10(abs(H_high)));
title('Highpass Filter Response');
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');
grid on;

subplot(4, 1, 3);
plot(freq, 20*log10(abs(H_band)));
title('Bandpass Filter Response');
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');
grid on;

subplot(4, 1, 4);
plot(freq, 20*log10(abs(H_stop)));
title('Stopband Filter Response');
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');
grid on;
