classdef LumericalConnectionOld
    %LUMERICALCONNECTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        currentConnection
    end
    
    methods
        function obj = LumericalConnectionOld(varargin)
            %LUMERICALCONNECTION Construct an instance of this class
            %   type can be: 'mode', 'fdtd'
            type = 'mode';
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
            path(path,[HDD path_to_folder type '\bin']);
            
            obj.currentConnection = appopen(type);
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
    end
end

