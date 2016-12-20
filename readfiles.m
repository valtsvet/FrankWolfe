function [OD, Net, N] = readfiles()
fileID = fopen('SiouxFalls_trips.tntp', 'r');
tline = fgets(fileID);
N = strread(tline, '%u')(4); %number of zones
for i=1:5 tline = fgets(fileID); end
o = strread(tline, '%u')(2); %first origin
tline = fgets(fileID);
OD = []; %trips matrix 
Net = [];
while ~feof(fileID)
    if strfind(tline, 'Origin')
        o = strread(tline, '%u')(2);
    end
    tmp = strsplit(tline, ';');
    for i = 1:numel(tmp) - 1
        s = strsplit(tmp{i}, ':');
        d(i) = str2num(s{1});
        n(i) = str2num(s{2});
    end
    for i = 1:numel(d)
        OD(o, d(i)) = n(i);
    end
    tline = fgets(fileID);
end
fclose(fileID);
fileID = fopen('SiouxFalls_net.tntp', 'r');
for i = 1:8 tline = fgets(fileID); end
while ~feof(fileID)
    tline = fgets(fileID);
    tmp1 = strsplit(tline, '   ');
    tmp = str2num(vertcat(tmp1{:}));
    Net(tmp(1), tmp(2), :) = tmp(3:10);
end
fclose(fileID);
end