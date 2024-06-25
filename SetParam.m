function SetParam(session, name, value)
if ~isstring(value) && ~ischar(value)
    if ismatrix(value)
        allOneString = ['['];
        for ii = 1:size(value,1)
            allOneString = [allOneString sprintf('%.06e,' , value(ii,:))];
            allOneString = allOneString(1:end-1);
            if ii < size(value,1)
                allOneString = [allOneString, ';'];
            else
                allOneString = [allOneString, ']'];

            end
        end
        value = allOneString;
    else
        value = num2str(value);
    end
else
    value = ['"' char(value) '"'];
end
comand = char(['set("' char(name) '", ' char(value) ');']);
session.SendComand(comand);
end

