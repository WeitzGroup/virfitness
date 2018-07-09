% Plotting scripts for 
% Weitz et al.
% Viral Fitness Across a Continuum from Lysis to Latency
% GPL 3.0 license - distributed via github
% automatically create postscript whenever
% figure is drawn
clf;
tmpfilename = 'figR0horver_temp_contrast_v2';
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
info.beta=100;   % burst size
info.betamod=info.beta-1;
info.maxT=500;  % hrs
info.r=info.eps*info.gamma*info.R0;
info.d=1/4;	% hrs^-1
info.m=3/24;	% hrs^-1
info.K=info.omega/info.gamma;

% Critical
% Horizontal fitness
S=logspace(4.5,7.5,1000);
Rhor=info.beta*info.phi*S./(info.phi*S+info.m);
% Plot to establish the axes
tmph=loglog(S,Rhor,'r-');
set(tmph,'linewidth',1);
hold on

% Vertical fitness
vfactor = 1.75;
info.dprime=info.d*vfactor;
info.rprime=info.r/vfactor;
Rver=info.rprime.*(1-S/info.K)/info.dprime;
% Rver = info.rprime*info.d/(info.r*info.dprime)*ones(1,length(S));
tmph=loglog(S,Rver,'b-');
set(tmph,'linewidth',1);

% Chronic viruses
chron.dprime=info.d*2.5;
chron.rprime=info.r/1.4;
chron.alpha=20;  
chron.phi=info.phi/2;
chron.m=1/24;
Rtot_chron = chron.alpha/chron.dprime.*(chron.phi*S)./(chron.phi*S+chron.m)+chron.rprime.*(1-S/info.K)/chron.dprime;
tmph=loglog(S,Rtot_chron,'g-');
set(tmph,'linewidth',1);

% Now get the maxima
Rvals = [Rhor; Rver; Rtot_chron]; 
[Rmax, Vtype]=max(Rvals);

% Hor regime
tmpi=find(Vtype==1);
Smin=S(tmpi(1));
Smax=S(tmpi(end));
tmph=patch([Smin Smax Smax Smin Smin],[10^-1 10^-1 10^1.25 10^1.25 10^-1],[0.5 0.5 0.5]);
hold on

% Chronic regime
tmpi=find(Vtype==3);
Smin=S(tmpi(1)-1);
Smax=S(tmpi(end)+1);
tmph=patch([Smin Smax Smax Smin Smin],[10^-1 10^-1 10^1.25 10^1.25 10^-1],[0.9 0.9 0.9]);

% Vertical regime
tmpi=find(Vtype==2);
Smin=S(tmpi(1));
Smax=S(tmpi(end));
tmph=patch([Smin Smax Smax Smin Smin],[10^-1 10^-1 10^1.25 10^1.25 10^-1],[0.7 0.7 0.7]);

% Overlay fitness
% Highlight horizontal
tmph=loglog(S,Rhor,'r-');
set(tmph,'linewidth',1);
tmpi=find(Vtype==1);
tmph=loglog(S(tmpi(1):tmpi(end)),Rhor(tmpi(1):tmpi(end)),'r-');
set(tmph,'linewidth',4);

% Highlight chronic
tmph=loglog(S,Rtot_chron,'g-');
set(tmph,'linewidth',1);
tmpi=find(Vtype==3);
tmph=loglog(S(tmpi(1):tmpi(end)),Rtot_chron(tmpi(1):tmpi(end)),'g-');
set(tmph,'linewidth',4);

% Highight vertical
tmph=loglog(S,Rver,'b-');
set(tmph,'linewidth',1);
tmpi=find(Vtype==2);
tmph=loglog(S(tmpi(1):tmpi(end)),Rver(tmpi(1):tmpi(end)),'b-');
set(tmph,'linewidth',4);



% Baseline
tmph=loglog([10^4 10^8],[1 1],'k--');
set(tmph,'linewidth',3);

% Annotations
% Patches
tmpt1 = text(10^4.9,10^-0.8,{'Vertical';'dominant'});
set(tmpt1,'fontsize',16,'interpreter','latex');
tmpt2 = text(10^5.9,10^-0.8,{'Mixed';'dominant'});
set(tmpt2,'fontsize',16,'interpreter','latex');
tmpt3 = text(10^6.7,10^-0.8,{'Horizontal';'dominant'});
set(tmpt3,'fontsize',16,'interpreter','latex');

% Lines
tmpt1 = text(10^5.2,1.5,'${\cal{R}}_{ver}$');
set(tmpt1,'fontsize',16,'interpreter','latex');
tmpt2 = text(10^6.05,10^0.22,'${\cal{R}}_{chron}$');
set(tmpt2,'fontsize',16,'interpreter','latex','rotation',20);
tmpt3 = text(10^6.66,10^0.53,'${\cal{R}}_{hor}$','rotation',45);
set(tmpt3,'fontsize',16,'interpreter','latex');
%tmpt1 = text(10^4.1,10^1,'Fitness benefits of lysogeny');
%set(tmpt1,'fontsize',12,'interpreter','latex');
%tmpt1 = text(10^4.1,10^-0.55,{'High fitness costs';'of lysogeny'});
%set(tmpt1,'fontsize',12,'interpreter','latex');
%set(tmpt1,'backgroundcolor',[1 1 1],'fontsize',18,'interpreter','latex');
%tmpt1 = text(10,10^5.5,'Extinction');
%set(tmpt1,'backgroundcolor',[1 1 1],'fontsize',18,'interpreter','latex');
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
xlim([10^4.8 10^7.4]);
ylim([10^-1 10^1.1]);

% change axis line width (default is 0.5)
% set(tmpa1,'linewidth',2)

% fix up tickmarks
set(gca,'xtick',10.^[5:0.5:7]);
tmpt=10.^[5:0.5:7];
tmps=num2str(tmpt','%3.2g');
set(gca,'xticklabel',tmps);
set(gca,'ytick',10.^[-1:0.25:1]);
tmpt=10.^[-1:0.25:1];
tmps=num2str(tmpt','%3.2g');
set(gca,'yticklabel',tmps);
set(gca,'Layer','top');

% creation of postscript for papers
% psprint(tmpxfigfilename);

% the following will usually not be printed 
% in good copy for papers
% (except for legend without labels)

% legend
% tmplh = legend('stuff',...);
% tmplh = legend('${\cal{R}}_{hor}$','${\cal{R}}_{ver}$',2);
% remove box
% set(tmplh,'visible','off')
%set(tmplh,'interpreter','latex','fontsize',18);
%legend('boxoff');

xlabel('Susceptible population, $S^{\ast}$','fontsize',20,'verticalalignment','top','interpreter','latex');
ylabel('Basic reproduction number, ${\cal{R}}_0$','fontsize',20,'verticalalignment','bottom','interpreter','latex');
% title('Fitness of temperate phage','fontsize',24,'interpreter','latex')
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
