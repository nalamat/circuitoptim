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
	multis = {
		'meg' 'e6'  ;
		'a'   'e-18';
		'f'   'e-15';
		'p'   'e-12';
		'n'   'e-9' ;
		'u'   'e-6' ;
		'm'   'e-3' ;
		'k'   'e3'  ;
		'x'   'e6'  ;
		'g'   'e9'  ;
		't'   'e12' };
	
	strs = regexprep(strs, multis(:,1), multis(:,2), 'ignorecase');
	
	vals = str2double(strs);
end
