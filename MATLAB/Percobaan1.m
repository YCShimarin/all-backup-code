% Sinyal sin parameters 
f = 2; % Frekuensi sinyal sin (contoh)
fs = 25;
ts = 1/fs;
t = 0:ts:1; % Rentang waktu

% Generate sinyal sin
x = sin(2 * pi * f * t);
%-------------------------------------------

% Order filter rekrusif dan koefisiennya
order = 3; %Order rekrusif
a = [1, 0.8, 0.6];

% Inisialisasi output dan state variables
y = zeros(size(x));
y_prev = zeros(1, order);

%------------------------------------------
%Response Impulse Function part

% Koefisien sistem (contoh)
num = [1]; % Koefisien pembilang

% Membuat sistem dari koefisien
sys = tf(num, x); % output / input

% Menghasilkan respons impuls
t_impulse = 0:ts:1; % Rentang waktu respons impuls
impulse_response = impulse(sys, t_impulse); %Konvert ke domain waktu

%--------------------------------------------
%Recursive Filter part

% Implementasi filter 
for n = 1:length(x)
    y(n) = x(n);
    for i = 1:order
        if n > i
            y(n) = y(n) - a(i) * y_prev(i);
        end
    end
    % Update state variables
    y_prev(2:end) = y_prev(1:end-1);
    y_prev(1) = y(n);
end

% Convolution Part
convolution_signal = conv(y, impulse_response);

% Plot stem dari sinyal output dan hasil konvolusi
figure;
subplot(4,1,1);
stem(x);
title('Sinyal Sinusoidal');
xlabel('Indeks Waktu (n)');
ylabel('Amplitudo');

subplot(4,1,2);
stem(y);
title('Sinyal Output Filter IIR');
xlabel('Indeks Waktu (n)');
ylabel('Amplitudo');

subplot(4,1,3);
stem(impulse_response);
title('Respons Impuls Sistem');
xlabel('Waktu');
ylabel('Amplitudo');

subplot(4,1,4);
t_convolved = 0:ts:(length(convolution_signal)-1)*ts;
stem(t_convolved, convolution_signal);
title('Hasil Konvolusi');
xlabel('Waktu');
ylabel('Amplitudo');

sgtitle('Implementasi Filter Rekrusif dan Konvolusi dengan Respons Impuls');

grid on;
