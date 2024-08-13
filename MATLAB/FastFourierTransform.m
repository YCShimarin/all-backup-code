clc, clearvars, close all;

Fs = 1000;
T = 1/Fs;
L = 1500;
t = (0:L-1)*T;

S = 0.7*sin(2*pi*120*t);
X = S + 2*randn(size(t));

plot(1000*t(1:50),X(1:50))
title('Signal corrupted with zero-mean random noise')
xlabel("t(millosecond)")
ylabel("x(t)")

Y = fft(X);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
%{
f = Fs*(0:(L/2))/L;
figure(2)
plot(f,P1)
title("single-side Amplitude Spectrum of X(t)")
xlabel("f(Hz)")
ylabel("|P1(f)|")
%}
Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);

f = Fs*(0:(L/2))/L;

figure(2)
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of X(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")