% Parameter jendela Hamming
N = 61; % Panjang jendela
w = hamming(N); % Menghasilkan jendela Hamming

% Sinyal Waktu h[n]
figure;
plot(0:N-1, w);
title('Sinyal Waktu h[n] dari Jendela Hamming');
xlabel('n');
ylabel('Amplitudo');


% Respon Frekuensi H(w)
figure;
freqz(w, 1, 1024); % Menggunakan freqz untuk menghitung dan menampilkan respon frekuensi
title('Respon Frekuensi H(w) dari Jendela Hamming');


