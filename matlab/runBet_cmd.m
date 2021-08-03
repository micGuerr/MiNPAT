function [status, result] = runBet_cmd(in_vol, out_vo, f)
% 
% 
% 
% 
% 
% 
% 
% 
%

%% Check if the file exist
if exist(out_vo, 'file')
    warning('file %s already exist. Deleate the existing file if you want to re-run BET', ...
        out_vo);
    status = 0;
    result = 0;
    return
end

bet_cmd = sprintf('bet %s %s -m -f %f', ...
    in_vol, out_vo, f);
% run the command
[status, result] = runSystemCmd(bet_cmd, 1);
