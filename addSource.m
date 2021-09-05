function addSource(session, varargin)
type  = 'addmodesource;';
correct_coef = 1e-6;


comands_list = {};

while ~isempty(varargin)
    rule_for_size_correction = string(char(varargin{1})) == "x" || ...
        string(char(varargin{1})) == "y" || ...
        string(char(varargin{1})) == "z" || ...
        string(char(varargin{1})) == "x span" || ...
        string(char(varargin{1})) == "y span" || ...
        string(char(varargin{1})) == "z span";
    if rule_for_size_correction
        varargin{2} = varargin{2} * correct_coef;
    end
    if  string(varargin{1}) == "type"
        type = ['add' varargin{2}];
        
    else
        comands_list{end+1} = varargin{1};
        comands_list{end+1} = varargin{2};
    end
    varargin(1:2) = [];
end
session.SendComand(type);
while ~isempty(comands_list)
        session.Set(comands_list{1}, comands_list{2});
        comands_list(1:2) = [];

end


end

