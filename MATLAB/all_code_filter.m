

signal = [1,3,2,4,3,5,4,6,5];

disp("1. Recursive order 2");
disp("2. FIR");
disp("3. IIR");
disp("4. Butterworth");
disp("5. Convolution");
userInput = input('Enter a number: ', 's');

if userInput == '1'
    % Recursive Order 2 
    b0 = 0.1;
    p1 = 0.8;
    p2 = 0.2; 
    
    yyy_rec = zeros(1, length(signal));
    yyy_rec(1) = b0*signal(1);
    yyy_rec(2) = b0 * signal(2) + p1 * yyy_rec(1);
    
    for ii = 3:length(signal)
        yyy_rec(ii) = b0 * signal(ii) + p1 * yyy_rec(ii-1) + p2 * yyy_rec(ii-2);
    end
    
    figure;
    subplot(2,1,1);
    stem(signal);
    title('Original Signal');
    
    subplot(2,1,2);
    stem(yyy_rec);
    title('Filtered Signal');
    xlabel('time');
    ylabel('amplitude');

elseif userInput == '2'
    % FIR
    a1 = 0.2;
    a2 = 0.2;
    a3 = 0.2;
    
    x_lpf = zeros(size(signal));
    x_lpf(1) = a1 * signal(1);
    x_lpf(2) = a1 * signal(2) + a2 * signal(1);
    
    for ii = 3:length(signal)
        x_lpf(ii) = a1 * signal(ii) + a2 * signal(ii-1) + a3 * signal(ii-2);
    end
    
    figure;
    subplot(2,1,1);
    stem(signal);
    title('Original Signal');
    
    subplot(2,1,2);
    stem(x_lpf, 'r');
    title('Filtered Signal');
    xlabel('time');
    ylabel('amplitude');

elseif userInput == '3'
    % IIR
    a1 = 0.96906992;
    b0 = 0.01546504;
    b1 = 0.01546504;
    yy_filtered = zeros(size(signal));
    yy_filtered(1) = b0 * signal(1);
    yy_filtered(2) = b0 * signal(2) + b1 * signal(1);
    
    for ii = 3:length(signal)
        yy_filtered(ii) = a1 * yy_filtered(ii - 1) + b0 * signal(ii) + b1 * signal(ii - 1);
    end
    
    figure;
    subplot(2,1,1)
    stem(signal);
    title('Original Signal');
    subplot(2,1,2)
    stem(yy_filtered);
    xlabel('time');
    ylabel('amplitude');
    title('IIR Filtered Signal');

elseif userInput == '4'
    % Butterworth
    p1 = 0.7;
    c1 = -0.75; 
    
    yyy_rec = zeros(1, length(signal));
    yyy_rec(1) = signal(1);
    
    for ii = 2:length(signal)
        yyy_rec(ii) = signal(ii) + p1 * yyy_rec(ii-1);
        yyy_lpf(ii) = c1 * (yyy_rec(ii)) + signal(ii);
    end
    
    figure;
    subplot(2,1,1);
    stem(signal);
    title('Original Signal');
    
    subplot(2,1,2);
    stem(yyy_lpf);
    title('Filtered Signal');
    xlabel('time');
    ylabel('amplitude');
elseif userInput == '5'
    h = ones(1,5);
    
    yyy_conv = conv(signal,h);

    figure;
    subplot(2,1,1);
    stem(signal);
    title('Original Signal');
    
    subplot(2,1,2);
    stem(yyy_conv);
    title('Filtered Signal');
    xlabel('time');
    ylabel('amplitude');
else
    disp("Number not valid");
end
