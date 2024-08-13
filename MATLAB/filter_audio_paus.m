% Parameter
fs = 44100;               % Frekuensi sampling dalam Hz
f_cutoff = 40;            % Frekuensi cutoff dalam Hz
max_display_frequency = 500;  % Frekuensi maksimum yang ditampilkan dalam plot spektrum

% Baca file MP3
[input_signal_stereo, fs_original] = audioread('suarapaushhh.mp3');

% Ekstrak saluran kiri dan kanan
leftChannel = input_signal_stereo(:, 1);
rightChannel = input_signal_stereo(:, 2);
input_signal = (leftChannel + rightChannel) / 2;

% Jika frekuensi sampling asli berbeda, resample sinyal input
if fs_original ~= fs
    input_signal = resample(input_signal, fs, fs_original);
end

% Desain filter Butterworth low-pass orde pertama
order = 2;
[b, a] = butter(order, f_cutoff/(fs/2), 'low');

% Terapkan filter pada sinyal menggunakan fungsi kustom (diubah namanya menjadi myFilter)
filtered_signal = filter(b, a, input_signal);

% Plot sinyal asli dan sinyal yang difilter
t = (0:length(input_signal)-1) / fs;
figure;

% Plot sinyal asli
subplot(3,1,1);
plot(t, input_signal);
title('Sinyal Asli');
xlabel('Waktu (s)');
ylabel('Amplitudo');

% Plot sinyal yang difilter
subplot(3,1,2);
plot(t, filtered_signal);
title('Sinyal yang Difilter');
xlabel('Waktu (s)');
ylabel('Amplitudo');

% Hitung dan plot spektrum frekuensi (non-dB) menggunakan FFT
nfft = length(input_signal);
frequencies = (0:nfft-1) * fs / nfft;
subplot(3,1,3);
original_spectrum = abs(fft(input_signal, nfft));
filtered_spectrum = abs(fft(filtered_signal, nfft));

% Batasi tampilan spektrum hingga frekuensi 500 Hz
idx_limit = frequencies <= max_display_frequency;

plot(frequencies(idx_limit), original_spectrum(idx_limit), 'b', 'LineWidth', 1.5);
hold on;
plot(frequencies(idx_limit), filtered_spectrum(idx_limit), 'r', 'LineWidth', 1.5);
hold off;
title('Spektrum Frekuensi');
xlabel('Frekuensi (Hz)');
ylabel('Amplitudo');
legend('Sinyal Asli', 'Sinyal yang Difilter');

% Plot respons frekuensi filter dalam rad/s
figure;
freqz(b, a, 'half', 1024, fs);
title('Respon Frekuensi Filter Low-Pass Butterworth');
% Tampilkan koefisien fungsi transfer
disp('Koefisien Numerator (B):');
disp(b);
disp('Koefisien Denominator (A):');
disp(a);

% Hitung dan tampilkan fungsi transfer
sys = tf(b, a, 1/fs);
disp('Fungsi Transfer:');
disp(sys);

% Mencari respons impuls
[impulse_response, t] = impulse(sys);

% Plot respons impuls
figure;
plot(t, impulse_response);
title('Respons Impuls');
xlabel('Waktu (s)');
ylabel('Amplitudo');

audiowrite('suarapaushhh_filtered.wav', filtered_signal, fs);

