# первая прямая
X00 = 2
Y00 = 1
Z00 = 0
X01 = 7
Y01 = 1
Z01 = 0
# вторая прямая
X10 = 3
Y10 = 1
Z10 = 1
X11 = 3
Y11 = 1
Z11 = 2

# вектор первой прямой
DX0 = X01 - X00
DY0 = Y01 - Y00
DZ0 = Z01 - Z00
# вектор второй прямой
DX1 = X11 - X10
DY1 = Y11 - Y10
DZ1 = Z11 - Z10

# компоненты системы
A = DX0
B = -DX1
C = X10 - X00
D = DY0
E = -DY1
F = Y10 - Y00
G = DZ0
H = -DZ1
I = Z10 - Z00

# схлопнем систему ;)
D += A
E += B
F += C
G += A
H += B
I += C


# Принадлежность точки пересечения к первой прямой
def belong0(X, Y, Z):
    Q1 = (X - X00) * DY0
    Q2 = (Y - Y00) * DY0
    Q3 = (Y - Y00) * DZ0
    Q4 = (Z - Z00) * DY0
    return Q1 == Q2 and Q3 == Q4


# Принадлежность точки пересечения ко второй прямой
def belong1(X, Y, Z):
    Q1 = (X - X10) * DY1
    Q2 = (Y - Y10) * DY1
    Q3 = (Y - Y10) * DZ1
    Q4 = (Z - Z10) * DY1
    return Q1 == Q2 and Q3 == Q4


# Определение координат пересечения через параметр s, принадлежности точки пересечения к первой прямой/отрезку
def s_to_p(S):
    X = X10 + DX1 * S
    Y = Y10 + DY1 * S
    Z = Z10 + DZ1 * S
    print(Z10, DZ1, S)
    if belong0(X, Y, Z):
        if belong_section(X, Y, Z):
            print("on section")
            print(X, Y, Z)
        else:
            print("on line, not on section")
            print(X, Y, Z)
    else:
        print("no intersection points, crossing lines")


# Определение координат пересечения через параметр t, принадлежности точки пересечения к первой прямой/отрезку
def t_to_p(T):
    X = X00 + DX0 * T
    Y = Y00 + DY0 * T
    Z = Z00 + DZ0 * T
    if belong1(X, Y, Z):
        if belong_section(X, Y, Z):
            print("on section")
            print(X, Y, Z)
        else:
            print("on line, not on section")
            print(X, Y, Z)
    else:
        print("no intersection points, crossing lines")


def between(A, B, C):
    return A <= B <= C or C <= B <= A


# проверка лежит ли точка пересечения на первом отрезке или на первой прямой, другими словами принадлежность к отрезку
def belong_section(X, Y, Z):
    return between(X00, X, X01) and between(Y00, Y, Y01) and between(Z00, Z, Z01)


if D == 0:
    if E == 0:
        if F == 0:
            if G == 0:
                if H == 0:
                    if I == 0:
                        print("infinite number of intersection points")
                    else:
                        print("no intersection points")
                else:
                    S = I / H
                    s_to_p(S)
            else:
                if H == 0:
                    T = I / G
                    t_to_p(T)
                else:
                    print("infinite number of intersection points")
        else:
            print("no intersection points")
    else:
        S = F / E
        if H * S == I:
            s_to_p(S)
        else:
            print("no intersection points")
else:
    K = G / D
    H -= E * K
    I -= F * K
    if H == 0:
        if I == 0:
            print("infinite number of intersection points")
        else:
            print("no intersection points")
    else:
        S = I / H
        s_to_p(S)
