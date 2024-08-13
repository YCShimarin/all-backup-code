close all
% Parameter filter
fc = 0.0717; % frekuensi cut-off relatif terhadap Nyquist frequency

% Membuat filter ideal LPF di domain frekuensi
wc = 2 * pi * fc; % frekuensi cut-off

% Membuat filter ideal LPF di domain waktu
N = 60; % Panjang filter (jumlah sampel)
m = (N-1)/2;
nn = 0:2*m+10;
%n = -(N-1)/2 : (N-1)/2; % Rentang indeks
h_n = wc/pi * sinc(wc/pi * (nn-m)); % Fungsi sinc sebagai filter ideal LPF di domain waktu

% Convolution with Blackman window
yy_n = conv(h_n, rectwin(N));

% Plot hasil convolution
figure;
plot(yy_n, 'LineWidth', 2);
title('Convolution Result');
xlabel('n');
ylabel('Amplitude');
grid on;

% Respon Frekuensi H(w)
figure;
freqz(yy_n, 1, 1024); % Menggunakan freqz untuk menghitung dan menampilkan respon frekuensi
title('Respon Frekuensi H(w)');

t = 0:0.1:N;
xx_n = 1+cos(2*t)+cos(10*t);

filtered_signal = filter(yy_n,1,xx_n);
% Plot hasil convolution
figure;

subplot(2,1,1);
plot(t,xx_n,'LineWidth', 2);
title('Original signal');
xlabel('n');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, filtered_signal,'LineWidth', 2);
title('filtered signal');
xlabel('n');
ylabel('Amplitude');
grid on;
