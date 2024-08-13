[audio, fs] = audioread('audio_aa.wav');

channel_1 = audio(:, 1);
channel_2 = audio(:, 2);
channel_3 = audio(:, 3);
channel_4 = audio(:, 4);
channel_5 = audio(:, 5);
channel_6 = audio(:, 6);

% Plot the time-domain signals
figure;
subplot(6,1,1);
plot(channel_1);
title('Channel 1');

subplot(6,1,2);
plot(channel_2);
title('Channel 2');

subplot(6,1,3);
plot(channel_3);
title('Channel 3');

subplot(6,1,4);
plot(channel_4);
title('Channel 4');

subplot(6,1,5);
plot(channel_5);
title('Channel 5');

% Plot the frequency spectrum of channel 2 in amplitude
subplot(6,1,6);
plot(channel_6);
title('Channel 6');

n = length(channel_2);
frequencies = linspace(0, fs, n);
spectrum = abs(fft(channel_2))/n;

figure;
plot(frequencies, spectrum);
title('Frequency Spectrum - Channel 2');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
