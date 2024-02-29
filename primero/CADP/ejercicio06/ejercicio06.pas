program ejercicio06;
const
    CORTE = -1;
    ULTV = 7;
    CONDU = 1600;
    CONDD = 'Galileo Galilei';
type
    rangoV = 1..ULTV;

    //vTipo = array[rangoV] of integer;

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

{procedure inVector (var v : vTipo);
var
    i : rangoV;
begin
  for i:=1 to ULTV do
    v[i] := 0;
end;
}
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

// Programa principal
var
    lista,ult : li;
begin
    lista := nil;
    ult := nil;
    carLista(lista,ult);
end.