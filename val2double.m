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

function [vals] = val2double(strs)
	multis(1 ) = struct('symbol', 'meg', 'value', 'e6'  );
	multis(2 ) = struct('symbol', 'a'  , 'value', 'e-18');
	multis(3 ) = struct('symbol', 'f'  , 'value', 'e-15');
	multis(4 ) = struct('symbol', 'p'  , 'value', 'e-12');
	multis(5 ) = struct('symbol', 'n'  , 'value', 'e-9' );
	multis(6 ) = struct('symbol', 'u'  , 'value', 'e-6' );
	multis(7 ) = struct('symbol', 'm'  , 'value', 'e-3' );
	multis(8 ) = struct('symbol', 'k'  , 'value', 'e3'  );
	multis(9 ) = struct('symbol', 'x'  , 'value', 'e6'  );
	multis(10) = struct('symbol', 'g'  , 'value', 'e9'  );
	multis(11) = struct('symbol', 't'  , 'value', 'e12' );
	
	if (iscell(strs))
		for i=1:length(strs)
			for j=1:length(multis)
				strs{i} = regexprep(strs{i}, multis(j).symbol, multis(j).value, 'ignorecase');
			end
		end
	else
		for j=1:length(multis)
			strs = regexprep(strs, multis(j).symbol, multis(j).value, 'ignorecase');
		end
	end

	vals = str2double(strs);
end
