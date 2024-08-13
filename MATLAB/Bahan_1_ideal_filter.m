% Parameter filter
fc = 2; % frekuensi cut-off relatif terhadap Nyquist frequency

% Membuat filter ideal LPF di domain frekuensi
wc = 2 * pi * fc; % frekuensi cut-off

% Membuat filter ideal LPF di domain waktu
N = 51; % Panjang filter (jumlah sampel)
n = -(N-1) : 0.1 : (N-1); % Rentang indeks
h_n = sinc(wc/pi * n); % Fungsi sinc sebagai filter ideal LPF di domain waktu

% Plot fungsi domain waktu
figure;
plot(n, h_n);
title('Fungsi Domain Waktu h[n]');
xlabel('n');
ylabel('h[n]');
grid on;

% Respon Frekuensi H(w)
figure;
freqz(h_n, 1, 1024); % Menggunakan freqz untuk menghitung dan menampilkan respon frekuensi
title('Respon Frekuensi H(w)');


