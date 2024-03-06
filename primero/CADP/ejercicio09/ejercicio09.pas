program ejercicio09;
const
    ULT = 8;
    CORTE = -1;
type
    rangoGen = 1..ULT;

    pelicula = record
        cod : integer;
        titulo : integer;
        codGen : rangoGen;
        punProm : real;
    end;

    criticas = record
        DNI : integer;
        apNom : integer;//string[15];
        codPel : integer;
        puntaje : real ;
    end;

    liPe = ^nodoPe;
    nodoPe = record
        d: pelicula;
        s : liPe;
    end;
  vGen = array[rangoGen] of real;
procedure inVector (var v: vGen);
var
    i : rangoGen;
begin
    for i:= 1 to ULT do
        v[i] := 0;
end;
procedure leerPel ( var p : pelicula);
begin
    writeln('--------------------------');
    write('Ingresar codigo de pelicula: '); 
    p.cod := Random(500)+1; writeln(p.cod);
    p.titulo := Random(40)+1;
    write('Ingresar codigo de genero: '); 
    p.codGen := Random(8)+1; writeln(p.codGen);
    write('Ingresar puntaje prom :');
    p.punProm := Random(10)+1; writeln(p.punProm);
end;
procedure leerCri ( var c : criticas);
begin
    writeln('Ingresar codigo de pelicula: ');
    readln(c.codPel);
    if (c.codPel <> CORTE) then begin
        write('Ingresar DNI : '); c.DNI := Random(5000)+1;
        writeln(c.DNI);
        write('Ingresar puntaje: '); c.puntaje := Random(10)+1;
        writeln(c.puntaje:2:2);
        write('Ingresar nombre: '); c.apNom := Random(3)+1;
        writeln(c.apNom);
    end;
end;
procedure buscarCambiar(p : real; l :liPe; codBus : integer);
var
    encontre : boolean;
begin
    encontre:= false;
    while (l <> nil) and (encontre <> true) do begin
        if (l^.d.cod = codBus ) then
            encontre := true;
        l:= l^.s;
    end;
    if (encontre = true) then
         l^.d.punProm := p;
end;
function descomponer (n : integer): boolean;
var
    par, impar , dig : integer;
begin
    par := 0; impar := par;
    while (n <> 0) do begin
        dig := n MOD 10;
        if (dig MOD 2 = 0) then 
            par := par+1
        else
            impar:= impar+1;
        n := n DIV 10;
    end;
    descomponer := par = impar;
end;
procedure actualizarLi (  l : liPe );
var
    c: criticas;
    criAct,cont : integer;
    prom,sum : real;
begin
    leerCri(c);
    while (c.codPel <> CORTE) do begin
        criAct := c.codPel;
        cont := 0; sum := cont; prom := sum;
        while (c.codPel <> CORTE) and (criAct = c.CodPel) do begin
            sum := sum + c.puntaje;
            cont := cont +1;
            if (descomponer(c.DNI) = true) then 
                writeln('Nombre con DNI par = impar:', c.apNom);
            leerCri(c);
        end;
        prom := cont / sum;
        buscarCambiar(prom,l,c.codPel);
        leerCri(c);
    end;
end;

procedure eliminarNodo(var l:liPe; numBus : integer);
var
    act,ant : liPe;
begin
    act:=l;
    while ( act <> nil) and (act^.d.cod <> numBus ) do begin
        ant := act;
        act := act^.s;
    end;
    if (act  <> nil) then 
        if (act = l) then begin
            l:= l^.s;
            dispose(act);
        end
        else begin
            ant^.s := act^.s;
            dispose(act);
        end;
end;
procedure mayorPuntaje (v : vGen);
var
    i ,codMax: integer;
    maxPun : real;
begin
    maxPun := -1; codMax:= -1;
    for i:= 1 to ULT do begin
        if (v[i] > maxPun ) then begin
            maxPun := v[i];
            codMax:= i;
        end;
    end;
    writeln('Mayor puntaje de genero : ', codMax);
end;
procedure inNodoPe(var ult : liPe ; var l : liPe ; p:pelicula);
var
    nue : liPe;
begin
    new(nue);
    nue^.d := p;
    nue^.s := nil;
    if ( l = nil ) then
        l := nue
    else
        ult^.s := nue;
    ult := nue;
end;
procedure generarLista(var ult : liPe ; var l :liPe);
var
    pelAct : pelicula;
    i : integer;
begin
    for i:=1 to 50 do begin
        leerPel(pelAct);
        inNodoPe(ult,l,pelAct);
    end;
end;
procedure recorrerLista (l : liPe;v : vGen);
begin
    while (l <> nil) do begin
        v[l^.d.codGen] := v[l^.d.codGen] + l^.d.punProm;
        l := l^.s;
    end;
    mayorPuntaje(v);
    eliminarNodo(l,506);
end;
//
var
    l,lUlt : liPe;
    vectorGeneros : vGen;
begin
    inVector(vectorGeneros);
    l:= nil; 
    lUlt := nil;
    generarLista(lUlt,l);
    actualizarLi(l);
    recorrerLista(l,vectorGeneros);
end.