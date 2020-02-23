% load in data file on old faithful eruptions
filename = 'faithful.txt';

% specifying the deliminter used in faithful.txt
delimiter = '\t';

% indicates the number of non-numberic headerlines that should be skipped
headerlines = 1;

% loads the data to a matrix
file_data = importdata(filename,delimiter,headerlines);

% stores the data form file_data into a variable
A = file_data.data;

%normalizes values
[ANorm, mu, sigma] = zscore(A);

% stores the header lines into a varible
col_headers = file_data.colheaders;

% beinging with with K means clustering

% number of clusters
k = 2;

% maximum number of iterations
maxiter = 10;
% collects the size informaiton about the input informaiton
[N, dim] = size(A);
% matrics for storing the distances between the center points and all
% observations
d = zeros(k,N);

%shows the starting position of the centers
fprintf('[0] iteration')
colors =  {'r.', 'g.', 'b.', 'k.'};

hold off;
scatter(A(:,1),A(:,2),50,'bl.')
xlabel(col_headers(1)); ylabel(col_headers(2));xlim([1.5 5.5]); ylim([40 100]);title('Old Faithful Eruptions')
pause(.5)

% random starting coorinance
centers = zeros(k,2);
for i = 1:k
    centers(i,:) = [rand*(max(ANorm(:,1))-min(ANorm(:,1)))+min(ANorm(:,1))
        rand*(max(ANorm(:,2))-min(ANorm(:,2)))+min(ANorm(:,2))];
end

dispCenters = centers.* sigma + mu

for c = 1:k
    hold on;
    scatter(dispCenters(c,1), dispCenters(c,2),400,string(colors(c)))
end
xlabel(col_headers(1)); ylabel(col_headers(2));xlim([1.5 5.5]); ylim([40 100]);title('Old Faithful Eruptions')
pause(.5)

for c = 1:k
    d(c,:) = square_dist(ANorm,centers(c,:));
end

% id an array and each spot corrisponds to a data point and is assigned
% to the value of the center that is closest to that data point. ds is
% the distance between that data point and its nearest center.
[ds, id] = min(d);

for c = 1:k
    hold on;
    scatter(A(id==c,1),A(id==c,2),50,string(colors(c)))
end
xlabel(col_headers(1)); ylabel(col_headers(2));xlim([1.5 5.5]); ylim([40 100]);title('Old Faithful Eruptions')
pause(.5)

newCenters = centers;

for i = 1:maxiter
    
    for c = 1:k
        newCenters(c,:) = mean(ANorm(id==c,:));
    end
    
    % If centers do not move end the clasification
    if newCenters == centers
        break
    else
        centers = newCenters;
    end
    
    fprintf('[%d] iteration',i)
    dispCenters = centers.* sigma + mu
    
    hold off;
    
    for c = 1:k
        scatter(A(id==c,1),A(id==c,2),50,string(colors(c)))   
        hold on;
    end
    xlabel(col_headers(1)); ylabel(col_headers(2));xlim([1.5 5.5]); ylim([40 100]);title('Old Faithful Eruptions')
    for c = 1:k
        hold on;
        scatter(dispCenters(c,1), dispCenters(c,2),400,string(colors(c)))    
    end
    xlabel(col_headers(1)); ylabel(col_headers(2));xlim([1.5 5.5]); ylim([40 100]);title('Old Faithful Eruptions')
    pause(.5)
    
    
    for c = 1:k
        d(c,:) = square_dist(ANorm,centers(c,:));
    end

    % id an array and each spot corrisponds to a data point and is assigned
    % to the value of the center that is closest to that data point. ds is
    % the distance between that data point and its nearest center.
    [ds, id] = min(d);
    
    
    hold off;
    for c = 1:k
        scatter(A(id==c,1),A(id==c,2),50,string(colors(c)))   
        hold on;
    end
    xlabel(col_headers(1)); ylabel(col_headers(2));xlim([1.5 5.5]); ylim([40 100]);title('Old Faithful Eruptions')
    for c = 1:k
        hold on;
        scatter(dispCenters(c,1), dispCenters(c,2),400,string(colors(c)))    
    end
    xlabel(col_headers(1)); ylabel(col_headers(2));xlim([1.5 5.5]); ylim([40 100]);title('Old Faithful Eruptions')
    pause(.5)
end
