% Parameter yang diberikan
T = 0.01;        % Waktu sampling
w = 310:10:400;  % Rentang frekuensi sudut

% Hitung fungsi transfer dalam domain z
Tz = 0.5 + 0.5 * exp(-1i*w*T);

% Ekstrak bagian real dan imajiner dari fungsi transfer
Re = real(Tz);
Im = imag(Tz);

% Hitung nilai absolut (magnitude) dari fungsi transfer
Tz_abs = sqrt(Re.^2 + Im.^2);

% Plot respons magnitudo dari fungsi transfer
figure;
plot(w, Tz_abs,'LineWidth', 2);
xlabel('Frekuensi Sudut (rad/s)');
ylabel('Gain |T(z)|');
title('|T(w)|');
grid on;

wt = w';
Tzt = Tz_abs';
wtt = (w*T)';