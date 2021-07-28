function [pointIntersectionA, pointIntersectionB] = LineCircleIntersection(lineStart, lineEnd, circleCenter, r)

pointIntersectionA = []; pointIntersectionB = []; %empty arrays would be returned if any error

deltaLVector = lineEnd - lineStart; lengthLVector = norm(deltaLVector);
dirLine = deltaLVector/lengthLVector; %Normalize as unit vector

%defining simpler variables to match with derivation
xL = lineStart(1); yL = lineStart(2); fL = dirLine(1);   gL = dirLine(2);
xC = circleCenter(1); yC = circleCenter(2);

denomTerm = fL*fL + gL*gL;
tempTerm = fL*(yL-yC)-gL*(xL-xC);
discriminant = r*r*denomTerm - tempTerm*tempTerm;

if discriminant < 0
    return; %Non intersecting case
end
if discriminant == 0
    t = (fL*(xC-xL) + gL*(yC-yL))/denomTerm;
    tA = t; tB = t; %equal and 
else
    tExpression1 = (fL*(xC-xL)+gL*(yC-yL))/denomTerm;
    tExpression2 = sqrt(r*r*denomTerm - (fL*(yL-yC)-gL*(xL-xC))*(fL*(yL-yC)-gL*(xL-xC)));
    tA = tExpression1 + tExpression2;
    tB = tExpression1 - tExpression2;
end

if tA >= 0 && tA <= lengthLVector
    pointIntersectionA = lineStart + tA*dirLine;
end

if tB >= 0 && tB <= lengthLVector
    pointIntersectionB = lineStart + tB*dirLine;
end


end