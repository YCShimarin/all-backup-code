% Define the input signal
input_signal = [1, 2, 3, 4, 5];

% Define the delay length (in samples)
delay_samples = 1; % Adjust as needed

% Initialize an array for the output signal
output_signal = zeros(1, length(input_signal));

% Implement the delay system
for n = 1:length(input_signal)
    if n > delay_samples
        output_signal(n) = input_signal(n - 1);
    else
        output_signal(n) = 0; % Zero padding for samples before the delay
    end
end

% Display the input and output signals
disp('Input Signal:');
disp(input_signal);
disp('Output Signal (with Delay):');
disp(output_signal);
