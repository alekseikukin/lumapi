function varargin = sizes2microns(varargin)
correct_coef = 1e-6;
% disp({'varargin', varargin})
% disp({'length(varargin)', length(varargin)})
for ii = 1:length(varargin)-1
%     disp({'ii', ii})
    rfsc = rule_for_size_correction(varargin{ii});
    if rfsc
        varargin{ii+1} = varargin{ii+1} * correct_coef;
    end
end
% varargout = varargin;
end

function rfsc = rule_for_size_correction(v)
% disp(v)

if iscell(v)
    v = v{1};
end
if ischar(v) || isstring(v)
% disp(v)
        rfsc = string(char(v)) == "x" || ...
        string(char(v)) == "y" || ...
        string(char(v)) == "z" || ...
        string(char(v)) == "x span" || ...
        string(char(v)) == "y span" || ...
        string(char(v)) == "z span" || ...
        string(char(v)) == "x0" || ...
        string(char(v)) == "y0";
else
    rfsc = false;

end
end