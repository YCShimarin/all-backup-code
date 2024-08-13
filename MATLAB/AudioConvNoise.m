
% Baca file audio stereo (gantilah 'nama_file_audio.wav' dengan nama file audio yang sesuai)
[audio, fs] = audioread('Audio 3 - Police radio.mp3');

disp("pilih sinyal konvolusi")
disp("-------------------------")
disp("1. Sinyal random")
disp("2. Sinyal step 100")
choise = input("masukkan angka :");
disp("-------------------------")
disp("pilih tegangan sinyal konvolusi")
gain = input("masukkan angka :");
disp("-------------------------")


if choise == 1
    % Buat sinyal noise (misalnya, sinyal putih Gaussian noise)
    duration = size(audio, 1) / fs;
    t = 0:1:100;
    conv_signal = gain * randn(size(t)); % 0.2 adalah faktor penguatan noise
elseif choise == 2
    conv_signal = gain*ones(1,100);
else
    disp("Nomor tidak valid")
end

tic

% Ekstrak saluran kiri (left channel)
left_channel = audio(:, 1);

% Ekstrak saluran kanan (right channel)
right_channel = audio(:, 2);

% Lakukan konvolusi antara saluran kiri audio dan sinyal noise
convolved_left = conv(left_channel, conv_signal,"same");

% Lakukan konvolusi antara saluran kanan audio dan sinyal noise
convolved_right = conv(right_channel, conv_signal,"same");

% Gabungkan saluran yang telah di-konvolusi kembali menjadi audio stereo
convolved_audio = [convolved_left, convolved_right];

% Simpan audio hasil konvolusi ke file (gantilah 'hasil_konvolusi.wav' dengan nama file yang sesuai)
output_filename = 'hasil_konvolusi.wav';
audiowrite(output_filename, convolved_audio, fs);

% Mainkan audio hasil konvolusi
sound(convolved_audio, fs);

N = length(audio);
signalPower = sum(audio.^2) / N;
noisePower = sum((convolved_audio - audio).^2) / N;

snr = 10*log(signalPower/noisePower);
strsnr = sprintf('Besar SnR : %d',snr);
disp(strsnr);

xbar_amplitudo = sum(convolved_audio - audio)/length(audio);
xbar_str1 = sprintf('rata-rata perubahan amplitudo ch kiri : %d',xbar_amplitudo(1));
xbar_str2 = sprintf('rata-rata perubahan amplitudo ch kanan: %d',xbar_amplitudo(2));


disp(xbar_str1);
disp(xbar_str2);
% Tampilkan pesan bahwa audio telah disimpan
disp(['Audio hasil konvolusi disimpan sebagai: ', output_filename]);

% Plot audio input
subplot(3,1,1)
plot(conv_signal)
title('Sinyal Konvolusi');
xlabel('Sampel');
ylabel('Amplitudo');

subplot(3, 1, 2);
plot(audio);
title('Audio Input');
xlabel('Sampel');
ylabel('Amplitudo');

% Plot audio output setelah konvolusi
subplot(3, 1, 3);
plot(convolved_audio);
title('Audio Output setelah Konvolusi');
xlabel('Sampel');
ylabel('Amplitudo');

toc