function ilm = isLayoutMode(session)
% This script command can be used to determine whether the simulation file
% is currently in LAYOUT mode or in ANALYSIS mode.  It is important to use
% this command to check the status of the project file once it is opened to
% avoid running into an error during the subsequent operations if the file
% is not in the desired mode.
comand = {};
issweep_var = ['ilm_temp_'];
comand{end+1} = [issweep_var ' = layoutmode;'];
session.SendComand(comand{:});
ilm = (session.GetVar(issweep_var));
end