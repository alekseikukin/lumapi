function SetParam(session, name, value)
if ~isstring(value) && ~ischar(value)
    value = string(value);
else
    value = ['"' value '"'];
end
session.SendComand(['set("' name '",' char(value) ');']);
end

