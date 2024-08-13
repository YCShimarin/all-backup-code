% Data input
% Meminta pengguna untuk memasukkan data
prompt = 'Masukkan sinyal x[n] (pisahkan dengan spasi):';
disp('Default: : sin(4 PI t) -> fs : 25')
data_str = input(prompt, 's'); % Membaca input sebagai string

if isempty(data_str)
    % Jika input kosong, gunakan array default
 % Sinyal sin parameters
    f = 2; % Frekuensi sinyal sin (contoh)
    fs = 25;
    ts = 1/fs;
    t = 0:ts:1; % Rentang waktu
    
    % Generate sinyal sin
    data = sin(2 * pi * f * t);
else
    % Jika ada input nilai, konversi string input menjadi array numerik
    data = str2double(strsplit(data_str)); % Mengonversi string ke array double
end

disp('1 untuk sinyal cosinus')
disp('2 untuk step signal 13')
disp('3.untuk signal ramp 13')
disp('4.untuk input data sendiri')


prompt = 'Masukkan pilihan : ';
choice = input(prompt);

if choice == 1
    % Sinyal cosinus parameters
    f = 2; % Frekuensi sinyal cosinus (contoh)
    fs = 25;
    ts = 1/fs;
    t = 0:ts:1; % Rentang waktu
    
    % Generate sinyal cosinus
    hn_signal = cos(2 * pi * f * t);

elseif choice == 2
    % Membuat array ones(1, 13)
    hn_signal = ones(1, 13);

elseif choice == 3
    hn_signal = [1 2 3 4 5 6 7 8 9 10 11 12 13];

elseif choice == 4
    prompt = 'Masukkan sinyal h[n] (pisahkan dengan spasi):';
    input_hn = input(prompt, 's'); % Membaca input sebagai string
    hn_signal = str2double(strsplit(input_hn));

else
    % Menampilkan pesan kesalahan jika pilihan tidak valid
    disp('Pilihan tidak valid.');
end


% Konvolusi data dengan sinyal cosinus
convolved_data = conv(data, hn_signal);

% Plot data asli, sinyal cosinus, dan data hasil konvolusi
figure;
grid("on")
subplot(3,1,2);
stem(hn_signal);
title('Sinyal h[n]');
xlabel('Waktu');
ylabel('Amplitudo');

subplot(3,1,1);
stem(data, 'b', 'filled');
title('Sinyal x[n]');
xlabel('Indeks Data');
ylabel('Nilai Data');

subplot(3,1,3);
stem(convolved_data, 'r', 'filled');
title('Data Hasil Konvolusi dengan Sinyal Cosinus');
xlabel('Indeks Data');
ylabel('Nilai Data');

% Tampilkan plot
sgtitle('Konvolusi Sinyal x[n] dan h[n]');

