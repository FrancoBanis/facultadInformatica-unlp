program ejercicio03;
const
    CORTE = -1;
    COND = 5;
type
    viaje  = record
        num : integer;
        cod : integer;
        dir : integer;
        km : integer;
    end;
    
    li = ^nodo;
    nodo = record
        dato : viaje;
        sig : li;
    end;

procedure leerViaje (var v: viaje);
begin
    writeln('Ingresar numero de viaje.');
    readln(v.num);
    if (v.num <> CORTE) then begin
        writeln('Ingresar codigo de viaje.'); v.cod := Random(5000);
        writeln(v.cod);
        writeln('Ingresar direccion.'); v.dir := Random(400)+20;
        writeln(v.dir);
        writeln('Ingresar kilometros recorridos.'); v.km := Random(200)+1;
        writeln(v.km);
    end;
end;

procedure insertarOrdenado (var l : li ; v : viaje);
var
    nue,act,ant : li;
begin
    new(nue);
    nue^.dato := v;
    act := l;
    while ( act <> nil ) and ( v.cod < act^.dato.cod) do begin
        ant := act;
        act := act^.sig;
    end;
    if (l = act) then
        l := nue
    else
        ant^.sig := nue;
    nue^.sig := act ;
end;

procedure cargarViajes (var l : li);
var
    viaAct : viaje;
    codAct : integer;
begin
    leerViaje(viaAct);
    while ( viaAct.num <> CORTE ) do begin
        viaAct.cod := codAct;
        while (viaAct.num <> CORTE) and (viaAct.cod = codAct) do begin
            insertarOrdenado(l,viaAct);
            leerViaje(viaAct);
        end;
    end;
end;

procedure kmMax (l : li);
var
    codM,codMD,kmM,kmMD : integer;
begin
    codM:=-1;
    codMD := -1;
    kmM := -1;
    kmMD := -1;
    while (l <> nil) do begin
        if (l^.dato.km > kmM) then begin
            kmM := l^.dato.km; 
            codM := l^.dato.cod;
            kmMD := kmM;
            codMD := codM;
        end
        else
            if (kmM > kmMD) then begin
                kmMD := l^.dato.km; 
                codMD:= l^.dato.cod;
            end;
        l:= l^.sig;
    end;
    writeln('Los dos codigos con mayor kilometraje son:', codMD , ' ', codM);
end;
procedure insertarOrdenadoLD (var l : li; v : viaje);
var
    ant,act,nue: li;
begin
    new(nue);
    nue^.dato := v;
    act := l;
    while (act <> nil) and (l^.dato.num > v.num ) do begin
        ant := act;
        act := act^.sig;
    end;
    if (l = act) then
        l := nue
    else
        ant^.sig := nue;
    nue^.sig := act;
end;
procedure listaNueva (var lD : li ; l:li);
begin
    while ( l <> nil) do begin
        if (l^.dato.km > COND) then 
            insertarOrdenadoLD(lD,l^.dato);
        l:= l^.sig;
    end;
end;
procedure imprimir(l : li);
begin
    while (l <> nil) do begin
        writeln('Auto :',l^.dato.cod);
        l := l^.sig;
    end;
end;
// Programa principal
var
    lista,listaDos : li;
begin
    lista := nil; listaDos := nil;
    cargarViajes(lista);
    writeln('Lista uno: ');
    imprimir(lista);
    listaNueva(listaDos,lista);
    writeln('Lista dos: ');
    imprimir(listaDos);
    kmMax(listaDos);
end.