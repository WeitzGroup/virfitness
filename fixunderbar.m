% Helper scripts for 
% Weitz et al.
% Viral Fitness Across a Continuum from Lysis to Latency
% GPL 3.0 license - distributed via github
%
% Helper scripts modified from 
% originals developed by Peter Dodds @ MIT in the 1990s (!!)
function outstring = fixunderbar(instring)
% outstring = fixunderbar(instring)
% replace "_" by "\_"
% in a string
%
% for use with matgraph
%
% uses sed
% and is cool
fid = fopen('tmp_tmp_tmp','w');
fprintf(fid,'%s',instring);
fclose(fid);
!sed -e 's/_/\\_/g' tmp_tmp_tmp > tmp_tmp_tmp2

fid = fopen('tmp_tmp_tmp2','r');
outstring = fscanf(fid,'%s');
fclose(fid);

!\rm tmp_tmp_tmp tmp_tmp_tmp2
