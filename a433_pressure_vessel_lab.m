% AERO 433: Experimental Stress Analysis
% Author: Justin Self

% Housekeeping 
clear all; close all; clc;

raw = readmatrix("justin.TXT");
A = raw(:,2);
B = raw(:,3);

% Time vectors for numeric values
ta = find(~isnan(A));
tb = find(~isnan(B));

% Extract non NaN values from raw data
A = A(~isnan(A));
B = B(~isnan(B));

% Remove the outlier in the data
figure()
% Hoop
% Plot before the outlier
p1 = plot(ta(1:10),A(1:10),'-square','LineWidth',1);
p1.Color = 'b';
hold on
% Plot after the outlier
p2 = plot([ta(10) ta(12)],[A(10) A(12)],'-square','LineWidth',1);
p2.Color = 'b';

% Longitudinal 
p3 = plot(tb,B,'-o','LineWidth',1);
p3.Color = 'r';

% Annotation
dim = [.2 .3 .3 .3];
str = 'One outlier removed';
annotation('textbox',dim,'String',str,'FitBoxToText','on');

% Graph pretty 
ylim padded 
xlim tight 
xLab = xlabel('Time [s]','Interpreter','latex'); 
yLab = ylabel('Microstrain [$\mu \epsilon$]','Interpreter','latex'); 
plotTitle = title('Justin Microstrain During Aluminum Can Opening','interpreter','latex'); 
set(plotTitle,'FontSize',14,'FontWeight','bold') 
set(gca,'FontName','Palatino Linotype') 
set([xLab, yLab],'FontName','Palatino Linotype') 
set(gca,'FontSize', 9) 
set([xLab, yLab],'FontSize', 14) 
grid on 
legend('Hoop','','Longitudinal', 'interpreter','latex','Location', 'best')

%% Plot Savannah's dataraw = readmatrix("justin.TXT");

raw = readmatrix("Savannah.TXT");
A = raw(:,2);
B = raw(:,3);

% Time vectors for numeric values
ta = find(~isnan(A));
tb = find(~isnan(B));

% Extract non NaN values from raw data
A = A(~isnan(A));
B = B(~isnan(B));

figure()
% Hoop
p1 = plot(ta,A,'-square','LineWidth',1);
p1.Color = 'b';

hold on
% Longitudinal
p2 = plot(tb,B,'-o','LineWidth',1);
p2.Color = 'r';

% Graph pretty 
ylim padded 
xlim tight 
xLab = xlabel('Time [s]','Interpreter','latex'); 
yLab = ylabel('Microstrain [$\mu \epsilon$]','Interpreter','latex'); 
plotTitle = title('Savannah: Microstrain During Aluminum Can Opening','interpreter','latex'); 
set(plotTitle,'FontSize',14,'FontWeight','bold') 
set(gca,'FontName','Palatino Linotype') 
set([xLab, yLab],'FontName','Palatino Linotype') 
set(gca,'FontSize', 9) 
set([xLab, yLab],'FontSize', 14) 
grid on 
legend('Hoop','Longitudinal','interpreter','latex','Location', 'best')

