clc, clearvars, close all

% Deklarasi parameter sinyal kontiniyu
f1 = 300;
f2 = 600;
T = 1/f2;

% sampling
fs = 1000; %contoh aliasing karena tidak memnuhi teorema nyquist

% waktu plot
c = 3; % rubah nilai c untuk melihat banyaknya gelombang pada sinyal kedua
a = 10; % rubah nilai a untuk melihat jumlah gelombang yang disampling
t = linspace(0,c*T,10000); % untuk sinyal kontinyu
n = 0:a*fs/f2;

% persamaan sinyal kontiniyu
yt1 = 2*cos(2*pi*f1*t);
yt2 = 3*cos(2*pi*f2*t);
y1 = yt1 + yt2;

% persamaan sinyal sampling
yn1 = 2*cos(2*pi*f1/fs*n);
yn2 = 3*cos(2*pi*f2/fs*n);
y2 = yn1 + yn2;

% Uji persamaan sinyal sampling kedua dengan persamaan yang berbeda
yn21 = 3*cos(1.2*pi*n);
yn22 = 3*cos(0.8*pi*n);

% Uji rekontruksi
yr2 = 3*cos(2*pi*f2/fs*fs*t);
yr21 = 3*cos(1.2*pi*fs*t);
yr22 = 3*cos(0.8*pi*fs*t);

% Gambar sinyal kontiniyu
% biru sinyal pertama, hijau sinyal kedua, merah sinyal gabungan satu dan
% dua
figure(1)
plot(t,yt1,"b")
hold on
plot(t,yt2,"g")
hold on
plot(t,y1,"r")
title("Gabungan sinyal")
grid on

% Gambar sinyal sampling
figure(2)
subplot(3,1,1)
stem(n,yn1,"b")
title("Sampling sinyal pertama")
subplot(3,1,2)
stem(n,yn2,"g")
title("Sampling sinyal kedua")
subplot(3,1,3)
stem(n,y2,"r")
title("Sampling dari sinyal pertama + sinyal kedua")
grid on

% gambar sinyal sampling yn2, yn21 dan yn22
figure(3)
subplot(3,1,1)
stem(n,yn2,"b")
title("3*sin(2*pi*f2/fs*n)")
subplot(3,1,2)
stem(n,yn21,"g")
title("3*sin(1.2*pi*n)")
subplot(3,1,3)
stem(n,yn22,"r")
title("3*sin(0.8*pi*n)")
grid on

% Gambar sinyal rekontruksi
figure(4)
subplot(3,1,1)
plot(t,yr2,"b")
title("3*sin(2*pi*f2/fs*fs*t)")
subplot(3,1,2)
plot(t,yr21,"g")
title("3*sin(1.2*pi*fs*t)")
subplot(3,1,3)
plot(t,yr22,"r")
title("3*sin(0.8*pi*fs*t)")
grid on

% Gambar sinyal rekontruksi
figure(5)
plot(t,yr2,"b")
hold on
plot(t,yr21,"g")
hold on
plot(t,yr22,"r")
title("Gabungan Gambar rekontruksi")
grid on