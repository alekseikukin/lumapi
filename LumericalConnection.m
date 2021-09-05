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
            current_version = 'v202';
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
                    otherwise
                        errore('unknown paramiter')
                end
                varargin(1:2) = [];
            end
            path(path,[HDD path_to_folder current_version '\api\matlab\']);
            
            obj.currentConnection =  appopen(type);
        end
        
        function [] = SendComand(obj,varargin)
            %METHOD1 Summary of this method goes here
            %
            code = strcat(varargin{ : });
            appevalscript(obj.currentConnection,code);
        end
        function [] = SendVar(obj,varName,varVal)
            %METHOD1 Summary of this method goes here
            %
            
            appputvar(obj.currentConnection,varName, varVal);
        end
        function result = GetVar(obj,varName)
            %METHOD1 Summary of this method goes here
            %
            result = appgetvar(obj.currentConnection,varName);
            
        end
        function AppClose(obj)
            appclose(obj.currentConnection);
        end
        function ImportGDS(obj, file_name, cell_name, varargin)
            importGDS(obj,...
                file_name,...
                cell_name,...
                varargin{:})
        end
        
        function Set(obj, name, value)
            SetParam(obj, name, value);
        end
        function AddRect(obj, varargin)
            addRect(obj, varargin{:});
        end
        function AddFDTD(obj, varargin)
            addFDTD(obj, varargin{:});
        end
        function AddVarFDTD(obj, varargin)
            addVarFDTD(obj, varargin{:});
        end
        function AddSource(obj, varargin)
            addSource(obj, varargin{:});
        end
        function AddPower(obj, varargin)
            addPower(obj, varargin{:});
        end
        
        function Save(obj, name)
            
            obj.SendComand(['save("' name '");']);
        end
        function Run(obj)
            
            obj.SendComand('run;');
        end
        function SwitchToLayout(obj)
            obj.SendComand('switchtolayout;');
        end
        function Transmittance = GetTransmitance(obj, monitor)
            Transmittance = getTransmitance(obj, monitor);
        end
        function DeleteAll(obj)
            
            obj.SendComand('deleteall;');
        end
    end
end

