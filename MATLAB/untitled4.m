
%%%----------------------------------------------------------------------------------------
%%% RECURSIVE STEREO AUDIO
%%%----------------------------------------------------------------------------------------

% Baca file audio stereo (gantilah 'nama_file_audio.wav' dengan nama file audio yang sesuai)
[audio, fs] = audioread('Audio 3 - Police radio.mp3');

order = 3;
a = [0.4,0.6,0.8];
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



%%%----------------------------------------------------------------------------------------
%%% RECURSIVE STEREO AUDIO END
%%%----------------------------------------------------------------------------------------
%%%----------------------------------------------------------------------------------------
%%% IMPULSE RESPONSE STEREO AUDIO
%%%----------------------------------------------------------------------------------------

% Koefisien sistem (contoh)
num = [1]; % Koefisien pembilang

% Membuat sistem dari koefisien
left_sys = tf(num, left_channel); % output / input
right_sys = tf(num,right_channel);
% Menghasilkan respons impuls
t_impulse = 0:ts:1; % Rentang waktu respons impuls
impulse_response_L = impulse(left_sys, t_impulse)
impulse_response_R = impulse(right_sys, t_impulse); %Konvert ke domain waktu
output_audio_imp = [impulse_response_L, impulse_response_R];


% Plot audio input
subplot(3, 1, 1);
plot(audio);
title('Audio Input');
xlabel('Sampel');
ylabel('Amplitudo');

% Plot audio output
subplot(3, 1, 2);
plot(output_audio);
title('Audio Output');
xlabel('Sampel');
ylabel('Amplitudo');

% Plot audio output
subplot(3, 1, 3);
plot(output_audio_imp);
title('Audio Output');
xlabel('Sampel');
ylabel('Amplitudo');


toc

