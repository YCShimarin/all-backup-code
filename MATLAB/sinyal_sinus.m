close all;
clear all;


%2010952054 - Jimmy Nelson
%2110952028 - Mutiara Ali
%2110952001 - Muhammad Reval
%2110953005 - Muhammad Zaky Kurnia

% Parameter sinyal sinus
amplitudo = 5; %nim uda jimmy
frekuensi = 2; %nim muti
durasi = 2;
fs = 40;
Ts = 1/fs;

% Waktu Sinyal
t = 0:Ts:durasi;

% Membuat persamaan sinyal 
sinyal_sinus = amplitudo * sin(2*pi*frekuensi * t);

% plot sinyal 
figure;
stem(t, sinyal_sinus);
title('Sinyal Sinusoidal');
xlabel('Waktu (detik)');
ylabel('Amplitudo');
grid on;
