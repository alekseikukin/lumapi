function user_matrix = getUserMatrix(session)
comand = {};

comand{end+1} = ['user_s_matrix_0000000001= getresult("EME", "user s matrix");' ];
session.SendComand(comand{:});
user_matrix = session.GetVar("user_s_matrix_0000000001");
% Transmittance(:, end+1) = (session.GetVar(varLambda)) * 1e6;

end

