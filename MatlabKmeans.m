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

% stores the header lines into a varible
col_headers = file_data.colheaders;

k = 3;

[id,centers] = kmeans(A,k);

hold off;
for c = 1:k
    scatter(A(id==c,1),A(id==c,2),50,string(colors(c)))
    hold on;
end

for c = 1:k
    scatter(centers(c,1), centers(c,2),400,string(colors(c)))
end
xlabel(col_headers(1)); ylabel(col_headers(2));
pause(.5)

