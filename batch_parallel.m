% Read the file paths from the .txt file
file_paths = readlines('/Volumes/LaCie/FR_Emotion_Lukas/EmotionGrids/Micros_NEW/file_paths.txt');
num_files = length(file_paths);

% Start the parallel pool
if isempty(gcp('nocreate'))
    parpool('local');
end

% Store the original directory
original_dir = pwd;
% 
% % Create a parallel.pool.DataQueue to track progress
% dataQueue = parallel.pool.DataQueue;
% 
% % Define a function to update and display progress
% afterEach(dataQueue, @(varargin) fprintf('Completed %d out of %d files\n', varargin{1}, num_files));

% Use parfor instead of for
parfor i = 1:num_files
    % Get the current file path and remove any leading/trailing whitespace
    current_path = strip(file_paths(i));
    
    % Extract the directory path (one level above the file)
    [directory_path, ~, ~] = fileparts(current_path);
    
    % Change directory to the parent directory
    try
        cd(directory_path);
    catch ME 
        disp(directory_path)
    end

    param = struct()
    if contains(directory_path, 'chan')
        param.detection = 'neg'
    else
        param.detection = 'pos'
    end
%     
%     Get_spikes('datacut.mat', 'par', param);
%     Do_clustering('all', 'make_plots', false)
        
    % Increment the completed files counter
%     completed_files = completed_files + 1;
    
    % Check if 'datacut_spikes.mat' exists
    if ~isfile('datacut_spikes.mat')
        % Run your two lines of code here
        % For example:
%         disp(['Processing file: ' current_path]);
        Get_spikes('datacut.mat', 'par', param);
        Do_clustering('all', 'make_plots', false)
        
    end
    
    % Return to the original directory
    cd(original_dir);
    
    % Send progress update to the DataQueue
%     send(dataQueue, i);
end

% Close the parallel pool if you want
% delete(gcp('nocreate'));