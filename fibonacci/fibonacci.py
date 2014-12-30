def fibonacci(n):
    """ Divide and conquer algorithm O(log(n))
     Matrix exp
     | 0 1 |^n   | f(n-2) f(n-1) |
     | 1 1 |   = | f(n-1)   f(n) |

     Note that A^n can be written as a sum of power of 2. That is:
     A^n = A^(2^k_1) * A^(2^k_2) * A^(2^k_3) ...
     For example:
        A^25 = A^(2^4) * A^(2^3) * A^(2^0)
    """
    a = 1
    b = 0

    c = 1
    d = 0

    while n > 0:
        if n % 2 == 1:
            temp = b*c
            b = a*c + b*d + temp
            a = a*d + temp

        temp = c*c
        c = 2*d*c + temp
        d = d*d + temp
        n = int(n / 2)

    return b

if __name__ == '__main__':
    # Print n first fibonacci numbers
    N = 15
    s = 'Fibonacci numbers: '
    for i in range(1, N):
        s = s + repr(fibonacci(i)) + ' '
    print s