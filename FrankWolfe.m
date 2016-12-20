OD = [];
Agj = [];
Net = [];
[OD, Net, v] = readfiles();
Adj = Net(:,:,3);
[D, P] = dijkstra(Adj);
F = zeros(24,24); %matrix of flows
for i = 1:v
    for j = 1:v
        p = cell2mat(P(i,j));
        if size(p)(2) > 1
        for k = 1:size(p)(2) - 1
            e1 = p(k);
            e2 = p(k + 1);
            F(e1, e2) = F(e1, e2) + OD(i, j);
        end
        end
    end
end
Capacity = Net(:,:,1);
B = Net(:,:,4);
Power = Net(:,:,5);
A = Adj.*(1 + B.*((F./Capacity).^Power));
gamma = @(k) 2/(k + 1);
s = 1;
En = [];
mmax = 10000;
while mmax > 500
    [D, P] = dijkstra(A);
    Y = zeros(24,24); %new matrix of flows
    for i = 1:v
    for j = 1:v
        p = cell2mat(P(i,j));
        if size(p)(2) > 1
        for k = 1:size(p)(2) - 1
            e1 = p(k);
            e2 = p(k + 1);
            if Adj(e1, e2) == 0 
              e1
              e2
            end
            Y(e1, e2) = Y(e1, e2) + OD(i, j);
        end
        end
    end
    end
    nF = (1 - gamma(s))*F + gamma(s)*Y;
    mmax = max(max(nF - F));
    En = [En; mmax];
    F = nF;
    A = Adj.*(1 + B.*((F./Capacity).^Power));
    s = s + 1;
end
format shortG;
display(F);
plot(En, 'r-', 'LineWidth',2);