%% AERO 433: Experimental Stress Analysis
% Author: Justin Self

% Housekeeping 
clear all; close all; clc;

%% Constants
% Aluminum alloy 3004
ElasticModWall = 69e9; % GPa to Pa
PoissonRatioWall = 0.33;
wallThickness = 0.1e-3; % mm to m

%% Bad Run Data - commented out since not needed
% raw = readmatrix("bad_run2.TXT");
% A = raw(:,2);
% B = raw(:,3);
% 
% % Time vectors for numeric values
% ta = find(~isnan(A));
% tb = find(~isnan(B));
% 
% % Extract non NaN values from raw data
% A = A(~isnan(A));
% B = B(~isnan(B));
% 
% % Remove the outlier in the data
% figure()
% % Hoop
% % Plot before the outlier
% p1 = plot(ta(1:10),A(1:10),'-square','LineWidth',1);
% p1.Color = 'b';
% hold on
% % Plot after the outlier
% p2 = plot([ta(10) ta(12)],[A(10) A(12)],'-square','LineWidth',1);
% p2.Color = 'b';
% 
% % Longitudinal 
% p3 = plot(tb,B,'-o','LineWidth',1);
% p3.Color = 'r';
% 
% % Annotation
% dim = [.2 .3 .3 .3];
% str = 'One outlier removed';
% annotation('textbox',dim,'String',str,'FitBoxToText','on');
% 
% % Graph pretty 
% ylim padded 
% xlim tight 
% xLab = xlabel('Time [s]','Interpreter','latex'); 
% yLab = ylabel('Microstrain [$\mu \epsilon$]','Interpreter','latex'); 
% plotTitle = title('Run 2: Microstrain During Aluminum Can Opening','interpreter','latex'); 
% set(plotTitle,'FontSize',14,'FontWeight','bold') 
% set(gca,'FontName','Palatino Linotype') 
% set([xLab, yLab],'FontName','Palatino Linotype') 
% set(gca,'FontSize', 9) 
% set([xLab, yLab],'FontSize', 14) 
% grid on 
% legend('Hoop','','Longitudinal', 'interpreter','latex','Location', 'best')

%% Plot Savannah's dataraw = readmatrix("justin.TXT");

raw = readmatrix("Savannah_run4.TXT");
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
p2 = plot(tb,B,'-d','LineWidth',1);
p2.Color = '#808080';

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

% attempted data correction of longitudinal stress
fudgeFactor = mean(B(1:5));
B_adjusted = B - fudgeFactor;
plot(ta,B_adjusted,'-o','LineWidth',1,'Color','r')

legend('Hoop','Longitudinal (raw)',"Longitudinal",'interpreter','latex','Location', 'best')

%% plot run 1 - Will

raw = readmatrix("will_run1.TXT");
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
plotTitle = title('Will: Microstrain During Aluminum Can Opening','interpreter','latex'); 
set(plotTitle,'FontSize',14,'FontWeight','bold') 
set(gca,'FontName','Palatino Linotype') 
set([xLab, yLab],'FontName','Palatino Linotype') 
set(gca,'FontSize', 9) 
set([xLab, yLab],'FontSize', 14) 
grid on 
legend('Hoop','Longitudinal','interpreter','latex','Location', 'best')

% stress - strain curve
strainLong = B*1e-6;
strainHoop = A*1e-6;
stressLong = (ElasticModWall*(strainLong+PoissonRatioWall*strainHoop))/(1-PoissonRatioWall^2);
stressHoop = (ElasticModWall*(strainHoop+PoissonRatioWall*strainLong))/(1-PoissonRatioWall^2);

strainLongBefore = mean(strainLong(1:4));
strainLongAfter = mean(strainLong(7:end));
strainHoopBefore = mean(strainHoop(1:4));
strainHoopAfter = mean(strainHoop(7:end));

stressLongBefore = mean(stressLong(1:4));
stressLongAfter = mean(stressLong(7:end));
stressHoopBefore = mean(stressHoop(1:4));
stressHoopAfter = mean(stressHoop(7:end));

disp("Run 1")
disp("Before:")
disp("L strain = " + strainLongBefore)
disp("H strain = " + strainHoopBefore)
disp("L stress = " + stressLongBefore + " Pa")
disp("H stress = " + stressHoopBefore + " Pa")
disp("After:")
disp("L strain = " + strainLongAfter)
disp("H strain = " + strainHoopAfter)
disp("L stress = " + stressLongAfter + " Pa")
disp("H stress = " + stressHoopAfter + " Pa")

figure("Name"," Longitudinal Stress-Strain Curve")
plot(strainLong,stressLong,'-o')
title("Longitudinal Stress-Strain Curve")
xlabel("\epsilon_L")
ylabel("\sigma_L [Pa]")

figure('Name',"Hoop Stress-Strain Curve")
plot(strainHoop,stressHoop,'-o')
title("Hoop Stress Strain Curve")
xlabel("\epsilon_H")
ylabel("\sigma_H [Pa]")

% stress ratio
stressRatio = mean(stressHoop(12:end)./stressLong(12:end));
disp("Run 1 - Stress Ratio (H/L) = " + stressRatio)

%% plot Justin run 3

raw = readmatrix("justin_run3.TXT");
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
plotTitle = title('Justin: Microstrain During Aluminum Can Opening','interpreter','latex'); 
set(plotTitle,'FontSize',14,'FontWeight','bold') 
set(gca,'FontName','Palatino Linotype') 
set([xLab, yLab],'FontName','Palatino Linotype') 
set(gca,'FontSize', 9) 
set([xLab, yLab],'FontSize', 14) 
grid on 
legend('Hoop','Longitudinal','interpreter','latex','Location', 'best')

% stress - strain curve
strainLong = B(1:length(A))*1e-6;
strainHoop = A*1e-6;

strainLongBefore = mean(strainLong(1:9));
strainLongAfter = mean(strainLong(10:end));
strainHoopBefore = mean(strainHoop(1:9));
strainHoopAfter = mean(strainHoop(10:end));

stressLong = (ElasticModWall*(strainLong+PoissonRatioWall*strainHoop))/(1-PoissonRatioWall^2);
stressHoop = (ElasticModWall*(strainHoop+PoissonRatioWall*strainLong))/(1-PoissonRatioWall^2);

stressLongBefore = mean(stressLong(1:9));
stressLongAfter = mean(stressLong(10:end));
stressHoopBefore = mean(stressHoop(1:9));
stressHoopAfter = mean(stressHoop(10:end));

disp("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
disp("Run 3")
disp("Before:")
disp("L strain = " + strainLongBefore)
disp("H strain = " + strainHoopBefore)
disp("L stress = " + stressLongBefore + " Pa")
disp("H stress = " + stressHoopBefore + " Pa")
disp("After:")
disp("L strain = " + strainLongAfter)
disp("H strain = " + strainHoopAfter)
disp("L stress = " + stressLongAfter + " Pa")
disp("H stress = " + stressHoopAfter + " Pa")

figure("Name"," Longitudinal Stress-Strain Curve")
plot(strainLong,stressLong,'-o')
title("Longitudinal Stress-Strain Curve")
xlabel("\epsilon_L")
ylabel("\sigma_L [Pa]")

figure('Name',"Hoop Stress-Strain Curve")
plot(strainHoop,stressHoop,'-o')
title("Hoop Stress Strain Curve")
xlabel("\epsilon_H")
ylabel("\sigma_H [Pa]")

% stress ratio
stressRatio = mean(stressHoop(10:end)./stressLong(10:end));
disp("Run 3 - Stress Ratio (H/L) = " + stressRatio)