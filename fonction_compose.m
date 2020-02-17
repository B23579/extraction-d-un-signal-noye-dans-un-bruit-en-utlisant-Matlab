clc
clear
%% tracer la repr�sentation temporelle d'un bruit rose en wav
[h,fs]=audioread('0432.wav');
sound(h)
figure(1)
plot(h(1:5000))
grid on
xlabel('temps')
ylabel('Amplitude')
%% bruit gaussien 
N=5000; % nombre de points 
k=1:N;
rd=rand(1,N); %calcul d'un vecteur sur N vecteur tir� au 
                  % sort avec une loi uniforme
rd=rd-mean(rd);
figure(1)
plot(rd(1:N))
xlabel('temps(s)')
ylabel('Amplitude')
grid on
sound(rd)
%% repr�sentation temporelle du signale y(t)
f1=500; % fr�quence propre du premier signal
f2=300; % fr�quence propre du deuxi�me signal
N=5000; %nombre de points
t=1:N;
y=sin(2*pi*t/f1)+sin(2*pi*t/f2);
figure(2)
plot(t,y)
xlabel('temps')
ylabel('Amplitude')
grid on
%% repr�sentation temporelle du signale y(t)+ bruit gaussien
yb=y+rd;
sound(yb)
figure(3)
plot(t,yb)
xlabel('temps')
ylabel('Amplitude')
grid on

%% repr�sentation temporelle du signale y(t)+ bruit rose
ya=y+h(1:5000);
sound(ya)
figure(4)
plot(t,ya)
xlabel('temps')
ylabel('Amplitude')
grid on
%% fonction d'autocorr�lation avec le bruit blanc qussien
corr_yb=xcorr(yb,'unbiased'); % calacul des coefficients d'autocorr�lation
figure(5)
plot(-(N-1):(N-1),corr_yb)
xlabel('temps(s)')
ylabel('Amplitude')

%% fonction d'autocorr�lation avec le bruit rose
corr_ya=xcorr(ya,'unbiased'); % calacul des coefficients d'autocorr�lation
figure(6)
plot(-(N-1):(N-1),corr_ya)
xlabel('temps(s)')
ylabel('Amplitude')
grid on
%% confrontation des resultats obtenues par autocorrelation sur un signale
% gaussien
figure(7)
hold on
plot(-(N-1):(N-1),corr_yb,'m')
plot(t,y,'b')
xlabel('temps(s)')
ylabel('Amplitude')
grid on
%% repr�sentation spectrale du signal y+bruit gaussien
fe=100;
N=length(yb)/fe;
f=linspace(-10,fs,N*fe);
g=abs(fft(yb));
figure(8)
plot(f,g)
xlabel('fr�quence(Hz)')
ylabel('amplitude(db)')

%% repr�sentation du spectre du signal bruite dans un cote
long=length(g);
figure(9)
hold on
plot([0:1/(long/2-1):1],g(1:long/2))
xlabel('frequence( pi rad)')
ylabel('amplitude')
grid on

%% paramettre du filtre de butter
[b,a]=butter(10,0.018,'low');
%% repr�sentation spectrale du filtre pour le choix des param�tre du filtre de butter
H=freqz(b,a,floor(long/2))*2500; % 2500 repr�sente les amplitudes maximale du spectre
        %pour calculer les fr�quences du filtre dans 
        % l'intervale de fr�quence du filtre
hold on
figure(10)
hold on
plot([0:1/(long/2-1):1],g(1:long/2))
plot([0:1/(long/2-1):1],abs(H),'r') 
xlabel('frequence( pi rad)')
ylabel('amplitude')
grid on
hold off
%% filtrage du signale bruit� yb
yb_filter=filter(b,a,yb);
figure(11)
plot(yb_filter,'m')
xlabel('frequence( pi rad)')
ylabel('amplitude')
grid on
hold off


%% confrontation des resultats avec les graphes
figure(12)
hold on
plot(yb_filter,'m')
plot(t,y)
xlabel('temps(s)')
grid on
ylabel('Amplitude')



