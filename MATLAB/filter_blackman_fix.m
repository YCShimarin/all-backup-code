% Input parameter
Ap = 0.5;    % Ripple pada bandstop dalam dB
Ar = 50;     % Penurunan pada bandpass dalam dB
Wp = 0.6;    % Frekuensi cut-off pada lowpass
Wr = 0.8;    % Frekuensi batas pada bandstop
N = 100;     % Orde filter

% Frekuensi cut-off
Wc = (Wp + Wr) / 2;

% Desain filter LPF dengan metode rectangular
b_rectangular = fir1(N, Wc, 'low', rectwin(N+1));

% Hitung respons frekuensi filter rectangular
[H_rectangular, F_rectangular] = freqz(b_rectangular, 1, 1024);

% Buat sinyal input
t = 0:0.01:1;
x = sin(2*pi*7*t) + 0.5*sin(2*pi*30*t);

% Filterkan sinyal input dengan filter rectangular
y_rectangular = filter(b_rectangular, 1, x);

% Gambar respon frekuensi filter rectangular dalam dB
figure;
subplot(2,2,1);
plot(F_rectangular, 20*log10(abs(H_rectangular)));
title('Gain Filter Rectangular (dB)');
xlabel('Frekuensi (Hz)');
ylabel('Gain (dB)');
grid on;

% Gambar respon impuls filter rectangular
subplot(2,2,2);
impz(b_rectangular);
title('Respon Impuls Filter Rectangular');
grid on;

% Gambar sinyal input
subplot(2,2,3);
plot(t, x);
title('Sinyal Input');
xlabel('Waktu (s)');
ylabel('Amplitudo');
grid on;

% Gambar sinyal output setelah filter rectangular
subplot(2,2,4);
plot(t, y_rectangular);
title('Sinyal Output Rectangular');
xlabel('Waktu (s)');
ylabel('Amplitudo');
grid on;
