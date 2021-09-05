function Transmittance = getTransmitance(session,monitor)

mainVarT = ['Transmittance_' monitor];
varT = ['Transmittance_' monitor '_T'];
varLambda = ['Transmittance_' monitor '_lambda'];

comand = [mainVarT '= getresult("' monitor '", "T");' ];
session.SendComand(comand);

comand = [varT '=' mainVarT '.T;' ];
session.SendComand(comand);

comand = [varLambda '=' mainVarT '.lambda;' ];
session.SendComand(comand);

Transmittance = session.GetVar(varT);
Transmittance(:, end+1) = (session.GetVar(varLambda))*1e6;

end

