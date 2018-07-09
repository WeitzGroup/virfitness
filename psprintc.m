function psprintc(filename)
% Helper scripts for Weitz et al.
% Viral Fitness Across a Continuum from Lysis to Latency
% GPL 3.0 license - distributed via github
%
% Helper scripts modified from 
% originals developed by Peter Dodds @ MIT in the 1990s (!!)
%
% psprint('filename')
% prints current figure with 
% the following flags
% -depsc2
% .ps will be appended
%
% print in color
filenameps = sprintf('%s.ps',filename);
print(filenameps,'-depsc2');
filenamjpg = sprintf('%s.jpg',filename);
print(filenamjpg,'-djpeg80');
