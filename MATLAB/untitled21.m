% Koefisien sistem (contoh)
num = [1]; % Koefisien pembilang
den = [1, -0.5, 0.25]; % Koefisien penyebut

% Membuat sistem dari koefisien
sys = tf(num, den);

% Membuat sinyal eksponensial (contoh)
t = 0:0.1:10; % Rentang waktu
exponential_signal = exp(-0.2*t); % Sinyal eksponensial (contoh)

% Menghasilkan respons impuls
t_impulse = 0:0.1:10; % Rentang waktu respons impuls
impulse_response = impulse(sys, t_impulse);

% Melakukan konvolusi sinyal eksponensial dengan respons impuls
convolved_signal = conv(exponential_signal, impulse_response, 'full');

% Plot sinyal eksponensial, respons impuls, dan hasil konvolusi
figure;
subplot(3,1,1);
plot(t, exponential_signal);
title('Sinyal Eksponensial');
xlabel('Waktu');
ylabel('Amplitudo');

subplot(3,1,2);
plot(t_impulse, impulse_response);
title('Respons Impuls Sistem');
xlabel('Waktu');
ylabel('Amplitudo');

subplot(3,1,3);
t_convolved = 0:0.1:(length(convolved_signal)-1)*0.1;
plot(t_convolved, convolved_signal);
title('Hasil Konvolusi');
xlabel('Waktu');
ylabel('Amplitudo');

sgtitle('Konvolusi Sinyal Eksponensial dengan Respons Impuls Sistem');

grid on;
