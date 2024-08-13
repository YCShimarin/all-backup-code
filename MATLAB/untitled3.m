%2010952054 - Jimmy Nelson
%2110952028 - Mutiara Ali
%2110952001 - Muhammad Reval
%2110953005 - Muhammad Zaky Kurnia

% Parameter sinyal sinus 1
a1 = 5; %Nim dari 2010952054 - Jimmy Nelson
f1 = 3; %Nim dari 2110952001 - Muhammad Reval
durasi = 2;

% Parameter sinyal sinus 2
a2 = 2; %Nim dari 2110952028 - Mutiara Ali
f2 = 2; %Nim dari 2110952001 - Muhammad Reval


% Parameter sinyal sinus 3
a3 = 2; %Nim dari 2110953005 - Muhammad Zaky Kurnia
f3 = 5; %Nim dari 2010952054 - Jimmy Nelson

fs = 100;
Ts = 1/fs;

% Waktu Sinyal
t = 0:Ts:durasi;


% Membuat tiga sinyal sinusoidal
sinyal_sinus1 = a1 * sin(2*pi*f1 * t);
sinyal_sinus2 = a2 * sin(2*pi*f2 * t);
%sinyal_sinus3 = a3 * sin(2*pi*f3 * t);

% Menambahkan ketiga sinyal sinusoidal
sinyal_total = sinyal_sinus1 + sinyal_sinus2 ;
sinyal_total2 = sinyal_sinus1 .* sinyal_sinus2 ;


% Menampilkan plot ketiga sinyal dan hasil penambahan
figure;

stem(t, sinyal_total2);
title('Hasil Penambahan 3 Sinyal Sinusoidal');
xlabel('Waktu (detik)');
ylabel('Amplitudo');
grid on;
figure;

stem(t, sinyal_total);
title('Hasil Penambahan 3 Sinyal Sinusoidal');
xlabel('Waktu (detik)');
ylabel('Amplitudo');
grid on;

figure;

stem(t, sinyal_sinus1);
title('Hasil Penambahan 3 Sinyal Sinusoidal');
xlabel('Waktu (detik)');
ylabel('Amplitudo');
grid on;

figure;

stem(t, sinyal_sinus2);
title('Hasil Penambahan 3 Sinyal Sinusoidal');
xlabel('Waktu (detik)');
ylabel('Amplitudo');
grid on;