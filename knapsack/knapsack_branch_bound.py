#!/usr/bin/python
# -*- coding: utf-8 -*-
import heapq
from collections import namedtuple
Item = namedtuple("Item", ['index', 'label', 'value', 'weight', 'rate'])

class Node():
    solution_value = 0
    solution_selected = []
    space = 0
    items = []

    def __init__(self, value, space, selected, previous_estimate):
        self.value = value
        self.space = space
        self.estimate = previous_estimate if previous_estimate != -1 \
            else self.compute_bound(Node.items, Node.space, selected)
        self.selected = selected
        self.index = len(self.selected)

    def branch(self):
        item = Node.items[self.index]
        return Node(self.value + item.value, self.space - item.weight, self.selected + [1], self.estimate), \
            Node(self.value, self.space, self.selected + [0], -1)

    def is_leaf(self):
        return self.index == len(Node.items)

    def compute_bound(self, items, space, selected):
        value = 0
        weight = 0
        for i, item in enumerate(items):
            if i < len(selected) and selected[i] == 0:
                continue

            if weight + item.weight > space:
                value += item.value * (((space - weight) * 1.0) / item.weight)
                break
            value += item.value
            weight += item.weight

        return value


def branch_and_bound(space, items):
    # Variables to store solution
    Node.solution_value = 0
    Node.solution_selected = []
    Node.space = space
    Node.items = sorted(items, key = lambda i: i.rate, reverse = True)

    # queue to store branch and bound tree
    queue = []

    # First node
    root = Node(0, space, [], -1)
    node_right, node_left = root.branch()
    heapq.heappush(queue, (-node_right.value, node_right))
    heapq.heappush(queue, (-node_left.value, node_left))

    while queue:
        # Next node
        _, node = heapq.heappop(queue)

        # Bound
        if node.space < 0 or node.estimate < Node.solution_value:
            continue

        # Possible solution
        if node.is_leaf() and node.value > Node.solution_value:
            Node.solution_value = node.value
            Node.solution_selected = node.selected
            continue

        # Branch
        if not node.is_leaf():
            node_right, node_left = node.branch()
            heapq.heappush(queue, (-node_right.value, node_right))
            heapq.heappush(queue, (-node_left.value, node_left))

    # Backtracking to get selected items
    selected = ''
    weight = 0
    for idx in xrange(len(Node.solution_selected)):
        if Node.solution_selected[idx] == 1:
            selected += ' \'' + Node.items[idx].label + '\''
            weight += Node.items[idx].weight

    return weight, Node.solution_value, selected


if __name__ == '__main__':
    space = 220
    data = [('1', 1945, 4990),
            ('2', 321, 1142),
            ('3', 2945, 7390),
            ('4', 4136, 10372),
            ('5', 1107, 3114),
            ('6', 1022, 2744),
            ('7', 1101, 3102),
            ('8', 2890, 7280),
            ('9', 962, 2624),
            ('10', 1060, 3020),
            ('11', 805 ,2310),
            ('12', 689, 2078),
            ('13', 1513, 3926),
            ('14', 3878, 9656),
            ('15', 13504, 32708),
            ('16', 1865, 4830),
            ('17', 667, 2034),
            ('18', 1833, 4766),
            ('19', 16553, 40006)]

    data = [('1', 10, 10),
            ('2', 40, 40),
            ('3', 10, 10),
            ('4', 200, 200),
            ('5', 30, 30),
            ('6', 10, 10),
            ('7', 20, 20),
            ('8', 60, 60),
            ('9', 10, 10),
            ('10', 40, 40),
            ('11', 5, 5),
            ('12', 4, 4),
            ('13', 10, 10),
            ('14', 40, 40)]
    print "space: %i" % space
    print "Data:" + str(data)
    items = []
    for id, item in enumerate(data):
        items.append(Item(id, item[0], item[1], item[2], (item[1] * 1.0) / item[2]))

    # Solve knapsack with branch and bound algorithm
    weight, value, selected = branch_and_bound(space, items)

    # Print out results
    print "Weight: %i" % weight
    print "Value: %i" % value
    print "Selected:" + str(selected)


