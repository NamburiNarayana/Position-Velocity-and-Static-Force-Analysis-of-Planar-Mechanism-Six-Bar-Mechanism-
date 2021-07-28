function [pointIntersection] = LinesIntersection(pointA, dirA, pointB, dirB)

pointIntersection = []; %empty array to be returned if d == 0; to be checked where this function is being called

%defining simpler variables to match with derivation
xA = pointA(1); yA = pointA(2); xB = pointB(1); yB = pointB(2);
fA = dirA(1);   gA = dirA(2); fB = dirB(1);   gB = dirB(2);

d =  fB*gA -fA*gB; %determinant
if d == 0
    return; %parallel or co-incident lines, may show user warning. Do not execute further code
end

tA = (fB*(yB-yA) - gB*(xB-xA))/d;
tB = (fA*(yB-yA) - gA*(xB-xA))/d; %only one of tA or tB is sufficient to get intersection point

pointIA = pointA + tA*dirA;
pointIB = pointB + tB*dirB; % pointIB should be same as pointIA. It is just obtained from  pointB

%validation (just in case there is a mistake in coding)
if pointIB == pointIB
    pointIntersection = pointIA;
else
    return; % pointIntersection remains an empty array []
end
end