function SetParam(session, name, value)
if ~isstring(value) && ~ischar(value)
    value = num2str(value);
else
    value = ['"' char(value) '"'];
end
comand = char(['set("' char(name) '", ' char(value) ');']);
session.SendComand(comand);
end

