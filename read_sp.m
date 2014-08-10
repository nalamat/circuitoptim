%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                       %
% This file is a part of the CircuitOptim project:                      %
% A circuit optimization toolbox for MATLAB based on SPICE simulations  %
% Copyright (C) 2014 Nima Alamatsaz, All rights reserved                %
% Email: nialamat@gmail.com                                             %
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

function [content, params] = read_sp(netlist_path)
	
	file     = fopen(netlist_path, 'r');
	cleanup1 = onCleanup(@()fclose(file));
	content  = [];
	lines    = [];
	params   = [];
	
	while ( ~feof(file) )
		line = fgetl(file);
		
		% Escape % symbols in the current line
		line = regexprep(line, '%', '%%');
		
		[values, split] = regexpi(line, '(?<!\*.*)(?<=\[)\s*[-+.\da-z]+\s*(?=\])', 'match', 'split');
		options = regexpi(line, '(?<=[^\*]\*{2}[^\*].*)(?<=\[)[-+.\da-z\s,;]+(?=\])', 'match');
		
		c = min(length(values), length(options));
		
		for i=1:c
			value = spice2double(values{i});
			if (isnan(value)); continue; end;
			option = regexpi(options{i}, '[-+.\da-z]*', 'match');
			if (length(option) < 2); continue; end
			lbound = spice2double(option{1});
			ubound = spice2double(option{2});
			if (isnan(lbound) || isnan(ubound)); continue; end
			dec = 1;
			if (length(option) > 2 && strcmpi(option{3},'lin')); dec = 0; end
			
			param = struct('value',value, 'lbound',lbound, 'ubound',ubound, 'dec',dec);
			params = [params, param];
			values{i} = '%.12e';
		end
		
		% Replace valid params with a '%s' in the current line,
		% these replacements are later used to generate altered netlists
		if (length(values) < length(split)); values = [values, {''}]; end
		if (length(values) > length(split)); split  = [split , {''}]; end
		
		line = strjoin(reshape(vertcat(split, values), 1, length(split)*2), '');
		
		lines = [lines, {line}];
	end
	
	content = strjoin(lines, '\n');
	
end
