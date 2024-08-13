% Baca file audio (gantilah 'nama_file_audio.wav' dengan nama file audio yang sesuai)
[audio, fs] = audioread('Audio 3 - Police radio.mp3');

% Input jumlah orde filter Rekrusif
order = input('Masukkan jumlah orde filter Rekrusif: ');

% Parameter filter IIR
a = zeros(1, order);
for i = 1:order
    a(i) = input(['Masukkan koefisien rekursif a' num2str(i) ': ']);
end

% Inisialisasi output dan state variables
y = zeros(size(audio));
y_prev = zeros(1, order);

% Implementasi filter IIR
for n = 1:length(audio)
    y(n) = audio(n);
    for i = 1:order
        if n > i
            y(n) = y(n) - a(i) * y_prev(i);
        end
    end
    % Update state variables
    y_prev(2:end) = y_prev(1:end-1);
    y_prev(1) = y(n);
end

% Simpan audio hasil filter IIR ke file (gantilah 'hasil_filter.wav' dengan nama file yang sesuai)
output_filename = 'hasil_filter.wav';
audiowrite(output_filename, y, fs);

% Mainkan audio hasil filter IIR
sound(y, fs);

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
plot(y);
title('Audio Output');
xlabel('Sampel');
ylabel('Amplitudo');

% Tampilkan plot
