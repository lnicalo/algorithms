__author__ = 'Luis Fernando'
import math

def bellmanFord(A, s):
    n = len(A)

    # initiation
    d = []
    for i in xrange(0, n):
        if i == s:
            d.append(0)
        else:
            d.append(float("inf"))

    # Bellmand Ford's algorithm
    for _ in range(n-1):
        for j, row in enumerate(A):
            for k, a in enumerate(row):
                if not math.isnan(a):
                    if d[j] + a < d[k]:
                        d[k] = d[j] + a

    return d


if __name__ == '__main__':
    A = [[0, 6, 0, 7, 0], [0, 0, 5, 8, 4], [0, 2, 0, 0, 0], [0, 0, 3, 9, 0], [2, 0, 7, 0, 0]]
    s = 3

    for i in range(len(A)):
        for j in range(len(A[i])):
            if A[i][j] == 0:
                A[i][j] = float("nan")

    print "Network:"
    for node, row in enumerate(A):
        print "Node", node, ":", row
    print

    for s in range(5):
        d = bellmanFord(A, s)
        print "Shortest distance from node", s, ": d =", d