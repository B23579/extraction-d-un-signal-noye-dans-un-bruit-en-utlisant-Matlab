clc
clear
[y,fs]=audioread('ABC.wav');
N=length(y);
t=1:N;
sound(y,fs)
%% représentation dans le dommaine temporelle de y
figure(1)
plot(y)
xlabel('temps(s)')
ylabel('Amplitude')
grid on

%% signal bruité avec un signal sur bruit de -10 db
signal_plus_bruit = awgn(y, -10, 'measured');
sound(signal_plus_bruit,fs);

figure(2)
plot(signal_plus_bruit);
grid on
xlabel('temps(s)')
ylabel('Amplitude')


%% fonction d'autocorrélation 
corr_signal=xcorr(signal_plus_bruit,'biased');
corr_y=xcorr(y,'biased');
sound(10000*corr_signal)
figure(3)
plot(corr_signal)
xlabel('temps(s)')
ylabel('Amplitude')
grid on
%% confrontation des autocorrelations
figure(4)
hold on
plot(corr_signal)
hold on
plot(corr_y,'m')
grid on
xlabel('temps(s)')
ylabel('Amplitude')
%% représentation spectrale du signale plus bruit
M=length(signal_plus_bruit)/fs;
f=linspace(0,fs,M*fs);
spectSbruit=abs(fft(signal_plus_bruit));
figure(5)
plot(f,spectSbruit)
xlabel('frequence( pi rad)')
ylabel('amplitude')
grid on

%%  représentation du spectre du signal bruit dans un cote
long=length(spectSbruit);
figure(6)
hold on
plot([0:1/(long/2-1):1],spectSbruit(1:long/2))
xlabel('frequence( pi rad)')
ylabel('amplitude')
grid on
%%  paramettre du filtre de butter
[b,a]=butter(10,0.3,'low');
%% représentation spectrale du filtre pour le choix des paramètres du filtres de butter
H=freqz(b,a,floor(long/2))*600;
hold on
figure(7)
hold on
plot([0:1/(long/2-1):1],spectSbruit(1:long/2))
plot([0:1/(long/2-1):1],abs(H),'r') 
xlabel('frequence( pi rad)')
ylabel('amplitude')
grid on
%% filtrage du signale bruité yb
y_filter=filter(b,a,y);
figure(8)
plot(y_filter,'m')
xlabel('frequence( pi rad)')
ylabel('amplitude')
grid on
hold off
sound(y_filter,fs)


%% confrontation des graphes
 figure(9)
 hold on
 plot(y_filter,'m')
 plot(y)
 grid on 
 xlabel('temps(s)')
ylabel('amplitude')

 