function filtruj_folder_cheby1_wieloczestotliwosci(folderPath, Fc_list)

N  = 13;   % filter order
Rp = 0.05; % passband ripple

files = dir(fullfile(folderPath, '**', '*.wav'));

for k = 1:length(files)
    fullFilePath = fullfile(files(k).folder, files(k).name);

    [x, Fs] = audioread(fullFilePath);

    [~, name, ~] = fileparts(files(k).name);

    for fci = 1:length(Fc_list)
        Fc = Fc_list(fci);

        Wn = Fc / (Fs/2);

        [b, a] = cheby1(N, Rp, Wn, 'low');

        y = filtfilt(b, a, x);

        outName = sprintf('%s_%05dHz.wav', name, Fc);
        outPath = fullfile(files(k).folder, outName);

        audiowrite(outPath, y, Fs);

        fprintf('✔ %s → %s\n', files(k).name, outName);
    end
end
end

folder = 'path\to\folder';
czestotliwosci = [3500, 4000, 4500, 5000, 5500, 6000, 6500, ...
                  7000, 8000, 8700, 9300, 10000, 10700, 11300, 12000]; % frequencies

filtruj_folder_cheby1_wieloczestotliwosci(folder, czestotliwosci);