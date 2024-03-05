program ejercicio08;
const
    CORTE = -1;
    ULT = 7;
    COND = 7;
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
   // vMotiv = array[rangoCod] of integer;

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
procedure insertarOrdenado (var l : li ; t : transferencia);
var
    nue,act,ant : li;
begin
    new(nue);
    nue^.d := t;
    act := l;
    while (act <> nil) and (t.numOr > act^.d.numOr) do begin
        ant := act;
        act := act^.s;
    end;
    if (act  = l) then
        l := nue
    else
        ant^.s := nue;
    nue^.s := act;
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
        inNodo(ult,l,transAct);
        leerTrans(transAct);
    end;
end;
procedure informarLi (l : li);
begin
    while (l <> nil) do begin
        writeln('Numero de origen: ', l^.d.numOr);
        writeln('Numero de destino: ', l^.d.numDe);
        l := l^.s;
    end;
end;
procedure generarSegundaLista(var liD : li ; liU : li);
begin
    while(liU <> nil) do begin
        if (liU^.d.numOr <> liU^.d.numDe) then
            insertarOrdenado(liD,liU^.d);
        liU:= liU^.s;
    end;
end;
function descomponer (n : integer): boolean;
var
    dig ,par ,impar: integer;
begin
    par := 0; impar := par;
    while (n <> 0 ) and (par >= impar) do begin
        dig := n MOD 10;
        if (dig MOD 2 = 0) then
            par := par +1
        else
            impar := impar +1;
        n := n DIV 10;
    end;
    descomponer := (par > impar) ;
end;
procedure inVector ( var v : vMotiv );
var
    i : rangoCod;
begin
    for i := 1 to ULT do 
        v[i] := 0;
end;
procedure calMaximo (v : vMotiv);
var
    max: integer;
    maxCod , i: rangoCod;
begin
    max := -1;
    for i:= 1 to ULT do 
        if (max < v[i]) then begin
            max := v[i];
            maxCod := i;
        end; 
    writeln('Codigo maximo : ', maxCod);
end;

procedure recorrerLiDos (l : li; var v : vMotiv);
var
    cont,codAct : integer;
    montoTotal : real;
begin
    
    inVector(v);
    cont := 0;
    while ( l <> nil ) do begin
        montoTotal := 0;
        codAct := l^.d.numOr;
        while ( l <> nil ) and ( codAct = l^.d.numOr) do begin
            montoTotal := montoTotal + l^.d.monto;
            if (l^.d.hora = COND) and (descomponer(l^.d.numDe) = true) then
                cont := cont+1;
            v[l^.d.motiv] := v[l^.d.motiv] + 1;
            writeln('Monto total a terceros: ', montoTotal);
        l := l^.s;
        end;
    end;
    writeln('Punto D: ', cont);
    calMaximo(v);
end;
// Programa principal
var
    liU,liD,ultN : li;
    vector : vMotiv;
begin
    liU:= nil; ultN:= nil; liD:= nil;
    carPrimerLi(liU,ultN);
    generarSegundaLista(liD,liU);
    recorrerLiDos(liD,vector);
end.