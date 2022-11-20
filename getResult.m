function getResult(session, monitor1, var1, new_var)

comand1 = ['' char(new_var) ' = getresult("' char(monitor1) '", "' char(var1) '");'];
disp(comand1)
SendComand(session, comand1);

end