clear all;clc
crank = 100; connectingRod = 500; pluscrank = crank+50;
pointA = [0 0]; dirSliding = [0, 1];Force=100;
%DOF = theta
thetaDegrees = 270+60; %in degrees, accordingly to be used
thetaRadians = thetaDegrees*(pi/180.0);
thetaInitial = thetaRadians;

pointB = pointA + crank*[cos(thetaInitial) sin(thetaInitial)];
pointB1 = pointA + pluscrank*[cos(thetaInitial) sin(thetaInitial)];
slidingLineStart = pointA - 1250*dirSliding;   
dirSliding_perpendicular =[cosd(acosd(dirSliding(1))+90) sind(asind(dirSliding(2))+90)];
slidingLineEnd = pointA + 1250*dirSliding;
[pointC1, pointC2] = LineCircleIntersection(slidingLineStart, slidingLineEnd, pointB, connectingRod);
%choose one of the solutions as the branch/configuration (slider right/slider left)
%The same should be used for subsequent frames/steps of animation
pointC = pointC2;
figure(1)
set(gcf,'Position',[100 100 520 500]) % to have square shaped inner canvas
grid on
axis equal

theta = thetaRadians;   
pointB = pointA + crank*[cos(theta) sin(theta)];
pointB1 = pointA + pluscrank*[cos(theta) sin(theta)];
[pointC1, pointC2] = LineCircleIntersection(slidingLineStart, slidingLineEnd, pointB, connectingRod);
pointD = pointB + ((pointC - pointB)/connectingRod)*250;
pointM = pointB1+ ((pointD - pointB1)/norm(pointB1 - pointD))*500;
distBetweenPrevCandC1 = norm(pointC-pointC1);
distBetweenPrevCandC2 = norm(pointC-pointC2);
%Choose the solution that is nearest to the previous point C
if(distBetweenPrevCandC1 < distBetweenPrevCandC2)
pointC = pointC1;
else
pointC = pointC2;
end

sliderPointsXArray = [pointC(1)-20  pointC(1)+20  pointC(1)+20  pointC(1)-20  pointC(1)-20];
sliderPointsYArray = [pointC(2)-40  pointC(2)-40  pointC(2)+40  pointC(2)+40  pointC(2)-40];
direction_connecting_rod = (pointC-pointB)/norm(pointC-pointB);


direction_sliding_M = (pointM-pointB1)/norm(pointM-pointB1);
direction_crank = (pointB-pointA)/norm(pointB-pointA);
direction_connectingrod= (pointC-pointB)/norm(pointC-pointB);
direction_connectingrod_perpendicular = [cosd(acosd(direction_connectingrod(1))+90) sind(asind(direction_connectingrod(2))+90)];
direction_outputlink=(pointB1-pointM)/norm(pointB1-pointM);
direction_rotating_M = [cosd(acosd(direction_sliding_M(1))+90) sind(asind(direction_sliding_M(2))+90)];
plot([pointA(1) pointB(1)], [pointA(2) pointB(2)],'r-o','MarkerSize',1,'LineWidth',3,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
hold on;
plot([pointB(1) pointC(1)], [pointB(2) pointC(2)], 'y-o','MarkerSize',1,'LineWidth',3,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
hold on;
plot([pointA(1) pointB1(1)], [pointA(2) pointB1(2)], 'r-o','MarkerSize',1,'LineWidth',3,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
hold on;
plot([pointB1(1) pointM(1)], [pointB1(2) pointM(2)], 'g-o','MarkerSize',1,'LineWidth',3,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
hold on
plot(sliderPointsXArray, sliderPointsYArray, 'm-','LineWidth',2);
plot([slidingLineStart(1) slidingLineEnd(1)], [slidingLineStart(2) slidingLineEnd(2)], 'k-.');
axis([-500 500 -900 300]); % can be set as per the link dimensions
hold off;


%StaticForceAnalysis













figure(2)
subplot(2,2,4);title('Slider');
hold on
ForceApp = pointC-Force*dirSliding;


    figure(3)
    title('Force Polygon of Slider');
    hold on
    ForcePolygon_slider = LinesIntersection(ForceApp, dirSliding_perpendicular, pointC, direction_connectingrod);
    ForceApp2 = pointC+norm(ForcePolygon_slider-ForceApp)*dirSliding_perpendicular;
    Force_C_connecting = pointC-(norm(ForcePolygon_slider-pointC))*direction_connectingrod;
    Force_C_connecting_opp = pointC+(norm(ForcePolygon_slider-pointC))*direction_connectingrod;

    drawVector2D(ForceApp, pointC, 'm')
    hold on
    plot([pointC(1) ForceApp(1)], [pointC(2) ForceApp(2)],'k-','LineWidth',2)
    hold on

    drawVector2D(ForcePolygon_slider, ForceApp, 'm')
    hold on
    plot([ForcePolygon_slider(1) ForceApp(1)], [ForcePolygon_slider(2) ForceApp(2)],'k-','LineWidth',2)
    hold on

    drawVector2D(pointC, ForcePolygon_slider, 'm')
    hold on
    plot([ForcePolygon_slider(1) pointC(1)], [ForcePolygon_slider(2) pointC(2)],'k-','LineWidth',2)
    hold on

    axis([-100 120 -680 -530]);

figure(2)
drawVector2D(ForceApp, pointC, 'm')
hold on
plot([pointC(1) ForceApp(1)], [pointC(2) ForceApp(2)],'k-','LineWidth',2)
hold on

drawVector2D(ForceApp2, pointC, 'm')
hold on
plot([pointC(1) ForceApp2(1)], [pointC(2) ForceApp2(2)],'k-','LineWidth',2)
hold on

drawVector2D(Force_C_connecting, pointC, 'm')
hold on
plot([pointC(1) Force_C_connecting(1)], [pointC(2) Force_C_connecting(2)],'k-','LineWidth',2)
hold on

plot(sliderPointsXArray, sliderPointsYArray, 'm-','LineWidth',2);
hold on
axis([-300 300 -700 -400]);

figure(2)
subplot(2,2,2);title('connecting rod'); 
hold on

Connecting_extensions_connectingrod =  LinesIntersection(pointD, direction_outputlink, pointB, direction_connectingrod_perpendicular);
direction_force_b = (pointB-Connecting_extensions_connectingrod)/norm(pointB-Connecting_extensions_connectingrod);
direction_force_c = (pointC-Connecting_extensions_connectingrod)/norm(pointC-Connecting_extensions_connectingrod);
direction_force_d = (pointD-Connecting_extensions_connectingrod)/norm(pointD-Connecting_extensions_connectingrod);

figure(5);title('Force Polygon of Connecting Rod')
hold on
ForcePolygon_A = [0,0];
ForcePolygon_B = ForcePolygon_A-direction_force_c*norm(ForcePolygon_slider-pointC);
ForcePolygon_C = LinesIntersection(ForcePolygon_B, direction_outputlink, ForcePolygon_A, direction_force_b);
Distance_AB = norm(ForcePolygon_A-ForcePolygon_B);
Distance_BC = norm(ForcePolygon_B-ForcePolygon_C);
Distance_CA = norm(ForcePolygon_C-ForcePolygon_A);
drawVector2D(ForcePolygon_A, ForcePolygon_B, 'y')
hold on
plot([ForcePolygon_A(1) ForcePolygon_B(1)], [ForcePolygon_A(2) ForcePolygon_B(2)],'k-','LineWidth',2)
hold on

drawVector2D(ForcePolygon_B, ForcePolygon_C, 'y')
hold on
plot([ForcePolygon_B(1) ForcePolygon_C(1)], [ForcePolygon_B(2) ForcePolygon_C(2)],'k-','LineWidth',2)
hold on

drawVector2D(ForcePolygon_C, ForcePolygon_A, 'y')
hold on
plot([ForcePolygon_C(1) ForcePolygon_A(1)], [ForcePolygon_C(2) ForcePolygon_A(2)],'k-','LineWidth',2)
hold on
axis([-80 100 -20 120]);

figure(2)
subplot(2,2,2);title('connecting rod');
hold on
PlotB = pointB+Distance_CA*direction_force_b;
PlotC = pointC+Distance_AB*direction_force_c;
PlotD = pointD+Distance_BC*direction_force_d;
drawVector2D(PlotB, pointB, 'y')
hold on
plot([pointB(1) PlotB(1)], [pointB(2) PlotB(2)],'k-','LineWidth',2)
hold on
drawVector2D(pointD, PlotD, 'y')
hold on
plot([pointD(1) PlotD(1)], [pointD(2) PlotD(2)],'k-','LineWidth',2)
hold on
drawVector2D(PlotC, pointC, 'y')
hold on
plot([pointC(1) PlotC(1)], [pointC(2) PlotC(2)],'k-','LineWidth',2)
hold on
plot([pointC(1) PlotC(1)], [pointC(2) PlotC(2)],'k-','LineWidth',2)
hold on
plot([pointB(1) pointC(1)], [pointB(2) pointC(2)], 'y-o','MarkerSize',1,'LineWidth',3,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',1);
hold on
axis([-200 400 -700 0]);

figure(2)
subplot(2,2,3);title('Output Link');
hold on
Link2_B1 = pointB1-Distance_BC*direction_force_d;
Link2_M = pointM+Distance_BC*direction_force_d;
drawVector2D(Link2_B1, pointB1, 'g')
hold on
plot([pointB1(1) Link2_B1(1)], [pointB1(2) Link2_B1(2)],'k-','LineWidth',2)
hold on
drawVector2D(Link2_M, pointM, 'g')
hold on
plot([pointM(1) Link2_M(1)], [pointM(2) Link2_M(2)],'k-','LineWidth',2)
hold on
plot([pointB1(1) pointM(1)], [pointB1(2) pointM(2)], 'g-o','MarkerSize',1,'LineWidth',3,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',1);
hold on
axis([-250 250 -800 200]);


figure(6);title('Force Polygon of Crank');
hold on
ForcePolygon1_A = [0,0];
ForcePolygon1_B = ForcePolygon_A+Distance_BC*direction_outputlink;
ForcePolygon1_C = ForcePolygon1_B+direction_force_b*Distance_CA;
Distance1_AB = norm(ForcePolygon1_A-ForcePolygon1_B);
Distance1_BC = norm(ForcePolygon1_B-ForcePolygon1_C);
Distance1_CA = norm(ForcePolygon1_C-ForcePolygon1_A);

drawVector2D(ForcePolygon1_A, ForcePolygon1_B, 'r')
hold on
plot([ForcePolygon1_A(1) ForcePolygon1_B(1)], [ForcePolygon1_A(2) ForcePolygon1_B(2)],'k-','LineWidth',2)
hold on

drawVector2D(ForcePolygon1_B, ForcePolygon1_C, 'r')
hold on
plot([ForcePolygon1_B(1) ForcePolygon1_C(1)], [ForcePolygon1_B(2) ForcePolygon1_C(2)],'k-','LineWidth',2)
hold on

drawVector2D(ForcePolygon1_C, ForcePolygon1_A, 'r')
hold on
plot([ForcePolygon1_C(1) ForcePolygon1_A(1)], [ForcePolygon1_C(2) ForcePolygon1_A(2)],'k-','LineWidth',2)
hold on
axis([-20 50 -50 150]);




figure(2)
Connecting_extensions_crank =  LinesIntersection(pointB1, direction_outputlink, pointB, direction_force_b);
direction_force1_a = (pointA-Connecting_extensions_crank)/norm(pointA-Connecting_extensions_crank);
Plot_forA = pointA+direction_force1_a*Distance1_CA;
Plot_forB = pointB-direction_force_b*Distance1_BC;
Plot_forB1 = pointB1-direction_outputlink*Distance1_AB;
subplot(2,2,1);title('Crank and its Extension')
hold on
drawVector2D( Plot_forA,pointA, 'r')
hold on
plot([pointA(1) Plot_forA(1)], [pointA(2) Plot_forA(2)],'k-','LineWidth',2)
hold on

drawVector2D( Plot_forB,pointB, 'r')
hold on
plot([pointB(1) Plot_forB(1)], [pointB(2) Plot_forB(2)],'k-','LineWidth',2)
hold on

drawVector2D( Plot_forB1,pointB1, 'r')
hold on
plot([pointB1(1) Plot_forB1(1)], [pointB1(2) Plot_forB1(2)],'k-','LineWidth',2)
hold on

plot([pointA(1) pointB(1)], [pointA(2) pointB(2)],'r-o','MarkerSize',1,'LineWidth',3,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',1);
hold on

plot([pointA(1) pointB1(1)], [pointA(2) pointB1(2)], 'r-o','MarkerSize',1,'LineWidth',3,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',1);
hold on
axis([-150 300 -300 200]);
w = Distance1_CA/10*crank

