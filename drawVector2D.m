function DrawVector2D(pointA, pointB, color)
pointAX = pointA(1); pointAY = pointA(2);
pointBX = pointB(1); pointBY = pointB(2);
deltaVector = pointB-pointA;
length = norm(deltaVector);
headSize =0.1*length;
midPoint = (pointA+pointB)*0.5;
midPointX = midPoint(1); midPointY = midPoint(2);
theta = atan2(deltaVector(2),deltaVector(1));

 

headPoint1X = midPointX + headSize*cos(theta+pi/2);
headPoint1Y = midPointY + headSize*sin(theta+pi/2);
headPoint2X = midPointX + 2*headSize*cos(theta);
headPoint2Y = midPointY + 2*headSize*sin(theta);
headPoint3X = midPointX + headSize*cos(theta+3*pi/2);
headPoint3Y = midPointY + headSize*sin(theta+3*pi/2);

 

headArrayX = [headPoint1X; headPoint2X; headPoint3X; headPoint1X];
headArrayY = [headPoint1Y; headPoint2Y; headPoint3Y; headPoint1Y];

 

plot([pointAX; pointBX],[pointAY; pointBY],color,'LineWidth',2);
plot(headArrayX, headArrayY, color,'LineWidth',2);

 

end