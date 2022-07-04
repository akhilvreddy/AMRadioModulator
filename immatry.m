filename = 'oddity.wav';
[y,Fs] = audioread(filename);

%soundsc(y,Fs);

yFirstColumn = y(:,1); %this signal is m(t)

figure(); 
plot(yFirstColumn);
xlabel('Time (s)');
ylabel('m(t) signal');
title('m(t) vs time');

yFCsquared = yFirstColumn.^2;
totalSum = sum(yFCsquared(:,1));
totalEnergy = totalSum * (1/Fs);

%------------------End of Part a---------------------%

Ac = 10; 
Fc = 1310*10^3; 

yFirstColumn = resample(yFirstColumn,227,1);

t = 0:1/54857501:1;
t = t(2:end); 
c = cos(2*pi*Fc*t);

c = transpose(c); 
 
s = Ac*(yFirstColumn.*c); 

figure(); 
plot(s);
xlabel('Time (s)');
ylabel('s(t) signal');
title('s(t) vs time');

sSignalsquared = s.^2;
sSignalEnergy = sum(sSignalsquared(:,1)) * (1/10^7);

%------------------End of Part b---------------------%

w = randn(1, 54857501);
w = transpose(w);

alpha1 = 0.1; 
alpha2 = 0.5; 

w1 = w * alpha1; 
w2 = w * alpha2;

y1 = w1 + s; 
y2 = w2 + s; 

figure();
plot(y1); 
xlabel('Time (s)');
ylabel('y(t) signal with alpha = 0.1'); 
title('y(t) vs time');

figure();
plot(y2); 
xlabel('Time (s)');
ylabel('y(t) signal with alpha = 0.5'); 
title('y(t) vs time');

%------------------End of Part c---------------------%

v1 = y1.*c; 
v2 = y2.*c; 

figure();
plot(v1); 
xlabel('Time (s)');
ylabel('v(t) signal with alpha = 0.1'); 
title('v(t) vs time');

figure();
plot(v2); 
xlabel('Time (s)');
ylabel('v(t) signal with alpha = 0.5'); 
title('v(t) vs time');

%------------------End of Part e---------------------%

v1lowpass = lowpass(v1,(10^7)/2,(10^7)); 
v2lowpass = lowpass(v2,(10^7)/2,(10^7));

figure();
plot(v1lowpass); 
xlabel('Time (s)');
ylabel('v(t) signal with alpha = 0.1'); 
title('lowpass filter on v(t)');

figure();
plot(v2lowpass); 
xlabel('Time (s)');
ylabel('v(t) signal with alpha = 0.5'); 
title('lowpass filter on v(t)');

%------------------End of Part f---------------------%

m1hat = resample(v1,441,100000);
m2hat = resample(v2,441,100000);

figure();
plot(m1hat); 
xlabel('Time (s)');
ylabel('v(t) signal with alpha = 0.1'); 
title('resampled v(t)');

figure();
plot(m2hat); 
xlabel('Time (s)');
ylabel('v(t) signal with alpha = 0.5'); 
title('resampled v(t)');