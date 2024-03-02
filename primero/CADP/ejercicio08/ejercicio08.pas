program ejercicio08;
const
    CORTE = -1;
    ULT = 7;
type
    rangoCod = 1..ULT;
    transferencia = record
        numOr : integer;
        DNIOr : integer;
        numDe : integer;
        DNIDe : integer;
        hora : integer;
        monto : real;
        motiv : rangoCod;
    end;

    li = ^nodo;
    nodo = record
        d: transferencia;
        s : li;
    end;
    //vMotiv = array[rangoCod] of integer;

procedure leerTrans ( var t : transferencia);
begin
    writeln('Ingresar numero de origen: ');
    readln(t.numOr);
    if (t.numOr <> CORTE) then begin
        write('Ingresar DNI de cuenta origen: ');
        t.DNIOr := Random(5000)+1; writeln(t.DNIOr);
        write('Ingresar hora: '); 
        t.hora := Random(24)+1; writeln(t.hora);
        write('Ingresar monto: ');
        t.monto := Random(5000)+1; writeln(t.monto);
        write('Ingresar motivo de transferencia: ');
        t.motiv := Random(7)+1; writeln(t.motiv);
        write('Ingresar numero de destino: '); 
        readln(t.numDe);
        write('Ingresar DNI de destino: ');
        t.DNIDe := Random(5000)+1; writeln(t.DNIDe);
    end;
end;
procedure inNodo ( var ult : li ; var l : li ; t : transferencia);
var 
    nue : li;
begin
    new(nue);
    nue^.d := t;
    nue^.s := nil;
    if (l = nil) then 
        l := nue
    else
        ult^.s := nue;
    ult := nue;
end;
procedure carPrimerLi ( var l :li ; var ult : li);
var
    transAct : transferencia;
begin
    leerTrans(transAct);
    while(transAct.numOr <> CORTE) do begin
        inNodo(l,ult,transAct);
        leerTrans(transAct);
    end;
end;
// Programa principal
var
    liU,ultN : li;
begin
    liU:= nil; ultN:= nil;
    carPrimerLi(liU,ultN);
end.