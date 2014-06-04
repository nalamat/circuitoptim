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

function circuitoptim(netlist_path, cost_func, output_path)
	% Check for availability of hspice.exe
	[status, ~] = system('cmd /C "hspice -v"');
	if (status)
		error('HSPICE is either not installed or not included in the path');
	end
	
	% Create a temp directory for generated netlist and simulation output files
	temp_dir = [tempdir, 'circuitoptim'];
	[status, ~] = rmdir(temp_dir);
	[status, ~] = mkdir(temp_dir);
	if (~status)
		error(['Cannot create temp directory ''', temp_dir, '''']);
	end
	
	[content, params, options] = read_sp(netlist_path);
	
	
end
