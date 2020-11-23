classdef RG < matlab.mixin.SetGet
    % This is the Rhythm Generator part of the CPG module.
    % Usually an Rhythm Generator is composed of 4 neurons That is: 
    %       RG EXT; RG FLX; RG EXT In and RG FLX In.
    % 
    % And there is 6 synapses between them:
    %    RG EXT --> RG EXT In; RG FLX --> RG FLX In 
    %    RG EXT In --* RG FLX; RG FLX In --* RG EXT
    %    RG EXT --> RG FLX ; RG FLX --> RG EXT
    
    properties
        C
    end % End properties
    
    methods
    end % End methods
    
end % End Class