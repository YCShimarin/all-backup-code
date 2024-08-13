% IIR

signal = [1,3,2,4,3,5,4,6,5,7,6,8,7,9];

a1 = 0.96906992;
b0 = 0.01546504;
b1 = 0.01546504;
yy_filtered = zeros(size(signal));
yy_filtered(1) = b0*signal(1);
yy_filtered(2) = b0*signal(2) + b1*signal(1);
for ii = 3:length(signal)
    yy_filtered(ii) = a1 * yy_filtered(ii - 1) + b0 * signal(ii) + b1 * signal(ii - 1);
end

disp(yy_filtered(1:5))
% Plot the filtered signal
figure;
stem(yy_filtered);
xlabel('time');
ylabel('amplitude');
title('lpf Filtered Signal');