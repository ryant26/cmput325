:- module(graphs, [node/1, edge/2]).

% GRAPH 0 NODES

node(a).
node(b).
node(c).

% GRAPH 1 NODES

node(a1).
node(b1).
node(c1).
node(d1).
node(e1).

% GRAPH 2 NODES

node(a2).
node(b2).
node(c2).
node(d2).
node(e2).

% GRAPH 3 NODES

node(a3).
node(b3).
node(c3).
node(d3).
node(e3).

% GRAPH 4 NODES
node(a4).

% GRAPH 0 EDGES

edge(a,b).
edge(a,c).


% GRAPH 1 EDGES

edge(a1,b1).
edge(a1,c1).
edge(a1,e1).
edge(a1,d1).
edge(b1,c1).


% GRAPH 2 EDGES

edge(a2,b2).
edge(a2,c2).
edge(a2,e2).
edge(a2,d2).
edge(b2,c2).
edge(b2,e2).


% GRAPH 3 EDGES

edge(a3,b3).
edge(a3,c3).
edge(a3,e3).
edge(a3,d3).
edge(b3,c3).
edge(b3,e3).
edge(c3,e3).

% Graph 4 EDGES
edge(a4,a4).