function [D, P] = dijkstra(G)
%INPUT: G - adjacency matrix, where 
%G(i,j) = travel time, if edge ij exists, and 0, if not
%OUTPUT: D - matrix of shortest distances (not really needed)
% P - matrix of shortest pathes, written as cellarray
% P(i, j) = {i, ... , j}   

    v = size(G, 1); % Number of vertices
    D = []; 
    P = {};
    
    fl = 0;
    for i = 1:v
        for j = 1:v
            if G(i,j) <= eps
                G(i,j) = inf;
            end
        end
    end

    for i = 1:v 
        dist = inf(1, v);
        seen = ones(1, v);
        not_seen = v;
        dist(1, i) = 0;
        path = cell(1, v);
        path(1,i) = [i];
        while not_seen > 0
            [distance index] = min(dist .* seen);

            if distance == inf
                break;
            end
            
            seen(index) = inf;
            not_seen = not_seen - 1;

            for n = 1:v
                if seen(n) == 1
                    alt = distance + G(index, n);
                    if alt < dist(n)
                        dist(n) = alt;
                        path(1,n) = [cell2mat(path(1,index)) n];
                    end
                end
            end
        end
        D = [D ; dist];
        P = [P; path];
    end
end
