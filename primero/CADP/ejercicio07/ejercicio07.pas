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
        l = nue
    else
        ult^.s :=  nue;
    ult = nue;
end;
procedure insercion (var v : arrayMate);
var
    i,j,actual : integer;
begin
    for i:= 2 to ULTMAT do begin
        j := i-1;
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
        writeln('Ingresar nota: '); nota := Random(10)+4;
        if (nota > 4 ) then 
            v[i] := nota
        else
            writeln('No se ingresan aplazos.');
    end;
end;
procedure leerAlumno(var a :alumno);
begin
    write('Ingresar numero de almuno: '); readln(a.num);
    if (a.num <> CORTE) then begin
        write('Ingresar nombre y apellido del alumno: '); readln(a.apeNom);
        write('Ingresar email del alumno: '); readln(a.email);
        write('Ingresar an..Ingreso: '); a.anIn := Random(6)+2000;
        writeln(a.anIng);
        write('Ingresar an..Egreso: '); a.anEg := Random(9)+2000;
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
//Programa principal
var
    liAl,ultLi : li;
begin
    liAl := nil; ultLi := nil;
    cargarLista(liAl,ultLi);
    informar(liAl);
end;