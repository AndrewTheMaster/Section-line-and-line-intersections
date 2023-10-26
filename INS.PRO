NOWARNINGS
DOMAINS
	r  = real
PREDICATES
	run
	finding_intersections(r,r,r,r,r,r,r,r,r,r,r,r)
	belong0(r,r,r,r,r,r,r,r,r)
	belong1(r,r,r,r,r,r,r,r,r)
	s_to_p(r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r)
	t_to_p(r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r)
	between(r,r,r)
	belong_section(r,r,r,r,r,r,r,r,r)
	get_coef(r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r)
	get_coefS(r,r,r,r,r,r,r)
	get_coefT(r,r,r,r,r,r,r)
CLAUSES
	% entry point
	run:-
	    write("Tetrahedron and line intersections"), nl,
	    write("made by Andrey Baryaev"), nl,

        %первая прямая
        X00 = 2,
        Y00 = 1,
        Z00 = 0,
        X01 = 7,
        Y01 = 1,
        Z01 = 0,
        %вторая прямая
        X10 = 8,
        Y10 = 1,
        Z10 = 1,
        X11 = 8,
        Y11 = 1,
        Z11 = 2,

        finding_intersections(X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11).


    finding_intersections(X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11):-
        %вектор первой прямой
        DX0 = X01 - X00,
        DY0 = Y01 - Y00,
        DZ0 = Z01 - Z00,
        %вектор второй прямой
        DX1 = X11 - X10,
        DY1 = Y11 - Y10,
        DZ1 = Z11 - Z10,
        %компоненты системы
        A = DX0,
        B = -DX1,
        C = X10 - X00,
        DD = DY0,
        EE = -DY1,
        FF = Y10 - Y00,

        GG = DZ0,
        HH = -DZ1,
        II = Z10 - Z00,

        D = DD+A,
        E = EE+B,
        F = FF+C,
        G = GG+A,
        H = HH+B,
        I = II+C,

        get_coef(D,E,F,G,H,I,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1).


    get_coef(D,E,F,G,H,I,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1):-
        get_coefS(D,E,F,G,H,I,S),
        s_to_p(S,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1).

    get_coef(D,E,F,G,H,I,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1):-
        get_coefT(D,E,F,G,H,I,T),
        t_to_p(T,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1).

    get_coefS(D,E,F,G,H,I,S):-
        D=0, E=0, F=0, G=0, H=0, I=0,!, write("infinite number of intersection points"), nl,fail.

    get_coefS(D,E,F,G,H,I,S):-
        D=0, E=0, F=0, G=0, H=0,!, write("no intersection points"), nl,fail.

    get_coefS(D,E,F,G,H,I,S):-
        D=0, E=0, F=0, G=0,!, S=I/H.

    get_coefS(D,E,F,G,H,I,S):-
        D=0, E=0, F=0,!, write("infinite number of intersection points"), nl,fail.

    get_coefS(D,E,F,G,H,I,S):-
        D=0, E=0,!, write("no intersection points"), nl,fail.

    get_coefS(D,E,F,G,H,I,S):-
        D=0,!, S = F / E, H*S=I.

    get_coefS(D,E,F,G,H,I,S):-
        D=0,!,write("no intersection points"), nl,fail.

    get_coefS(D,E,F,G,H,I,S):-
        K = G / D,H = H-E * K,I = I-F * K,
        H=0,I=0,!,write("infinite number of intersection points"),nl,fail.

    get_coefS(D,E,F,G,H,I,S):-
        K = G / D,H = H-E * K,I = I-F * K,
        H=0,!,write("no intersection points"),nl,fail.

    get_coefS(D,E,F,G,H,I,S):-
        K = G / D,HHH = H-E * K,III = I-F * K,
        S=III/HHH.

    get_coefT(D,E,F,G,H,I,T):-
        D=0, E=0, F=0, H=0,!, T=I/G.

    s_to_p(S,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1):-
        X = X10 + DX1 * S,
        Y = Y10 + DY1 * S,
        Z = Z10 + DZ1 * S,
        belong0(X,Y,Z,X00,Y00,Z00,DX0,DY0,DZ0),
        belong_section(X, Y, Z,X00,Y00,Z00,X01,Y01,Z01),
        write("on section"), nl,
        write(X," ",Y," ",Z), nl.

    s_to_p(S,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1):-
        X = X10 + DX1 * S,
        Y = Y10 + DY1 * S,
        Z = Z10 + DZ1 * S,
        belong0(X,Y,Z,X00,Y00,Z00,DX0,DY0,DZ0),
        write("on line not on section"), nl,
        write(X," ",Y," ",Z), nl.

    t_to_p(T,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1):-
        X = X00 + DX0 * T,
        Y = Y00 + DY0 * T,
        Z = Z00 + DZ0 * T,
        belong1(X,Y,Z,X10,Y10,Z10,DX1,DY1,DZ1),
        belong_section(X, Y, Z,X00,Y00,Z00,X01,Y01,Z01),
        write("on section"), nl,
        write(X," ",Y," ",Z), nl.

   t_to_p(T,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1):-
        X = X00 + DX0 * T,
        Y = Y00 + DY0 * T,
        Z = Z00 + DZ0 * T,
        belong1(X,Y,Z,X10,Y10,Z10,DX1,DY1,DZ1),
        write("on line not on section"), nl,
        write(X," ",Y," ",Z), nl.


    belong0(X,Y,Z,X00,Y00,Z00,DX0,DY0,DZ0):-
        Q1 = (X - X00) * DY0,
        Q2 = (Y - Y00) * DY0,
        Q3 = (Y - Y00) * DZ0,
        Q4 = (Z - Z00) * DY0,
        Q1=Q2,Q3=Q4.

    belong1(X,Y,Z,X10,Y10,Z10,DX1,DY1,DZ1):-
        Q1 = (X - X10) * DY1,
        Q2 = (Y - Y10) * DY1,
        Q3 = (Y - Y10) * DZ1,
        Q4 = (Z - Z10) * DY1,
        Q1=Q2,Q3=Q4.

    between(A,B,C):-
        A <= B, B <= C.
    between(A,B,C):-
        C <= B, B <= A.

    belong_section(X, Y, Z,X00,Y00,Z00,X01,Y01,Z01):-
        between(X00, X, X01), between(Y00, Y, Y01), between(Z00, Z, Z01).



