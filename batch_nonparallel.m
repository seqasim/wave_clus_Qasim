% Read the file paths from the .txt file
file_paths = readlines('/Volumes/LaCie/FR_Emotion_Lukas/EmotionGrids/Micros_NEW/file_paths.txt');

% Iterate through each file path
for i = 1:length(file_paths)
    % Get the current file path and remove any leading/trailing whitespace
    current_path = strip(file_paths(i));
    
    % Extract the directory path (one level above the file)
    [directory_path, ~, ~] = fileparts(current_path);
    
    % Change directory to the parent directory
    cd(directory_path);
    
    % Run your two lines of code here
    % For example:
    Get_spikes('datacut.mat');
    Do_clustering('all')
    
    % Optional: Return to the original directory if needed
    % cd(original_directory);
end