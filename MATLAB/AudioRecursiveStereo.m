
% Baca file audio stereo (gantilah 'nama_file_audio.wav' dengan nama file audio yang sesuai)
[audio, fs] = audioread('five_audio.mp3');

% Input jumlah orde filter Rekrusif
order = input('Masukkan jumlah orde filter Rekrusif: ');

% Parameter filter IIR
a = zeros(1, order);
for i = 1:order
    a(i) = input(['Masukkan koefisien rekursif a' num2str(i) ': ']);
end

tic

% Ekstrak saluran kiri (left channel)
left_channel = audio(:, 1);

% Ekstrak saluran kanan (right channel)
right_channel = audio(:, 2);

% Inisialisasi output dan state variables untuk setiap saluran
y_left = zeros(size(left_channel));
y_right = zeros(size(right_channel));
y_prev_left = zeros(1, order);
y_prev_right = zeros(1, order);


% Implementasi filter IIR untuk saluran kiri
for n = 1:length(left_channel)
    y_left(n) = left_channel(n);
    for i = 1:order
        if n > i
            y_left(n) = y_left(n) - a(i) * y_prev_left(i);
        end
    end
    % Update state variables
    y_prev_left(2:end) = y_prev_left(1:end-1);
    y_prev_left(1) = y_left(n);
end

% Implementasi filter IIR untuk saluran kanan
for n = 1:length(right_channel)
    y_right(n) = right_channel(n);
    for i = 1:order
        if n > i
            y_right(n) = y_right(n) - a(i) * y_prev_right(i);
        end
    end
    % Update state variables
    y_prev_right(2:end) = y_prev_right(1:end-1);
    y_prev_right(1) = y_right(n);
end

% Gabungkan saluran yang telah di-filter kembali menjadi audio stereo
output_audio = [y_left, y_right];

% Simpan audio hasil filter IIR ke file (gantilah 'hasil_filter.wav' dengan nama file yang sesuai)
output_filename = 'hasil_filter.wav';
audiowrite(output_filename, output_audio, fs);

% Mainkan audio hasil filter IIR
sound(output_audio, fs);

N = length(audio);
signalPower = sum(audio.^2) / N;
noisePower = sum((output_audio - audio).^2) / N;

snr = 10*log(signalPower/noisePower);
strsnr = sprintf('Besar SnR : %d',snr);
disp(strsnr);

xbar_amplitudo = sum(output_audio - audio)/length(audio);
xbar_str1 = sprintf('rata-rata perubahan amplitudo ch kiri : %d',xbar_amplitudo(1));
xbar_str2 = sprintf('rata-rata perubahan amplitudo ch kanan: %d',xbar_amplitudo(2));


disp(xbar_str1);
disp(xbar_str2);

% Tampilkan pesan bahwa audio telah disimpan
disp(['Audio hasil filter IIR disimpan sebagai: ', output_filename]);

% Plot audio input
subplot(2, 1, 1);
plot(audio);
title('Audio Input');
xlabel('Sampel');
ylabel('Amplitudo');

% Plot audio output
subplot(2, 1, 2);
plot(output_audio);
title('Audio Output');
xlabel('Sampel');
ylabel('Amplitudo');

toc

