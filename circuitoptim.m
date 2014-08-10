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

function circuitoptim(netlist_path, cost_func, output_path)
	% Check for availability of HSPICE and open it in client/server mode
	[res, ~  ] = system('cmd /C hspice -C');
	cleanup1   = onCleanup(@()cleanup_hspice());
	assert(res==0, 'HSPICE is either not installed or not included in the path');

	% Create a temp directory for generated netlist and simulation output files
	temp_dir   = [tempdir  , 'circuitoptim'];
	temp_file  = [temp_dir , '\circuit'    ];
	temp_sp    = [temp_file, '.sp'         ];
	[~  , ~  ] = rmdir(temp_dir, 's');
	[res, ~  ] = mkdir(temp_dir);
	cleanup2   = onCleanup(@()cleanup_dir(temp_dir));
	assert(res==1, 'Cannot create temp directory');
	
	% Validate the given netlist by simulating it
	[res, ~  ] = copyfile(netlist_path, temp_sp, 'f');
	assert(res==1, 'Cannot read the netlist file');
	[res, out] = system(sprintf('cmd /C hspice -i "%s" -o "%s"', temp_sp, temp_file));
	assert(res==0 && ~isempty(strfind(out, 'concluded')), 'Cannot simulate the netlist file');
	
	% Read the netlist
	[content, params] = read_sp(netlist_path);
	paramcount = length(params);
	
	% Start optimization using Genetic Algorithm
	%gaopts = gaoptimset('InitialPopulation', params);
	ga(@cost, paramcount, [], [], [], [], [params(:).lbound], [params(:).ubound]);
	
	function cost = cost(values)
		% Convert the scale of selected values
		values([params(:).dec]) = lin2dec(values([params(:).dec]));
		
		% Generate a new netlist by substituting test values
		write_sp(temp_sp, content, values);
		
		% Simulate the generated netlist
		[res, out] = system(sprintf('cmd /C hspice -i "%s" -o "%s"', temp_sp, temp_file));
		assert(res==0 && ~isempty(strfind(out, 'concluded')), 'Cannot simulate the netlist file');
		
		
		
		cost = 0;
	end
end

function cleanup_hspice()
	[~  , ~  ] = system('cmd /C hspice -C -K');
end

function cleanup_dir(temp_dir)
	[~  , ~  ] = rmdir(temp_dir, 's');
end
