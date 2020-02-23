% load in data file on old faithful eruptions
filename = 'Book1.txt';

% specifying the deliminter used in faithful.txt
delimiter = '\t';

% indicates the number of non-numberic headerlines that should be skipped
headerlines = 1;

% loads the data to a matrix
file_data = importdata(filename,delimiter,headerlines);

% stores the data form file_data into a variable
A = file_data.data;

% stores the header lines into a varible and the names of people
textData = file_data.textdata;

%a normalized verson of the data used for claculating euclidian distance
[ANorm, mu, sigma] = zscore(A);

% the potition of Thomas "the body" Sheehan in the list.
bod = 1;

k = 2;

colors =  {'r.', 'g.', 'b.', 'k.'};

figure;

scatter(A(:,1), A(:,2));

figure;

dataLength = size(A,1);

alphaness = zeros(dataLength,1);

trials = 1000;

for j = 1:trials
    
    [id,centers] = kmeans(ANorm,k);

    for i = 1:k
        centers(i,1) = centers(i,1) * sigma(1) + mu(1);
        centers(i,2) = centers(i,2) * sigma(2) + mu(2);
    end

    hold off;
    for c = 1:k
        if( c == id(bod))
            scatter(A(id==c,1),A(id==c,2),250,'g.')
            hold on;
        else
            scatter(A(id==c,1),A(id==c,2),250,'r.')
            hold on;
        end
    end

    for c = 1:k
        if( c == id(bod))
            scatter(centers(c,1), centers(c,2),'+','g.')
        else
            scatter(centers(c,1), centers(c,2),'+','r.')
        end
    end
    % xlim([-2 2]); ylim([-3 3]);
    xlabel(textData(1,2)); ylabel(textData(1,3)); title('MWPL Member Characteristics');
    
   for c = 1:dataLength
        if( id(c) == id(bod))
            alphaness(c) = alphaness(c) + 1;
        end
    end
end

alphaness = alphaness / trials;
names = textData(2:dataLength+1,1);
alphanessStr = cellstr(string(alphaness));
output(:,1) = names;
output(:,2) = alphanessStr;

output = sortrows(output,2,'descend');

writecell(output,'alphaness.txt','Delimiter','tab');