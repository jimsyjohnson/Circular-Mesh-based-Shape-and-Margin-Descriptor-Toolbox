function [elong,compact,convex] = NumCir(bw)
% H = horizontal length of Image border
% V = vertical length of Image border
% PerShape = Perimeter of actual object shape
% AreaObj = Area of actual object
% circle_area = Area of the Circle
        % ELONGATION
             H = regionprops(bw, 'MajorAxisLength');
             V = regionprops(bw,'MinorAxisLength');
             elong = max(H.MajorAxisLength)/max(V.MinorAxisLength);           
        %COMPACTNESS (Compact = 1 - 4 ×PI ×CircleArea/Perimeter^2)
            P = regionprops(bw,'Perimeter');
            C = vertcat(max(P.Perimeter));
            PerShape = max(C);
            AreaObj = regionprops(bw,'Area');
            C = vertcat(AreaObj.Area);
            circle_area = max(C);
            compact = 1-(4*max(P.Perimeter)*(circle_area/(max(P.Perimeter))^2));           
       % CONVEX = PERCONVEXHULL/PERSHAPE
            convexHull = bwconvhull(bw);
            PerConvexHull = regionprops(convexHull, 'Perimeter');
            convex = PerConvexHull.Perimeter/PerShape;         
end

