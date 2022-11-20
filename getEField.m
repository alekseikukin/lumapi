function EF = getEField(session, monitor)
% getEField return EF of monitor.
comand = {};
mainVarP = ['EF' char(monitor)];
varP = ['EF_' monitor '_E'];
varLambda = ['EF_' monitor '_lambda'];
varX= ['EF_' monitor '_X'];
varY= ['EF_' monitor '_Y'];
varZ= ['EF_' monitor '_Z'];
varf= ['EF_' monitor '_f'];

% comand{end+1} = [mainVarP '= getresult("' monitor '", "E");' ];
getResult(session, monitor, "E", mainVarP)
comand{end+1} = [varP '=' mainVarP '.E;' ];
comand{end+1} = [varX '=' mainVarP '.x;' ];
comand{end+1} = [varY '=' mainVarP '.y;' ];
comand{end+1} = [varZ '=' mainVarP '.z;' ];
comand{end+1} = [varLambda '=' mainVarP '.lambda;' ];
comand{end+1} = [varf '=' mainVarP '.f;' ];

session.SendComand(comand{:});


EF.E = session.GetVar(varP);
EF.X = (session.GetVar(varX)) * 1e6;
EF.Y = (session.GetVar(varY)) * 1e6;
EF.Z = (session.GetVar(varZ)) * 1e6;
EF.lambda = (session.GetVar(varLambda)) * 1e6;
EF.f = (session.GetVar(varf));

end

