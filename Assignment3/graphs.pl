:- module(graphs, [node/1, edge/2]).

% ===================== Graph 1 ========================
node(a).
node(b).
node(c).
node(d).
node(e).

edge(a,b).
edge(b,c).
edge(c,a).
edge(d,a).
edge(a,e).