close all
clear
clc

% Input parameter
Ap = 0.5;    % Ripple pada bandstop dalam dB
Ar = 46;     % Penurunan pada bandpass dalam dB
Wp = 0.4;    % Frekuensi cut-off pada lowpass
Wr = 0.8;    % Frekuensi batas pada bandstop
N = 200;     % panjang window

Wc = (Wp + Wr) / 2;

% Window Function
w = blackman(N); 

% Ideal Filter
m = (N-1)/2;
nn = 0:2*m+10;
h_n = Wc/pi * sinc(Wc/pi * (nn-m)); 

% Convolution Window and Ideal FIlter
yy_n = conv(h_n, w);

% Generate a signal 
t = 0:0.001:10;
xx_n = sin(10*t)+cos(20*t)+sin(150*t);

% Build a Filter
filtered_signal = filter(yy_n,1,xx_n);

% ========================================= Fungsi Window w[n]
figure;
plot(0:N-1, w,'LineWidth', 2);
title('Sinyal Waktu h[n] dari Jendela Blackman');
xlabel('waktu');
ylabel('Amplitudo');

% Respon Frekuensi H(w)
figure;
freqz(w, 1, 1024); % Menggunakan freqz untuk menghitung dan menampilkan respon frekuensi
title('Respon Frekuensi H(w) dari Jendela Blackman');

% =========================================== Filter Ideal
% Plot fungsi domain waktu
figure;
plot((nn-m), h_n, 'LineWidth', 2);
title('response Impulse h[n]');
xlabel('waktu');
ylabel('h[n]');
grid on;

% Respon Frekuensi H(w)
figure;
freqz(h_n, 1, 1024); % Menggunakan freqz untuk menghitung dan menampilkan respon frekuensi
title('Respon Frekuensi H(w)');

% ========================================= Konvolusi 

% Plot hasil convolution
figure;
plot(yy_n, 'LineWidth', 2);
title('Convolution Result');
xlabel('waktu');
ylabel('Amplitude');
grid on;

% Respon Frekuensi H(w)
figure;
freqz(yy_n, 1, 1024); % Menggunakan freqz untuk menghitung dan menampilkan respon frekuensi
title('Respon Frekuensi H(w)');
% ========================================= Sinyal Original dan terfilter

figure;

subplot(2,1,1);
plot(t,xx_n,'LineWidth', 2);
title('Original signal');
xlabel('waktu');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, filtered_signal,'LineWidth', 2);
title('filtered signal');
xlabel('waktu');
ylabel('Amplitude');
grid on;

