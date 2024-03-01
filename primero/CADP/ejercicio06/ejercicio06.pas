program ejercicio06;
const
    CORTE = -1;
    ULTV = 7;
    CONDU = 1600;
    CONDD = 'Galileo Galilei';
type
    rangoV = 1..ULTV;

    vTipo = array[rangoV] of integer;

    objetos = record
        codOb : integer;
        catOb : rangoV;
        nom : string[20];
        dist : integer;
        nomD : string[20];
        anDes: integer;
    end;

    li = ^nodo;
    nodo = record
        d : objetos;
        s : li;
    end;

procedure inVector (var v : vTipo);
var
    i : rangoV;
begin
  for i:=1 to ULTV do
    v[i] := 0;
end;

procedure inNodo (var ult : li ;var l : li; o : objetos);
var 
    nue : li;
begin
    new(nue);
    nue^.d := o;
    nue^.s := nil;
    if (l = nil) then
        l := nue
    else
        ult^.s := nue;
    ult := nue;
end;

procedure reObjeto (var o : objetos);
begin
    write('Ingresar codigo de objeto: ');readln(o.codOb);
    if(o.codOb <> CORTE) then begin
        write('Ingresar categoria del objeto(1..7):'); o.catOb := Random(7)+1;
        writeln(o.catOb);
        write('Ingresar el nombre del objeto:'); readln(o.nom);
        write('Ingresar distancia recorrida:'); o.dist := Random(7000);
        writeln(o.dist);
        write('Ingresar nombre del descubridor:'); readln(o.nomD);
        write('Ingresar a.. de descubrimiento'); o.anDes := Random(2020)+1;
        writeln(o.anDes);
    end;
end;

procedure carLista(var l:li; var ult : li);
var
    ob : objetos;
begin
    reObjeto(ob);
    while (ob.codOb <> CORTE) do begin
        inNodo(ult,l,ob);
        reObjeto(ob);
    end;
end;

function descomponer (num :integer): boolean;
var
    dig,contP,contI :integer;
begin
    contP := 0; contI := contP;
    while ( num <> 0 ) do begin
        dig := num MOD 10;
        if (dig MOD 2 = 0) then
            contP := contP +1
        else
            contI := contI +1;
        num := num DIV 10 ;
    end;
    descomponer := (contP > contI);
end;

procedure informarVector (v : vTipo);
var
    i : integer;
begin
    for i:= 1 to ULTV do
        writeln('Pos: ', i , ' cantidad: ',v[i] );
end;


procedure recorrerLista(l : li ;var v : vTipo);
 var
    max,maxD,maxCod,maxCodD, contDos : integer;
begin
    contDos := 0;
    max := -1; maxD := max ; maxCod := maxD ; maxCodD:= maxCod;
    while (l <> nil) do begin
        v[l^.d.catOb] := v[l^.d.catOb] +1;
        if ((l^.d.nomD = CONDD) and (l^.d.anDes = CONDU)) then
            contDos := contDos +1;
        if (descomponer(l^.d.codOb) = true) then
            writeln('Nombre : ', l^.d.nomD);
        if (l^.d.dist > max) then begin
            maxD := max;
            maxCodD:= maxCod;
            max := l^.d.dist;
            maxCod := l^.d.codOb;
        end
        else if (maxD < l^.d.dist) then begin
            maxD := l^.d.dist;
            maxCodD := l^.d.codOb
        end;
        l:= l^.s;
    end;
    writeln('Objetos que cumplen la condicion del punto dos: ',contDos);
    informarVector(v);
end;
// Programa principal
var
    lista,ult : li;
    cat : vTipo;
begin
    lista := nil;
    ult := nil;
    inVector(cat);
    carLista(lista,ult);
    recorrerLista(lista,cat);
end.