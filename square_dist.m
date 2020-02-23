function sq_dist = square_dist(U,v)
%Creates a 1 x M vector sq_dist where each of the M elements is the 
%distance squared between 1 x N vector v and each of the rows in the M x N 
%matrix in U.
sq_dist = sum(bsxfun(@minus,U,v).^2,2)';
end

