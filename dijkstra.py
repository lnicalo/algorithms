__author__ = 'Luis Fernando'

import heapq


def dijkstra(graph, start, end):
    # Queue storing node to visit
    queue = [(0, start, [])]
    # Node visited
    visited = set()

    while True:
        # Next node
        (cost, current, path) = heapq.heappop(queue)

        # If not visited
        if current not in visited:
            # Update path
            path = path + [current]
            # Store node as visited
            visited.add(current)
            # If node is the target -> end
            if current == end:
                return cost, path
            # Store neighbor nodes in the queue
            for (next, c) in graph[current].iteritems():
                heapq.heappush(queue, (cost + c, next, path))


if __name__=='__main__':
    # A simple edge-labeled graph using a dict of dicts
    G = {'a': {'w': 14, 'x': 7, 'y': 9},
            'b': {'w': 9, 'z': 6},
            'w': {'a': 14, 'b': 9, 'y': 2},
            'x': {'a': 7, 'y': 10, 'z': 15},
            'y': {'a': 9, 'w': 2, 'x': 10, 'z': 11},
            'z': {'b': 6, 'x': 15, 'y': 11}}


    cost, path = dijkstra(G, start='a', end='b')
    print cost, path