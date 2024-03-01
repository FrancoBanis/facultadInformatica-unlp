program ejercicio07;
const
    ULTMAT = 12;
    CORTE = -1;
    COND = 2012;
type
    rangoV = 1..ULTMAT;

    arrayMate = array[rangoV] of integer;
    alumno  = record
      num : integer;
      apeNom : string[20];
      email : string[20];
      anIn : integer;
      anEg : integer;
      listMat : arrayMate;
    end;

    li = ^nodo;
    nodo = record
        d: alumno;
        s: li;
    end;
procedure inVector (var v: arrayMate);
var
    i : rangoV;
begin
    for i := 1 to ULTMAT do
        v[i]:= 0;
end;
procedure inNodo (var l: li ; var ult: li ; a :alumno);
var
    nue : li;
begin
    new(nue);
    nue^.d := a;
    nue^.s := nil;
    if (l = nil) then
        l := nue
    else
        ult^.s :=  nue;
    ult := nue;
end;
procedure insercion (var v : arrayMate);
var
    i,j,actual : integer;
begin
    for i:= 2 to ULTMAT do begin
        j := i-1;
        actual := v[i];
        while (j>0) and (v[j] > actual) do begin
            v[j+1] := v[j];
            j := j-1
        end;
        v[j+1] := actual;
    end;
end;
procedure leerMateria(var v : arrayMate);
var
    i : rangoV;
    nota : integer;
begin
    for i:= 1 to ULTMAT do begin
        write('Ingresar nota: '); nota := Random(10)+6; //readln(nota);
        if (nota >= 6 ) then begin
            v[i] := nota;
            writeln(v[i]);
        end
        else
            writeln('No se ingresan aplazos.');
            while (nota < 6) do begin
                write('Ingresar nota: '); 
                readln(nota);
                writeln('Ingresar nota superior a 6');
            end;
            v[i] := nota;
    end;
end;
procedure leerAlumno(var a :alumno);
begin
    write('Ingresar numero de almuno: '); readln(a.num);
    if (a.num <> CORTE) then begin
        write('Ingresar nombre y apellido del alumno: '); readln(a.apeNom);
        write('Ingresar email del alumno: '); readln(a.email);
        write('Ingresar an..Ingreso: '); a.anIn := Random(6)+2000;
        writeln(a.anIn);
        write('Ingresar an..Egreso: '); a.anEg := Random(9)+2000;
        writeln(a.anEg);
        inVector(a.listMat);
        leerMateria(a.listMat);
    end;
end;
procedure cargarLista (var l: li ; ult : li);
var
    alAct : alumno;
begin
    leerAlumno(alAct);
    while(alAct.num <> CORTE) do begin
        insercion(alAct.listMat);
        inNodo(l,ult,alAct);
        leerAlumno(alAct);
    end;
end;
procedure informarVector ( v: arrayMate);
var
    i : rangoV;
begin
    for i:= 1 to ULTMAT do 
        writeln('Pos: ', i , ' nota: ', v[i]);
end;
procedure informar(l : li);
begin
    while ( l <> nil) do begin
        writeln('Alumno: ', l^.d.apeNom);
        informarVector(l^.d.listMat);
        l:= l^.s;
    end;
end;
function promedioNotas ( v : arrayMate):real;
var
    i : rangoV;
    sum : integer
begin
    for i:=1 to ULTMAT do
        sum := v[i] + sum;
    promedioNotas := sum/ULTMAT;
end;
function descomponer ( num : integer): boolean;
var
    dig : integer;
begin
    while( num <> 0 ) and (descomponer = false) do begin
        dig := num MOD 10;
        if (dig MOD 2 = 1) then
            descomponer := true
        else
            descomponer := false;
        num:= num DIV 10;
    end;
end;
procedure recorrerLi ( l : li);
var
    cB : integer;
    apeMax , apeMaxD : string;
    max , maxD , tiempoEg: integer;
begin
    max := -1; maxD := max;
    apeMaxD := ''; apeMax:= apeMaxD; 
    cB := 0; tiempoEg:= cB;
    while( l <> nil ) do begin
        writeln('Promedio de notas: ', promedioNotas(l^.d.listMat));
        if (l^.d.anIn = COND) and (descomponer(l^.d.num) = true) then
            cB := cB +1;
        tiempoEg := l^.d.anEg - l^.d.anIn;
        if (tiempoEg > max) then begin
            maxD := max;
            apeMaxD := apeMax;
            max := tiempoEg;
            apeMax := l^.d.apeNom;
        end
        else if (tiempoEg > maxD) then begin
            maxD := tiempoEg;
            apeMaxD := l^.d.apeNom;
        end;
        l:= l^.s;
    end;
end;
procedure eliminarNodo (var l :li ; numBus : integer)
//Programa principal
var
    liAl,ultLi : li;
begin
    liAl := nil; ultLi := nil;
    cargarLista(liAl,ultLi);
    informar(liAl);
end.