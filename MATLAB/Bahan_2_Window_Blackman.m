% Blackman Window
% Panjang Blackman window
N = 61;

% Membuat Blackman window
w = blackman(N);

% Menggambar Blackman window di domain waktu
figure;
plot(0:N-1, w);
title('Blackman Window (h[n])');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

% Respon Frekuensi H(w)
figure;
freqz(w, 1, 1024); % Menggunakan freqz untuk menghitung dan menampilkan respon frekuensi
title('Respon Frekuensi H(w) dari Blackman Window');


% Menghitung respon frekuensi H(w)
%Hw = fft(w, 1024);
%frequencies = linspace(0, pi, 1024);  % Menyesuaikan rentang frekuensi

%{ Menggambar respon frekuensi H(w)
%figure;
%subplot(2, 1, 1);
%plot(frequencies(1:512), 20*log10(abs(Hw(1:512))));  % Menampilkan hanya setengah
%title('Magnitude Response (H(w))');
%xlabel('Frequency (rad)');
%ylabel('Magnitude (dB)');
%grid on;
