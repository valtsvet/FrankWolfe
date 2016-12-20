## FrankWolfe
This is a realisation of Frank-Wolfe algorithm for calculating flows in transportation network
FrankWolfe.m - main file, which needs "readfiles.m" and "dijkstra.m" to calculate the matrix of flows  
readfiles.m - gets all infomation about the city's network and forms the matrix of origin-destination trips  
dijkstra.m - finds both shortest distances and pathes from every node to every node    

files "SiouxFalls_net.tntp" and "SiouxFalls_trips.tntp" store information about the city. They were taken from https://github.com/bstabler/TransportationNetworks  
