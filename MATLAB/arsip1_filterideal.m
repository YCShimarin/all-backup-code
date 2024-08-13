% Parameter filter
fc = 0.2; % frekuensi cut-off relatif terhadap Nyquist frequency

% Membuat filter ideal LPF di domain frekuensi
wc = 2 * pi * fc; % frekuensi cut-off
H_w = @(w) (abs(w) <= wc) * 1; % Filter ideal LPF di domain frekuensi

% Plot respons frekuensi
w = linspace(0, 2*pi, 1000);
figure;
subplot(2,1,1);
plot(w, arrayfun(H_w, w));
title('Respon Frekuensi H(w)');
xlabel('Frekuensi (\omega)');
ylabel('|H(w)|');
grid on;

% Membuat filter ideal LPF di domain waktu
N = 51; % Panjang filter (jumlah sampel)
n = -(N-1)/2 : (N-1)/2; % Rentang indeks
h_n = wc/pi * sinc(wc/pi * n); % Fungsi sinc sebagai filter ideal LPF di domain waktu

% Plot fungsi domain waktu
subplot(2,1,2);
stem(n, h_n);
title('Fungsi Domain Waktu h[n]');
xlabel('n');
ylabel('h[n]');
grid on;
