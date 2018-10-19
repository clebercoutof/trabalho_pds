fs = 44100; %% Frequencia de Amostragem
winsize = 4000; %% Tamanho da janela
NFFT = 4096; %% Numero de amostras da stft
noverlap = 2000; %Numero de amostras que nao sofrerao overlap
audio_duration = 3; %Duracao do audio
window = hanning(winsize); %Janela a ser utilizada na stft
signal = gravaAudio(fs,audio_duration);  

[signal_transformed F T P] = spectrogram(signal, window, noverlap, NFFT, fs);

sound_corrected = pitchCorrector(signal_transformed, F, P, tabelaDoMaior());
sound_corrected = conj(sound_corrected); % Faz o conjugado
isignal = istft(sound_corrected,NFFT,winsize,noverlap); % Faz a transformada inversa do sinal

mostraEspectrograma(isignal,F,T); % Mostra o espectrograma

sound(isignal,fs)%toca o som