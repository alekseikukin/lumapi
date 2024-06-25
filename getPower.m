function Power = getPower(session, monitor, varargin)
% getPower return power of monitor.
p_type = 0
while ~isempty(varargin)
    switch lower(varargin{1})
        case {'p_type'}
            p_type = varargin{2};
        otherwise
    end
    varargin(1:2) = [];
end
comand = {};
mainVarP = ['Power' char(monitor)];
varP = ['Power_' monitor '_P'];
varLambda = ['Power_' monitor '_lambda'];
varX= ['Power_' monitor '_X'];
varY= ['Power_' monitor '_Y'];
varZ= ['Power_' monitor '_Z'];
varf= ['Power_' monitor '_f'];

if p_type == 1
    comand{end+1} = [mainVarP '= getresult("' monitor '", "E, H, P expanded along z");' ];
else
        comand{end+1} = [mainVarP '= getresult("' monitor '", "P");' ];
end
comand{end+1} = [varP '=' mainVarP '.P;' ];
comand{end+1} = [varX '=' mainVarP '.x;' ];
comand{end+1} = [varY '=' mainVarP '.y;' ];
comand{end+1} = [varZ '=' mainVarP '.z;' ];
comand{end+1} = [varLambda '=' mainVarP '.lambda;' ];
comand{end+1} = [varf '=' mainVarP '.f;' ];

session.SendComand(comand{:});


Power.P = session.GetVar(varP);
Power.X = (session.GetVar(varX)) * 1e6;
Power.Y = (session.GetVar(varY)) * 1e6;
Power.Z = (session.GetVar(varZ)) * 1e6;
Power.lambda = (session.GetVar(varLambda)) * 1e6;
Power.f = (session.GetVar(varf));

end

