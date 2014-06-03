%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                       %
% This file is a part of the CircuitOptim project:                      %
% A circuit optimization toolbox for MATLAB based on SPICE simulations  %
% Copyright (C) 2014, Nima Alamatsaz, All rights reserved               %
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

function [ lines mosfet_names mosfet_l mosfet_w volt_b ] = read_sp( netlist_path )
	
	f = fopen(netlist_path, 'r');
	mosfet_names = [];
	mosfet_l = [];
	mosfet_w = [];
	lines = [];
	
	while ( ~feof(f) )
		line = fgetl(f);
		
		a1 = regexp( line, '^m[\w\d]+', 'match' );
		a2 = regexp( line, '^vb', 'match' );
		if ( ~isempty(a1) )
			mosfet_names = [ mosfet_names a1(1) ];
			
			a1 = regexp( line, '[\w\d.+-]+', 'match' );
			mosfet_l = [ mosfet_l prefix2double(a1{7}) ];
			mosfet_w = [ mosfet_w prefix2double(a1{8}) ];
			
			a1 = regexprep( line, '[\w\d.+-]+\s+[\w\d.+-]+$', '%s %s');
			lines = [ lines {a1} ];
			
			%fprintf('%s\tL=%e\tW=%e\n', mosfet_name, mosfet_l, mosfet_w);
		elseif ( ~isempty(a2) )
			a1 = regexp( line, 'dc\s+([\w\d.+-]+)', 'tokens' );
			volt_b = prefix2double(a1{1}{1});
			
			a1 = regexprep( line, 'dc\s+([\w\d.+-]+)', 'dc %s' );
			lines = [ lines {a1} ];
		else
			lines = [ lines {line} ];
		end
	end
	
	%lines
	fclose(f);
end
