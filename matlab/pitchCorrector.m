%%Fun��o que realiza a corre��o dos tons
%%Recebe como entrada a STFT, seu espa�o em frequ�ncia, o vetor de densidae espectral de pot�ncia P e tabeal com
%% a escala de tons
function S_corrected = pitchCorrector(S, F, Y, pitchtable)

bins = length(S(1,:));
S_len = length(S(:,1));

%%Pre aloca memorias para os vetores
maxpeaks = zeros(1,bins);
indices = zeros(1,bins);
pitches = zeros(1,bins);
correctedpitches = zeros(1,bins);
ratio = zeros(1,bins);
S_corrected = zeros(S_len,bins);

%%Encontra as maximas amplitudes e frequ�ncias correspondentes no espectro de fourirrer.Finds the maximum amplitudes and their corresponding frequencies in the
%%Armazena o tom mais proximo na variavel correctedpitches. A variavel ratio armazena o fator
%pelo qual o espectro deve ser espelhado para obter o tom correto
for k = 1:bins
    maxpeaks(k) = max(Y(:,k));
    indices(k) = find(Y(:,k) == maxpeaks(k),k,'first');
    pitches(k) = F(indices(k));
    correctedpitches(k) = compareToPitches(pitches(k), pitchtable);
    ratio(k) = correctedpitches(k)/pitches(k);

end

%%A rela��o entre frequencias deve ser equivalente a rela��o entre amostras. Se a rela��o
%% for maior que um S-corrected ser� completado com zeros, se a rela��o for menor que 1
%% o S-corrected ter� valores repetidos. Fazendo com que tenha perda ad informa��o.

for k = 1:bins
        for j = 1:S_len
          y = round(j/ratio(k));
          
          %%Prevents negative indices
          if y < 1 
              y = 1;
          end
          
          %%Non-constant frequency scaling
          if y <= S_len
            S_corrected(j,k) = S((y),k);
          end
        end
end

end

