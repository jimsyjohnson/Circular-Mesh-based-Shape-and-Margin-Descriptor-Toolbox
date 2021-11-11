%%
function [cxx,cyy] = BoundEmbd(cxx,cyy)

%   title('Object Graph');
for i = 1:size(cxx,2)
  plot(cxx(i),cyy(i),'b.','MarkerSize',5);
end
hold off;
end


