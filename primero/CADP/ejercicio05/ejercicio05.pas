program ejercicio05;
const
    FLTOTAL= 100;
    CORTE = -1;
    CONDU = 30.5;
    CONDD = 5;
type
    rangoFlota = 1..FLTOTAL;

    camion  = record
      patente : integer;
      anFab : integer;
      capCar : real;
    end;

    vFlot = array[rangoFlota] of camion;

    viajes = record
        codVi : integer;
        codCa : rangoFlota;
        km : integer;
        cuidad : integer; //string[15]; * Se hizo integer para poder ejecutar mas rapido.
        anVi : integer;
        DNI : integer;
    end;

    li = ^nodo;
    nodo = record
        dato : viajes;
        sig : li;
    end;

procedure leerCamion (var c : camion) ; 
begin
  writeln('Ingresar patente');
  c.patente := Random(5000)+2042;
  writeln(c.patente);
  writeln('Ingresar a... de fabricacion');
  c.AnFab := Random(5)+2000;
  writeln(c.AnFab);
  writeln('Ingresar capacidad de carga');
  c.capCar := Random(20)+1 * Random(30)+5;
  writeln(c.capCar:2:2);
end;

procedure cargarFlota (var v : vFlot);
var
    i :rangoFlota; cam: camion;
begin
    for i:= 1 to FLTOTAL do begin
        leerCamion(cam);
        v[i] := cam;
    end;
end;

procedure leerViaje (var v: viajes);
begin
    writeln('Ingresar codigo de viaje');
    readln(v.codVi);
    if(v.codVi <> CORTE ) then begin
        write('Ingresar codigo de camion (1..100): ');
        v.codCa := Random(FLTOTAL)+1;
        writeln(v.codCa);
        write('Ingresar kilometros recorridos: ');
        v.km := Random(2500)+1;
        writeln(v.km);
        write('Ingresar cuidad: ');
        v.cuidad := Random(50)+1;
        writeln(v.cuidad);
        write('Ingresar a.. de viaje: ');
        v.anVi := Random(20)+2000;
        writeln(v.anVi);
        write('Ingresar DNI del chofer: ');
        v.DNI := Random(5342)+1;
        writeln(v.DNI);
    end;
end;
procedure agregarNodo ( var ult : li ; var l: li ; v : viajes);
var
    nue : li;
begin
    new(nue);
    nue^.dato := v;
    nue^.sig := nil;
    if (l = nil) then
        l:= nue
    else
        ult^.sig := nue;
    ult := nue;
end;
procedure crearListaViajes ( var ul : li; var l : li);
var
    vi : viajes;
begin
    leerViaje(vi);
    while (vi.codVi <> CORTE) do begin
        agregarNodo(ul,l,vi);
        leerViaje(vi);
    end;
end;
procedure informarlista(l : li);
begin
    while ( l <> nil ) do begin
        writeln('Viaje:');
        writeln(l^.dato.codVi);
        l:= l^.sig;
    end;
end;
function descomponerDNI (num : integer): boolean;
var
    dig : integer;
begin
    descomponerDNI:= true;
    while ( num <> 0) and (descomponerDNI <> false)do begin
        dig := num MOD 10;
        if (dig MOD 2 = 3) then 
            descomponerDNI := false;
        num := num DIV 10;
    end;
end;

procedure recorrerLista(l:li ; v:vFlot);
var
    minPat,maxPat : integer;
    cont,maxkm,minkm: integer;
begin
    maxkm := -1; minkm:= 999; cont := 0;
    while ( l <> nil ) do begin
        if (maxkm < l^.dato.km) then begin
            maxkm := l^.dato.km;
            maxPat:= v[l^.dato.codCa].patente;
        end;
        if (minkm > l^.dato.km) then begin
            minkm := l^.dato.km;
            minPat := v[l^.dato.codCa].patente;
        end;
        if (v[l^.dato.codCa].capCar > CONDU) and (v[l^.dato.codCa].anFab - l^.dato.anVi = CONDD) then
            cont := cont +1;
        if (descomponerDNI(l^.dato.DNI) = true ) then
            writeln('Codigo de viaje con DNI hecho de impares : ', l^.dato.codVi); 
        l := l^.sig;
    end;
    writeln('Cantidad de camiones que cumplen la condicion de 2: ', cont);
    writeln(' Patente : Maximo kilometros: ', maxPat);
    writeln(' Patente : Minimo kilometros:', minPat);
end;
//Programa principal
var
 flota : vFlot;
 l,ult : li;
begin
    l:= nil ; ult := nil;
    cargarFlota(flota);
    crearListaViajes(ult,l);
    recorrerLista(l,flota);
end.