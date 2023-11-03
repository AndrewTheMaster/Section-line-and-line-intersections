NOWARNINGS
DOMAINS
	r  = real
PREDICATES
	run
	finding_intersections(r,r,r,r,r,r,r,r,r,r,r,r)
	belong1(r,r,r,r,r,r,r,r,r,r,r,r)
	t_to_p(r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r)
	between(r,r,r)
	belong_section(r,r,r,r,r,r,r,r,r)
	kramer(r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r,r)
CLAUSES
	% entry point
	run:-
	    write("Tetrahedron and line intersections"), nl,
	    write("made by Andrey Baryaev"), nl,
        %A
        XA = 0,
        YA = 0,
        ZA = 3,
        %B
        XB = 0,
        YB = 0,
        ZB = 0,
        %C
        XC = 0,
        YC = 3,
        ZC = 0,
        %D
        XD = 3,
        YD = 0,
        ZD = 0,
        %line
        X10 = 0,
        Y10 = 0,
        Z10 = 0,
        X11 = 0,
        Y11 = 0,
        Z11 = 1,

        %AB && line
        write("AB && line"), nl,
        finding_intersections(XA,YA,ZA,XB,YB,ZB,X10,Y10,Z10,X11,Y11,Z11),
        %AC && line
        write("AC && line"), nl,
        finding_intersections(XA,YA,ZA,XC,YC,ZC,X10,Y10,Z10,X11,Y11,Z11),
        %AD && line
        write("AD && line"), nl,
        finding_intersections(XA,YA,ZA,XD,YD,ZD,X10,Y10,Z10,X11,Y11,Z11),
        %BD && line
        write("BD && line"), nl,
        finding_intersections(XB,YB,ZB,XD,YD,ZD,X10,Y10,Z10,X11,Y11,Z11),
        %BC && line
        write("BC && line"), nl,
        finding_intersections(XB,YB,ZB,XC,YC,ZC,X10,Y10,Z10,X11,Y11,Z11),
        %CD && line
        write("CD && line"), nl,
        finding_intersections(XC,YC,ZC,XD,YD,ZD,X10,Y10,Z10,X11,Y11,Z11).


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

        DET = D*H - E*G,
        DET_T= F*H-I*E,
        kramer(DET,DET_T,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1).


        %get_coef(D,E,F,G,H,I,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1)

    kramer(DET,DET_T,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1):-
        DET <> 0,!,
        T = DET_T/DET,
        t_to_p(T,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1).


    kramer(DET,DET_T,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1):-
        V = DX0 * DX1 + DY0 * DY1 + DZ0 * DZ1,
        L0 = sqrt(DX0*DX0+DY0*DY0+DZ0*DZ0),
        L1 = sqrt(DX1*DX1+DY1*DY1+DZ1*DZ1),
        PUKPUK =(V / L0) / L1,
        PUKPUKPUK= 1-abs(PUKPUK),
        PUKPUKPUK<0.0000001,
        belong_section(X10, Y10, Z10,X00,Y00,Z00,X01,Y01,Z01),!,
        write("infinite number of intersection points"), nl.



    kramer(DET,DET_T,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1):-
        V = DX0 * DX1 + DY0 * DY1 + DZ0 * DZ1,
        L0 = sqrt(DX0*DX0+DY0*DY0+DZ0*DZ0),
        L1 = sqrt(DX1*DX1+DY1*DY1+DZ1*DZ1),
        PUKPUK =(V / L0) / L1,
        PUKPUKPUK= 1-abs(PUKPUK),
        PUKPUKPUK<0.0000001,!,
        write("parallel lines"), nl.

    kramer(DET,DET_T,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1):-
        write("no intersection points"), nl.

    t_to_p(T,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1):-
        X = X00 + DX0 * T,
        Y = Y00 + DY0 * T,
        Z = Z00 + DZ0 * T,
        belong1(X,Y,Z,X10,Y10,Z10,X11,Y11,Z11,DX1,DY1,DZ1),
        belong_section(X, Y, Z,X00,Y00,Z00,X01,Y01,Z01),
        write("on section"), nl,
        write(X," ",Y," ",Z), nl.


t_to_p(T,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1):-
        X = X00 + DX0 * T,
        Y = Y00 + DY0 * T,
        Z = Z00 + DZ0 * T,
        belong1(X,Y,Z,X10,Y10,Z10,X11,Y11,Z11,DX1,DY1,DZ1),
        write("on line not on section"), nl,
        write(X," ",Y," ",Z), nl.


   t_to_p(T,X00,Y00,Z00,X01,Y01,Z01,X10,Y10,Z10,X11,Y11,Z11,DX0,DY0,DZ0,DX1,DY1,DZ1):-
        write("no intersection points, crossing lines"), nl.




    belong1(X,Y,Z,X10,Y10,Z10,X11,Y11,Z11,DX1,DY1,DZ1):-
        Q1 = (X - X10) * DY1,
        Q2 = (Y - Y10) * DX1,
        Q3 = (Y - Y10) * DZ1,
        Q4 = (Z - Z10) * DY1,
        Q1=Q2,Q3=Q4.

   belong1(X,Y,Z,X10,Y10,Z10,X11,Y11,Z11,DX1,DY1,DZ1):-
        Q1 = (X - X11) * DY1,
        Q2 = (Y - Y11) * DX1,
        Q3 = (Y - Y11) * DZ1,
        Q4 = (Z - Z11) * DY1,
        Q1=Q2,Q3=Q4.

    between(A,B,C):-
        A <= B, B <= C,!;
        C <= B, B <= A.

    belong_section(X, Y, Z,X00,Y00,Z00,X01,Y01,Z01):-
        between(X00, X, X01), between(Y00, Y, Y01), between(Z00, Z, Z01).



