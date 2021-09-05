function importGDS(session, file_name, cell_name, varargin)
length_coef = 1e-6; % [um]
layer = 1;
material = [];
zmin =[];
zmax = [];
z_span = [];
x = [];
y = [];
z = [];
name = [];
dirrectory = [];
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'layer'
            layer = varargin{2};
        case 'name'
            name = varargin{2};
        case 'dir'
            dirrectory = varargin{2};
        case 'material'
            material = varargin{2};
            
        case 'zmin'
            zmin = varargin{2};
            
        case 'zmax'
            zmax = varargin{2};
            
        case 'z_span'
            z_span = varargin{2};
            
        case 'x'
            x = varargin{2};
            
        case 'y'
            y = varargin{2};
            
        case 'z'
            z = varargin{2};
            
        otherwise
            errore('unknown comand')
    end
    varargin(1:2) = [];
end
if isempty(dirrectory)
    path1 = dir;
    dirrectory = path1.folder;
end
other_params = [];
if ~isempty(material)
    other_params = [',"' material '"'];
    if ~isempty(zmin)
        other_params = [ other_params ',' num2str(zmin * length_coef) ',' num2str(zmax * length_coef)];
    end
end

session.SendComand(['n = gdsimport("' dirrectory '\' file_name '",'...
    ' "' cell_name '",'...
    ' ' num2str(layer)...
    other_params ...
    ');']);
if ~isempty(z_span)
    session.Set('z span', z_span * length_coef);
end
if ~isempty(x)
    session.Set('x', x * length_coef);
end
if ~isempty(y)
    session.Set('y', y * length_coef);
end
if ~isempty(z)
    session.Set('z', z * length_coef);
end
if ~isempty(name)
    session.Set('name', name);
end
end

% n = gdsimport("filename", "cellname", layer, "material", zmin, zmax);