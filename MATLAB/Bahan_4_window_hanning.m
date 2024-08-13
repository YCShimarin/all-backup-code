% Parameter jendela Hanning
N = 61; % Panjang jendela
w = hann(N); % Menghasilkan jendela Hanning

% Sinyal Waktu h[n]
figure;
plot(0:N-1, w);
title('Sinyal Waktu h[n] dari Jendela Hanning');
xlabel('n');
ylabel('Amplitudo');

% Respon Frekuensi H(w)
figure;
freqz(w, 1, 1024); % Menggunakan freqz untuk menghitung dan menampilkan respon frekuensi
title('Respon Frekuensi H(w) dari Jendela Hanning');


