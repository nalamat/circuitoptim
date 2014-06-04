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
		
		[line_params line_split] = regexpi(line, '(?<!\*.*)(?<=\[)[-+.\da-z \t]*(?=\])', 'match', 'split');
		line_options = regexpi(line, '(?<=\*\*.*)(?<=\[)[-+.\da-z \t,;]*(?=\])', 'match');
		
		c = min(length(line_params), length(line_options));
		
		for i=1:c
			option = regexpi(line_options{i}, '[-+.\da-z]*', 'match');
			if (length(option) < 2); continue; end
			lb = val2double(option{1});
			ub = val2double(option{2});
			if (isempty(lb) || isempty(ub)); continue; end
			if (length(option) < 3); option{3} = ''; end
			scale = lower(option{3});
			if (strcmp(scale, 'lin') == 0); scale = 'dec'; end
			
			params  = [params , val2double(line_params{i})];
			options = [options, struct('lb',lb, 'ub',ub, 'scale',scale)];
			line_params{i} = '%s';
		end
		
		% replace valid params with a '%s' in the current line,
		% these replacements are later used to generate altered netlists
		if (length(line_params) < length(line_split)); line_params = [line_params {''}]; end
		if (length(line_params) > length(line_split)); line_split  = [line_split  {''}]; end
		line = strjoin(reshape(vertcat(line_split, line_params), 1, length(line_split)*2), '');

		if (isempty(content))
			content = line;
		else
			content = [content, '\r\n', line];
		end
	end
	
	fclose(f);
end
