% Plotting scripts for 
% Weitz et al.
% Viral Fitness Across a Continuum from Lysis to Latency
% GPL 3.0 license - distributed via github
clf;
% automatically create postscript whenever
% figure is drawn
tmpfilename = 'figcritS_ly';
tmpfilebwname = sprintf('%s_noname_bw',tmpfilename);
tmpfilenoname = sprintf('%s_noname',tmpfilename);

tmpprintname = fixunderbar(tmpfilename);
% for use with xfig and pstex
tmpxfigfilename = sprintf('x%s',tmpfilename);

tmppos= [0.2 0.2 0.7 0.7];
tmpa1 = axes('position',tmppos);

set(gcf,'DefaultLineMarkerSize',10);
% set(gcf,'DefaultLineMarkerEdgeColor','k');
% set(gcf,'DefaultLineMarkerFaceColor','w');
set(gcf,'DefaultAxesLineWidth',2);

% set(gcf,'PaperPositionMode','auto');
set(gcf,'position', [383 287 637 518]);

% Assigns parameters & variables
info.omega=0.75; %hr^-1
info.R0=0.95;      % ug/ml
info.eps=10^8; % cells per ug
info.gamma=10^-8; % ml/cells/hr
info.phi=6.7*10^-10;    %ml/cells/hr
info.beta=50;   % burst size
info.betamod=info.beta-1;
info.maxT=500;  % hrs
info.r=info.eps*info.gamma*info.R0;
info.d=1/4;	% hrs^-1
info.m=1/24;	% hrs^-1
info.K=info.omega/info.gamma;
info.Nstar = info.m/(info.phi*info.betamod);
info.Vstar = 1/info.phi*(info.r*(1-info.Nstar/info.K)-info.d);

% Critical
beta=5:1:500;
Scrit=info.m./(info.phi*(beta-1));

% main data goes here

% Dividing line
tmph=loglog(beta,Scrit,'k-');
set(tmph,'linewidth',3);
hold on

% Patch between good/bad
tmpa = patch([beta 500 5 5],[Scrit 10^8 10^8 Scrit(1)],[0.8 0.8 0.8]);

% Contour of fitness
[gX gY]=meshgrid(logspace(log10(5),log10(500)),logspace(5,8));
Rhor = gX.*(info.phi*gY)./(info.phi*gY+info.m);
[c,h]=contour(gX,gY,log10(Rhor),linspace(-2,2,20));
cbar = colorbar
cbary= get(cbar,'ylabel');
set(cbary,'string','Log$_{10}$ Fitness','interpreter','latex','fontsize',20);

% Annotations
tmpt1 = text(80,10^7,'Invasion');
set(tmpt1,'backgroundcolor',[0.8 0.8 0.8],'fontsize',18,'interpreter','latex');
tmpt1 = text(10,10^5.5,'Extinction');
set(tmpt1,'backgroundcolor',[1 1 1],'fontsize',18,'interpreter','latex');
% loglog(,, '');

%
%
% Some helpful plot commands
% tmph=plot(x,y,'ko');
% set(tmph,'markersize',10,'markerfacecolor,'k');
% tmph=plot(x,y,'k-');
% set(tmph,'linewidth',2);

set(gca,'fontsize',20);

% for use with layered plots
% set(gca,'box','off')

% adjust limits
% tmpv = axis;
% axis([]);
% ylim([]);
xlim([5 500]);

% change axis line width (default is 0.5)
% set(tmpa1,'linewidth',2)

% fix up tickmarks
set(gca,'xtick',[5 10 25 50 100 200 400]);
set(gca,'ytick',10.^[5:8]);

% creation of postscript for papers
% psprint(tmpxfigfilename);

% the following will usually not be printed 
% in good copy for papers
% (except for legend without labels)

% legend
% tmplh = legend('stuff',...);
% tmplh = legend('','','');
% remove box
% set(tmplh,'visible','off')
% legend('boxoff');

xlabel('Burst size, $\beta$','fontsize',20,'verticalalignment','top','interpreter','latex');
ylabel('Susceptible population, $S$','fontsize',20,'verticalalignment','bottom','interpreter','latex');
title('Fitness of lytic phage','fontsize',24,'interpreter','latex')
% 'horizontalalignment','left');

% for writing over the top
% coordinates are normalized again to (0,1.0)
tmpa2 = axes('Position', tmppos);
set(tmpa2,'visible','off');
% first two points are normalized x, y positions
% text(,,'','Fontsize',14);

% automatic creation of postscript
% without name/date
psprintc(tmpfilenoname);
psprint(tmpfilebwname);

tmpt = pwd;
tmpnamememo = sprintf('[source=%s/%s.ps]',tmpt,tmpprintname);
text(1.05,.05,tmpnamememo,'Fontsize',6,'rotation',90);
datenamer(1.1,.05,90);
% datename(.5,.05);
% datename2(.5,.05); % 2 rows

% automatic creation of postscript
psprintc(tmpfilename);

% set following on if zooming of 
% plots is required
% may need to get legend up as well
%axes(tmpa1)
%axes(tmplh)
clear tmp*
