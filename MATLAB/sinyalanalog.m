clc

ac = 1;
fc = 100;
fs = 10*fc;
ts = 1/fs;

fi = 5 ;
ti = 1/fi;

t = 0 : ts:2*ti;
sc = ac*cos(2*pi*fc*t);
figure

subplot(4,1,1)
plot(t,sc)
title('signal carrier');

Ai = 1 ;

si = Ai*cos(2*pi*fi*t);

subplot(4,1,2)
plot(t,si)
title('signal informasi')

s_am = si.*sc;

subplot(4,1,3)
plot (t,s_am)
title('sinyal modulasi am')

s_dm = s_am.*sc;

subplot(4,1,4)
plot (t, s_dm)
title('sinyal demodulasi')



