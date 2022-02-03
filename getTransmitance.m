function Transmittance = getTransmitance(session,monitor)
comand = {};
mainVarT = ['Transmittance_' monitor];
varT = ['Transmittance_' monitor '_T'];
varLambda = ['Transmittance_' monitor '_lambda'];

comand(end+1) = [mainVarT '= getresult("' monitor '", "T");' ];
comand(end+1) = [varT '=' mainVarT '.T;' ];
comand(end+1) = [varLambda '=' mainVarT '.lambda;' ];
session.SendComand(comand);

Transmittance = session.GetVar(varT);
Transmittance(:, end+1) = (session.GetVar(varLambda)) * 1e6;

end

