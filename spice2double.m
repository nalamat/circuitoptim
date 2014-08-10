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

function [vals] = spice2double(strs)
	exps = {
		'\s'                        ''    ;    % Ignore whitespaces
		'(?<=[-+.\d]+)a(?!mps).*'   'e-18';    % Atto
		'(?<=[-+.\d]+)f.*'          'e-15';    % Femto
		'(?<=[-+.\d]+)p.*'          'e-12';    % Pico
		'(?<=[-+.\d]+)n.*'          'e-9' ;    % Nano
		'(?<=[-+.\d]+)u.*'          'e-6' ;    % Micro
		'(?<=[-+.\d]+)m(?!eg).*'    'e-3' ;    % Milli
		'(?<=[-+.\d]+)k.*'          'e3'  ;    % Kilo
		'(?<=[-+.\d]+)(x|meg).*'    'e6'  ;    % Mega
		'(?<=[-+.\d]+)g.*'          'e9'  ;    % Giga
		'(?<=[-+.\d]+)t.*'          'e12' ;    % Tera
		'(?<=[-+.\d]+)[^-+.\d]*$'   ''    };   % Ignore engineering units
	
	strs = regexprep(strs, exps(:,1), exps(:,2), 'ignorecase');
	
	vals = str2double(strs);
end
