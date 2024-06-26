function addRect(session, varargin)
session.SendComand('addrect;');
correct_coef = 1e-6;
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
    session.Set(varargin{1}, varargin{2});
    varargin(1:2) = [];
end
end

