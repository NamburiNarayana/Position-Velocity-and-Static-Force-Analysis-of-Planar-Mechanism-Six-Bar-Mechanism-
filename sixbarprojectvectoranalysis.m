clear all;
crank = 100; connectingRod = 500; pluscrank = crank+50;
pointA = [0 0]; dirSliding = [0, 1];
%DOF = theta
thetaDegrees = 270+60; %in degrees, accordingly to be used
thetaRadians = thetaDegrees*(pi/180.0);
thetaInitial = thetaRadians;

pointB = pointA + crank*[cos(thetaInitial) sin(thetaInitial)];
pointB1 = pointA + pluscrank*[cos(thetaInitial) sin(thetaInitial)];
slidingLineStart = pointA - 1250*dirSliding;
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
pointD = pointB + ((pointC - pointB)/connectingRod)*250
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

figure(2)
angular_vel_crank = 1;
crank_vel_tang = angular_vel_crank*crank; pluscrank_vel_tang = angular_vel_crank*pluscrank; 
angle_view_degree = thetaDegrees-90;angle_view_radians = angle_view_degree*(pi/180);

direction_connecting_rod_perpendicular =[cosd(acosd(direction_connecting_rod(1))+90) sind(asind(direction_connecting_rod(2))+90)];


direction_slider = [cosd(270) sind(270)];
point_a = [0 0];

crank_end = point_a + crank_vel_tang*[cos(angle_view_radians) sin(angle_view_radians)];

crankplus_end = point_a + pluscrank_vel_tang*[cos(angle_view_radians) sin(angle_view_radians)];

connectingrod_end = LinesIntersection(point_a, direction_slider, crank_end,direction_connecting_rod_perpendicular );

point_d = (crank_end+connectingrod_end)/2;
point_m = LinesIntersection(point_d, direction_sliding_M, crankplus_end,direction_rotating_M );
pointmf = point_m-direction_rotating_M*norm(point_m-crank_end);
x=norm(pointB-pointD)/norm(pointB-pointC);
pointmf = point_m-direction_rotating_M*(x)*norm(crankplus_end-point_m);
plot([point_a(1) crank_end(1)], [point_a(2) crank_end(2)],'-rs','MarkerSize',3,'LineWidth',2);
hold on
plot([point_a(1) crankplus_end(1)], [point_a(2) crankplus_end(2)],'-rs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',5);
hold on
plot([crank_end(1) connectingrod_end(1)], [crank_end(2) connectingrod_end(2)],'-ys','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',5);
hold on
plot([point_a(1) connectingrod_end(1)], [point_a(2) connectingrod_end(2)],'-ks','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',5);
hold on
plot([point_d(1) point_m(1)], [point_d(2) point_m(2)],'-gs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',5);
hold on
plot([point_m(1) pointmf(1)], [point_m(2) pointmf(2)],'-gs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',5);                      
hold on
plot([point_m(1) crankplus_end(1)], [point_m(2) crankplus_end(2)],'-gs','LineWidth',2,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',5);                      
hold on
axis([-200 200 -200 200]);
