function issweep = isSweep(session)
% The script command checks if the simulation is in sweep mode.
comand = {};
issweep_var = ['issweep_temp_'];
comand{end+1} = [issweep_var ' = issweep;'];
session.SendComand(comand{:});
issweep = (session.GetVar(issweep_var));

end