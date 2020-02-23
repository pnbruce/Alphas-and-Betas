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

scatter(A(:,1), A(:,2),'filled')
xlabel(textData(1,2)); ylabel(textData(1,3)); title('MWPL Member Characteristics');