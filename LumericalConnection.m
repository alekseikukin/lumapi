classdef LumericalConnection
    %LUMERICALCONNECTION Summary of this class goes here
    %   Detailed explanation goes here

    properties
        currentConnection
    end

    methods
        function obj = LumericalConnection(varargin)
            %LUMERICALCONNECTION Construct an instance of this class
            %   type can be: 'mode', 'fdtd'
            type = 'mode';
            current_version = 'v222';
            HDD = 'C:';
            path_to_folder = '\Program Files\Lumerical\';
            while ~isempty(varargin)
                switch lower(varargin{1})
                    case 'program'
                        type = varargin{2};
                    case 'hdd'
                        HDD = varargin{2};
                    case 'path_to_folder'
                        path_to_folder = varargin{2};
                    case {'version'}
                        current_version = varargin{2};  
                    otherwise
                        errore('unknown paramiter')
                end
                varargin(1:2) = [];
            end
            path(path, fullfile(HDD, path_to_folder, current_version, '\api\matlab'));
            obj.currentConnection =  appopen(type);
        end

        function [] = SendComand(obj,varargin)
            %SendVar send comand to lumerical
            %
            % chek that all comand line end with ';' and add if not
            for ii = 1:length(varargin)
                if char(varargin{ii}(end)) ~= ';'
                    varargin{ii} = [varargin{ii} ';'];
                end
            end
            code = char(strcat(varargin{ : }));
            appevalscript(obj.currentConnection,code);
        end
        function [] = SendVar(obj,varName,varVal)
            %SendVar Send variable to lumerical
            
           appputvar(obj.currentConnection,varName, varVal);
        end
        function result = GetVar(obj, varName)
            %METHOD1 Summary of this method goes here
            %
            varName = [char(varName)];
            result = appgetvar(obj.currentConnection, varName);

        end
        function OpenFile(obj, filename)
            % open lumericl file
            comand = ['load("' char(filename) '");'];
            obj.SendComand(comand)
        end
        function AppClose(obj)
            % close Lumerical
            appclose(obj.currentConnection);
        end
        function ImportGDS(obj, file_name, cell_name, varargin)
            % import GDS2 file into Lumerical
            importGDS(obj,...
                file_name,...
                cell_name,...
                varargin{:})
        end
        function Set(obj, varargin)
            % set vriable
            while ~isempty(varargin)
                SetParam(obj, varargin{1}, varargin{2})
                varargin(1:2) = [];
            end
        end
        function AddRect(obj, varargin)
            % add rectangle
            addRect(obj, varargin{:});
        end
        function AddFDTD(obj, varargin)
            % add FDTD area
            addFDTD(obj, varargin{:});
        end
        function AddVarFDTD(obj, varargin)
            % add varFDTD area
            addVarFDTD(obj, varargin{:});
        end
        function AddSource(obj, varargin)
            % add source
            addSource(obj, varargin{:});
        end
        function AddPower(obj, varargin)
            % add power
            addPower(obj, varargin{:});
        end

        function Save(obj, name)
            % save lumerical file ass
            obj.SendComand(['save("' name '");']);
        end
        function Run(obj)
            % run simulation
            obj.SendComand('run;');
        end
        function FindModes(obj)
            % finde modes of eigenmode analysis window
            obj.SendComand('findmodes;');
        end
        function Select(obj, name)
            % select object in lumerical tree
            comand = char(['select("' char(name) '");']);
            obj.SendComand(comand);
        end
        function SwitchToLayout(obj)
            % switch to layout mode
            obj.SendComand('switchtolayout;');
        end
        function SelectMode(obj, mod_num)
            % switch to layout mode
            comand = char(['selectmode( ' num2str(mod_num) ' );']);
            obj.SendComand( comand );
        end
        function SetObject(obj, onject_name, varargin)
            % select object and set paramiters of it
            obj.Select(onject_name);
            obj.Set(varargin{:});
        end
        function SetModel(obj, varargin)
            % set paramiters in the model
            obj.SetObject("::model", varargin{:});
        end

        function SetAnalysis(obj, varargin)
            % set parameters of analysis (eigenmode analysis)
            while ~isempty(varargin)
                if ~isstring(varargin{2}) || ~ischar(varargin{2})
                    varargin{2} = num2str(varargin{2});
                else
                    varargin{2} = ['"' char(varargin{2}) '"'];
                end
                comand = char(['setanalysis("' char(varargin{1}) '",' char(varargin{2}) ');']);
                obj.SendComand(comand);
                varargin(1:2) = [];
            end
        end
        function Transmittance = GetTransmitance(obj, monitor)
            % get transmittance from pointed monitor
            Transmittance = getTransmitance(obj, monitor);
        end
        function Power = GetPower(obj,monitor)
            Power = getPower(obj, monitor);
        end
        function E = GetEField(obj, monitor)
            E = getEField(obj, monitor);
        end
        function DeleteAll(obj)
            % delete all objects in model
            obj.SendComand('deleteall;');
        end
        function Delete(obj)
            % delete objects in model
            obj.SendComand('delete;');
        end
        function LoadFile(obj, filename)
            % load Lumerical file (same as open)
            obj.SendComand(['load("' filename '");']);
        end
    end
end

