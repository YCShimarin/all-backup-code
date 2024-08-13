% Baca file audio (gantilah 'nama_file_audio.wav' dengan nama file audio yang sesuai)
[audio, fs] = audioread('Audio 3 - Police radio.mp3');

% Setel parameter efek reverb
delay_sec = 0.5; % Waktu delay (dalam detik)
feedback = 0.5; % Tingkat umpan balik

% Hitung jumlah sampel delay
delay_samples = round(delay_sec * fs);

% Inisialisasi vektor output
output = zeros(size(audio));

% Implementasi efek reverb
for n = 1:length(audio)
    if n <= delay_samples
        output(n) = audio(n);
    else
        output(n) = audio(n) + feedback * output(n - delay_samples);
    end
end

% Normalisasi hasil untuk menghindari clipping
output = output / max(abs(output));

% Tampilkan hasil
sound(output, fs);

% Simpan audio dengan efek reverb ke file (gantilah 'audio_dengan_reverb.wav' dengan nama file yang sesuai)
output_filename = 'audio_dengan_reverb.wav';
audiowrite(output_filename, output, fs);

% Tampilkan pesan bahwa audio telah disimpan
disp(['Audio dengan efek reverb disimpan sebagai: ', output_filename]);
