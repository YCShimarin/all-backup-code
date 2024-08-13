%Filter specifications
Ap = 0.07;
Aa = 41;
OmegaP1 = 700;
OmegaP2 = 1250;
OmegaA1 = 800;
OmegaA2 = 1100;
OmegaS = 3200;

TS = 2*pi / OmegaS; % sampling_period
Bt = min((OmegaA1 - OmegaP1),(OmegaP2 - OmegaA2));%transiton bandwidth
OmegaC1 = OmegaP1 + Bt/2;% cutoff 1
OmegaC2 = OmegaP2 - Bt/2;% cutoff 2

deltaP = (10^(0.05*Ap) - 1)/(10^(0.05*Ap) + 1);
deltaA = 10^(-0.05*Aa);
delta = min(deltaP , deltaA);

Aa1 = -20*log10(delta);%stop band attenuation

%calculating alpha
if (Aa1<=21)
    alpha = 0;
elseif (21<Aa1 && Aa1<=50)
    alpha = 0.5842*(Aa1 - 21)^0.4 + 0.07886*(Aa1 - 21);
else
    alpha = 0.1102*(Aa1 - 8.7);
end

%calculating D
if (Aa1<=21)
    D = 0.9222;
else
    D = (Aa1 - 7.95)/14.36;
end

%calculating N
N = ceil(OmegaS*D/Bt + 1);
if(mod(N,2)==0)
    N = N+1;
end


%calculations of window function
halfRange = (N-1)/2;
n = -halfRange : 1 : halfRange;
beta = alpha*(1 - (2*n/(N-1)).^2).^0.5;

syms k;
IBeta = 1 + double(symsum(((1/factorial(k))*(beta/2).^k).^2, k, 1, Inf));
IAlpha = 1 + double(symsum(((1/factorial(k))*(alpha/2)^k)^2, k, 1, Inf));

w =IBeta./IAlpha; % window function

%plot the window function
figure;
stem(n,w);
xlabel('n');
ylabel('w[n]');
title('Window Function');
grid on;


%h[n]
neg = -halfRange : 1 : -1;
hneg = ((1/pi)./neg).*(sin(OmegaC1*TS.*neg) - sin(OmegaC2*TS.*neg));
hzero = 1 + 2*(OmegaC1 - OmegaC2)/OmegaS;
nposi = 1 : 1 : halfRange;
hposi = ((1/pi)./nposi).*(sin(OmegaC1*TS.*nposi) - sin(OmegaC2*TS.*nposi));
h = [hneg,hzero,hposi];
n = [neg,0,nposi];

figure;
stem(n,h);
grid on;
xlabel('n');
ylabel('h[n]');
title('Impulse Response');


%Filter response
hFilter = h.*w;
figure;
subplot(1,2,1);
stem(n,hFilter);
xlabel('n');
ylabel('h[n]');
title('Non Causal Filter impulse response');
grid on;

nCausal = 0:1:N-1;% shift n to obtain causal response
subplot(1,2,2);
stem(nCausal,hFilter);
xlabel('n');
ylabel('h[n]');
title('Causal Filter impulse response');
grid on;


%Magnitude response
fvtool(hFilter);
freqz(hFilter);