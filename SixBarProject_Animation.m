clear all;
crank = 100; connectingRod = 500; pluscrank = crank+50;
pointA = [0 0]; dirSliding = [0, 1];
thetaDegreesArray = 0:1:360;
thetaRadiansArray = thetaDegreesArray*(pi/180.0);
thetaInitial = thetaRadiansArray(1);

pointB = pointA + crank*[cos(thetaInitial) sin(thetaInitial)];
pointB1 = pointA + pluscrank*[cos(thetaInitial) sin(thetaInitial)];
slidingLineStart = pointA - 1250*dirSliding;
slidingLineEnd = pointA + 1250*dirSliding;
[pointC1, pointC2] = LineCircleIntersection(slidingLineStart, slidingLineEnd, pointB, connectingRod);
traceM= zeros(1,2);
pointC = pointC2;
%Animation
figure(1)
set(gcf,'Position',[100 100 520 500]) % to have square shaped inner canvas
grid on
axis equal
for index = 1:length(thetaRadiansArray)
    theta = thetaRadiansArray(index);   
    pointB = pointA + crank*[cos(theta) sin(theta)];
    pointB1 = pointA + pluscrank*[cos(theta) sin(theta)];
    [pointC1, pointC2] = LineCircleIntersection(slidingLineStart, slidingLineEnd, pointB, connectingRod);
    pointD = pointB + ((pointC - pointB)/connectingRod)*250;
    pointM = pointB1+ ((pointD - pointB1)/norm(pointB1 - pointD))*500;
    direction_sliding_M = (pointM-pointB1)/norm(pointM-pointB1);
    distBetweenPrevCandC1 = norm(pointC-pointC1);
    distBetweenPrevCandC2 = norm(pointC-pointC2);
    %Choose the solution that is nearest to the previous point C
    if(distBetweenPrevCandC1 < distBetweenPrevCandC2)
        pointC = pointC1;
    else
        pointC = pointC2;
    end  
    traceMx(index)= pointM(1) ;
    traceMy(index)= pointM(2) ;
    sliderPointsXArray = [pointC(1)-20  pointC(1)+20  pointC(1)+20  pointC(1)-20  pointC(1)-20];
    sliderPointsYArray = [pointC(2)-40  pointC(2)-40  pointC(2)+40  pointC(2)+40  pointC(2)-40];
    
    plot([pointA(1) pointB(1)], [pointA(2) pointB(2)],'r-o','MarkerSize',1,'LineWidth',3,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
    hold on
    plot([pointB(1) pointC(1)], [pointB(2) pointC(2)], 'y-o','MarkerSize',1,'LineWidth',3,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
    hold on
    plot([pointA(1) pointB1(1)], [pointA(2) pointB1(2)], 'r-o','MarkerSize',1,'LineWidth',3,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
    hold on
    plot([pointB1(1) pointM(1)], [pointB1(2) pointM(2)], 'g-o','MarkerSize',1,'LineWidth',3,'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
    hold on
    plot(pointD(1),pointD(2),'ro','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',5);
    hold on
    plot(pointB1(1),pointB1(2),'ro','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',5);
    t=plot(traceMx,traceMy,'b-.','LineWidth',1);
    plot(sliderPointsXArray, sliderPointsYArray, 'm-','LineWidth',2);
    plot([slidingLineStart(1) slidingLineEnd(1)], [slidingLineStart(2) slidingLineEnd(2)], 'k-.');
    axis([-500 500 -900 300]); % can be set as per the link dimensions
    hold off;
    drawnow();
    pause(0.001);
end