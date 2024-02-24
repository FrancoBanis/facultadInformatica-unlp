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
    writeln('Ingresar codigo de viaje.');
    readln(v.cod);
    if (v.cod <> CORTE) then begin
        writeln('Ingresar numero de viaje.'); v.num := Random(5000);
        writeln(v.num);
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
    act := l
    while ( act <> nil ) and ( v.codigo < act^.dato.codigo) do begin
        ant := act;
        act := act^.sig;
    end;
    if (act = l) then
        l := nue
    else
        ant^.sig := nue;
    nue^.sig := act ;
end;

