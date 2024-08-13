T = 0.01;
w = 310:10:400;

num = 1;
den = 0.5 + 0.5 * exp(-1i*w*T); %cos(w * T) - 0.5i * sin(w * T);

Tz = den;

Re = real(Tz);
Im = imag(Tz);

Tz_abs = sqrt(Re.^2 + Im.^2);

figure;
plot(w, Tz_abs);
xlabel('Angular Frequency (rad/s)');
ylabel('Absolute Value of Tz');
title('|T(w)|');
grid on;
