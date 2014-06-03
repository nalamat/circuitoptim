%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                       %
% This file is a part of the CircuitOptim project:                      %
% A circuit optimization toolbox for MATLAB based on SPICE simulations  %
% Copyright (C) 2014 Nima Alamatsaz, All rights reserved                %
% Email: nnalamat@gmail.com                                             %
% Web:   http://github.com/nalamat/circuitoptim                         %
%                                                                       %
% CircuitOptim is free software: you can redistribute it and/or modify  %
% it under the terms of the GNU General Public License as published by  %
% the Free Software Foundation, either version 3 of the License, or     %
% any later version.                                                    %
%                                                                       %
% CircuitOptim is distributed in the hope that it will be useful,       %
% but WITHOUT ANY WARRANTY; without even the implied warranty of        %
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the          %
% GNU General Public License for more details.                          %
%                                                                       %
% You should have received a copy of the GNU General Public License     %
% along with CircuitOptim. If not, see <http://www.gnu.org/licenses/>.  %
%                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ content params options ] = read_sp( netlist_path )
	
	f = fopen(netlist_path, 'r');
	content = [];
	params  = [];
	options = [];
	
	while ( ~feof(f) )
		line = fgetl(f);
		
		line_params  = regexp(line, '(?<!\*.*)(?<=\[)[-+.\da-zA-Z \t]*(?=\])'    , 'match');
		line_options = regexp(line, '(?<=\*\*.*)(?<=\[)[-+.\da-zA-Z \t,;]*(?=\])', 'match');
		
		c = min(length(line_params), length(line_options));
		
		for i=1:c
			option = regexp(line_options{i}, '[-+.\da-zA-Z]*', 'match');
			if (length(option) < 2); continue; end
			lower = val2num(option{1});
			upper = val2num(option{2});
			if (isempty(lower) || isempty(upper)); continue; end
			scale = 'dec';
			if (length(option) > 2 && strcmp(lower(option{3}), 'lin'))
				scale = 'lin';
			end
			
			params  = horzcat(params, val2num(line_params{i}));
			options = horzcat(options, struct('lower',lower, 'upper',upper, 'scale',scale));
		end
		
		content = horzcat(content, '\r\n', line);
	end
	
	fclose(f);
end
