function getResult(session, monitor1, result_name, new_var)
% put pointed result from pointed monitor in ponted variavle

comand1 = ['' char(new_var) ' = getresult("' char(monitor1) '", "' char(result_name) '");'];

% comand{end+1} = ['' char(new_var) ' = getresult("' char(monitor1) '", "' char(result_name) '");'];
% comand{end+1} = [varT '=' mainVarT '.T;' ];
% comand{end+1} = [varLambda '=' mainVarT '.lambda;' ];
% disp(comand1)
SendComand(session, comand1);

end