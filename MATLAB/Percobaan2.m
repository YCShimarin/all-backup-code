%TODO
%Data yang diperlukan
%====================================
[input_audio, fs] = audioread('Audio_anda.wav');

if size(input_audio, 2) == 2
    % If stereo audio, separate left and right channels
    left_channel = input_audio(:, 1);
    right_channel = input_audio(:, 2);

    % Konversi menjadi saluran mono
    audio = (left_channel + right_channel) / 2;

else
    % If mono audio, use the single channel
    audio = input_audio;
end

a = 0.95;
i= 1 ;

%==================================================
%1. Buat filter audio dengan algoritma rekursif
%==================================================

yn = zeros(size(audio));
yn_prev = [];

for n = 1:length(audio)
    yn(n) = audio(n);
    if n > i
        yn(n) = yn(n) + a(i) * yn_prev(i);
    end
    % Update state variables
    yn_prev(2:end) = yn_prev(1:end-1);
    yn_prev(1) = yn(n);
end
figure;
subplot(2,1,1)
plot(audio)
xlabel('Sample')
ylabel('Amplitudo')
title('Input Audio')

subplot(2,1,2)
plot(yn)
xlabel('Sample')
ylabel('Amplitudo')
title('Output Rekursif Filter')

%==================================================
%2. Temukan Response Impulse filter
%==================================================

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
figure;
subplot(3,1,1)
plot(audio)
xlabel('Sample')
ylabel('Amplitudo')
title('Input Audio')

subplot(3,1,2)
plot(y)
xlabel('Sample')
ylabel('Amplitudo')
title('Response Impulse Filter')

%==================================================
%3. Buat filter dengan input audio menggunakan konvolusi dengan response
%impulse
%==================================================

output_conv = conv(audio,y,"same");
subplot(3,1,3)
plot(output_conv)
xlabel('Sample')
ylabel('Amplitudo')
title('Output Konvolusi Filter')

%==================================================
%4. Hitung SNR dari poin 1 dan 3
%==================================================

N = length(audio);
signalPower = sum(audio.^2) / N;
noisePowerRecursive = sum((yn - audio).^2) / N;
noisePowerConvolution = sum((output_conv - audio).^2) / N;

audio_db = 10*log(signalPower);
snr_recursive = 10*log(signalPower/noisePowerRecursive);
snr_convolution = 10*log(signalPower/noisePowerConvolution);

fprintf('Nilai daya audio (dB) : %.2f\n', audio_db);
fprintf('Nilai SNR Recursive (dB) : %.2f\n', snr_recursive);
fprintf('Nilai SNR Convolution (dB) : %.2f\n', snr_convolution);

%==================================================
%5. Bandingkan hasil filter algoritma rekrusif dan konvolusi
%==================================================

audiowrite("audio_hasil_rekursif.wav", yn, fs);
audiowrite("audio_hasil_konvolusi.wav", output_conv, fs);

audio_fft = fft(audio);
rec_fft = fft(yn);
conv_fft = fft(output_conv);

% Hitung magnitudo spektrum frekuensi
audio_magnitude = abs(audio_fft);
rec_magnitude = abs(rec_fft);
conv_magnitude = abs(conv_fft);



% Hitung sumbu frekuensi
f = (0:N-1) * fs / N;

% Plot spektrum frekuensi dalam amplitudo
figure;
subplot(3,1,1)
plot(f, audio_amplitude);
xlabel('Frekuensi (Hz)');
ylabel('Amplitudo');
title('Spektrum Frekuensi Audio (Amplitudo)');
grid on;

subplot(3,1,2)
plot(f, rec_amplitude);
xlabel('Frekuensi (Hz)');
ylabel('Amplitudo');
title('Spektrum Frekuensi Audio rekursif (Amplitudo)');
grid on;

subplot(3,1,3)
plot(f, conv_amplitude);
xlabel('Frekuensi (Hz)');
ylabel('Amplitudo');
title('Spektrum Frekuensi Audio konvolusi (Amplitudo)');
grid on;
