clear; close all; clc;

files = dir('*.mat');
data = struct([]);
heights = [];
heightsCAD = [];
widthsX = [];
widthsXCAD = [];
widthsX_cut = [];
widthsXCAD_cut = [];
widthsY = [];
widthsYCAD = [];
widthsY_cut = [];
widthsYCAD_cut = [];
 for i = 1:length(files)
     load(files(i).name);
     data(i).results = results;
     heights = [heights; results.heights];
     heightsCAD = [heightsCAD; results.heightsCAD];
     switch results.dim
         case 'x'
             widthsX = [widthsX; results.widths];
             widthsXCAD = [widthsXCAD; results.widthsCAD];
             widthsX_cut = [widthsX_cut; results.widths_cut];
             widthsXCAD_cut = [widthsXCAD_cut; results.widthsCAD_cut];
         case 'y'
             widthsY = [widthsY; results.widths];
             widthsYCAD = [widthsYCAD; results.widthsCAD];
             widthsY_cut = [widthsY_cut; results.widths_cut];
             widthsYCAD_cut = [widthsYCAD_cut; results.widthsCAD_cut];
     end
 end
 
% Out-of-plane linear fit
lineZ = fitlm(heightsCAD,heights);
figure
plot(lineZ)
xticks(unique(heightsCAD))
yticks(unique(heightsCAD))
grid on
title('Straight line fit to measured step heights vs CAD heights')
xlabel('CAD dimensions (um)')
ylabel('Measured dimensions (um)')
zline = strcat('z=',num2str(lineZ.Coefficients.Estimate(1)),'+',num2str(lineZ.Coefficients.Estimate(2)),'*zCAD');
zRsq = strcat('R^2=',num2str(lineZ.Rsquared.Adjusted));
zN = strcat(num2str(length(heights)),' samples');
zmodel = {zline,zRsq,zN};
xlimit = xlim;
ylimit = ylim;
text((xlimit(2)+7*xlimit(1))/8,(ylimit(1)+3*ylimit(2))/4,zmodel)
% X linear fit
lineX = fitlm(widthsXCAD,widthsX);
figure
plot(lineX)
xticks(unique(widthsXCAD))
yticks(unique(widthsXCAD))
grid on
title('Straight line fit to measured step widths vs CAD widths')
xlabel('CAD dimensions (um)')
ylabel('Measured dimensions (um)')
xline = strcat('x=',num2str(lineX.Coefficients.Estimate(1)),'+',num2str(lineX.Coefficients.Estimate(2)),'*xCAD');
xRsq = strcat('R^2=',num2str(lineX.Rsquared.Adjusted));
xN = strcat(num2str(length(widthsX)),' samples');
xmodel = {xline,xRsq,xN};
xlimit = xlim;
ylimit = ylim;
text((xlimit(2)+7*xlimit(1))/8,(ylimit(1)+3*ylimit(2))/4,xmodel)
% X linear fit without top step
lineX_cut = fitlm(widthsXCAD_cut,widthsX_cut);
figure
plot(lineX_cut)
xticks(unique(widthsXCAD_cut))
yticks(unique(widthsXCAD_cut))
grid on
title('Straight line fit to measured step widths vs CAD widths WITHOUT TOP STEP')
xlabel('CAD dimensions (um)')
ylabel('Measured dimensions (um)')
xline_cut = strcat('x=',num2str(lineX_cut.Coefficients.Estimate(1)),'+',num2str(lineX_cut.Coefficients.Estimate(2)),'*xCAD');
xRsq_cut = strcat('R^2=',num2str(lineX_cut.Rsquared.Adjusted));
xN_cut = strcat(num2str(length(widthsX_cut)),' samples');
xmodel_cut = {xline_cut,xRsq_cut,xN_cut};
xlimit = xlim;
ylimit = ylim;
text((xlimit(2)+7*xlimit(1))/8,(ylimit(1)+3*ylimit(2))/4,xmodel_cut)
% Y linear fit
lineY = fitlm(widthsYCAD,widthsY);
figure
plot(lineY)
xticks(unique(widthsYCAD))
yticks(unique(widthsYCAD))
grid on
title('Straight line fit to measured step widths vs CAD widths')
xlabel('CAD dimensions (um)')
ylabel('Measured dimensions (um)')
yline = strcat('y=',num2str(lineY.Coefficients.Estimate(1)),'+',num2str(lineY.Coefficients.Estimate(2)),'*yCAD');
yRsq = strcat('R^2=',num2str(lineY.Rsquared.Adjusted));
yN = strcat(num2str(length(widthsY)),' samples');
ymodel = {yline,yRsq,yN};
xlimit = xlim;
ylimit = ylim;
text((xlimit(2)+7*xlimit(1))/8,(ylimit(1)+3*ylimit(2))/4,ymodel)
% Y linear fit without top step
lineY_cut = fitlm(widthsYCAD_cut,widthsY_cut);
figure
plot(lineY_cut)
xticks(unique(widthsYCAD_cut))
yticks(unique(widthsYCAD_cut))
grid on
title('Straight line fit to measured step widths vs CAD widths WITHOUT TOP STEP')
xlabel('CAD dimensions (um)')
ylabel('Measured dimensions (um)')
yline_cut = strcat('y=',num2str(lineY_cut.Coefficients.Estimate(1)),'+',num2str(lineY_cut.Coefficients.Estimate(2)),'*yCAD');
yRsq_cut = strcat('R^2=',num2str(lineY_cut.Rsquared.Adjusted));
yN_cut = strcat(num2str(length(widthsY_cut)),' samples');
ymodel_cut = {yline_cut,yRsq_cut,yN_cut};
xlimit = xlim;
ylimit = ylim;
text((xlimit(2)+7*xlimit(1))/8,(ylimit(1)+3*ylimit(2))/4,ymodel_cut)