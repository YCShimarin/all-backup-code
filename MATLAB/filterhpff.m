% Definisikan parameter
fs = 1000; % Frekuensi sampling (Hz)
t = 0:1/fs:1; % Vektor waktu dari 0 hingga 1 detik dengan langkah 1/fs

% Buat sinyal sinusoidal dengan frekuensi 2 Hz
sinyal = sin(2*pi*2*t).*sin(2*pi*60*t).*sin(2*pi*60*t) + cos(2*pi*20*t) + sin(2*pi*12*t) + sin(2*pi*2*t);

% Definisikan parameter filter
f_low_stop = 10; % Frekuensi cut-off rendah untuk filter bandstop (Hz)
f_high_stop = 50; % Frekuensi cut-off tinggi untuk filter bandstop (Hz)
order_stop = 150; % Orde filter

% Desain filter bandstop
filter_bandstop = designfilt('bandstopfir', 'FilterOrder', order_stop, 'CutoffFrequency1', f_low_stop, 'CutoffFrequency2', f_high_stop, 'SampleRate', fs);

% Aplikasikan filter pada sinyal
sinyal_terfilter_bs = filter(filter_bandstop, sinyal);

% Plot sinyal asli dan sinyal terfilter
figure;
subplot(3,1,1);
plot(t, sinyal);
title('Sinyal Asli');
xlabel('Waktu (detik)');
grid on;

subplot(3,1,2);
plot(t, sinyal_terfilter_bs);
title('Sinyal Terfilter (Bandstop 10-50 Hz)');
xlabel('Waktu (detik)');
grid on;

% Plot frequency response magnitude of the bandstop filter in dB
subplot(3,1,3);
[h, f] = freqz(filter_bandstop, 1024, fs);
plot(f, 20*log10(abs(h)), 'LineWidth', 1.5);
title('Frequency Response Amplitude (dB) Bandstop Filter');
xlabel('Frekuensi (Hz)');
ylabel('Amplitude (dB)');
grid on;
