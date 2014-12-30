def knapsack(items, sizeLimit):
    """
    Calculate optimal knapsack solution.

    A dynamic programming algorithm that runs in O(len(items)*cost_max) time
    """
    cache = {}
    for i in range(len(items) + 1):
        size, value, name = items[i - 1]
        for lim in range(sizeLimit + 1):
            if i == 0:
                cache[i, lim] = 0
            elif size > lim:
                # item too big -> we do not anything
                cache[i, lim] = cache[i - 1, lim]
            else:
                # item small enough -> we see the value
                # We compare with values in cache
                cache[i, lim] = max(cache[i - 1, lim],
                                    cache[i - 1, lim - size] + value)

    col = sizeLimit
    L = []
    i = len(items)
    while i > 0:
        # If the value was not increased, we do not anything
        # Otherwise, the item was included in the optimal solution
        if cache[i, col] == cache[i - 1, col]:
            i -= 1
        else:
            i -= 1
            L.append(items[i])
            # We move to the column
            col -= items[i][0]

    L.reverse()
    return max(cache.values()), L


if __name__ == '__main__':
    # example used in lecture
    # item = (size, value, name)
    items = [(30, 1, 'A'),
            (4, 1, 'B'),
            (8, 3, 'C'),
            (10, 4, 'D'),
            (15, 30, 'E'),
            (20, 6, 'F')]

    exampleSizeLimit = 32
    value, itemsSolution = knapsack(items, exampleSizeLimit)
    print 'Value: %i' % value
    print 'Content: ' + repr(itemsSolution)