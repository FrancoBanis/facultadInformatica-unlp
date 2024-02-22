program ejercicio02;
const
    CORTE = 1122;
    ULTPOL = 6;
    COND = 2;
    DIGBUSCADO = 9;
type
    rangoPoliza = 1..ULTPOL;
    // Vector de Polizas con sus precios.
    arrayPoliza = array[rangoPoliza] of real;

    // Datos del cliente.
    cliente = record
      cliCod : integer;
      cliDNI : integer;
      cliNom : integer; //string[20]
      cliPol : rangoPoliza;
      cliMon : real;
    end;
    
    // Lista de clientes.
    li = ^no;
    no = record
        dato : cliente;
        sig : li;
    end;

procedure cargaPolizas(var v: arrayPoliza );
var
    i:rangoPoliza;
begin
    for i:= 1 to ULTPOL do begin
        writeln('Ingresar precio adicional.');
        v[i] := Random(5000)+230;//readln(v[i]);
        writeln(v[i]);
    end;
end;

procedure cargaCliente (var c:cliente);
begin
    writeln('Ingresar codigo de cliente.');
    readln(c.cliCod);
    writeln('Ingresar DNI de cliente.');
    c.cliDNI := Random(5000)+1;
    writeln(c.cliDNI);
    //writeln('Ingresar nombre de cliente.');
    c.cliNom := Random(200)+200;//readln(c.cliNom);
    writeln('Ingresar poliza(1..12)');
    c.cliPol := Random(12)+1;
    writeln(c.cliPol);
    writeln('Ingresar monto.');
    c.cliMon := Random(1200)+4241;
    writeln(c.cliMon);
end;
procedure almacenarDatosEnLista (var ult : li; var l:li ; c : cliente);
var
    act : li;
begin
    new(act);
    act^.dato := c;
    act^.sig := nil;
    if (l = nil) then
        l:= act
    else
        act^.sig := ult;
    ult := act;
end;
procedure carga (Var ult: li ; var l:li);
var
    c: cliente;
begin
    repeat
        cargaCliente(c);
        almacenarDatosEnLista(ult,l,c)
    until (c.clicod = CORTE);
end;

function puntoB (n : integer): boolean;
var
    dig,cont : integer;
begin
    cont := 0;
    while (n <> 0 ) and (cont < 2) do begin
        dig := n DIV 10;
        if (dig = 9) then
            cont := cont +1;
        n := n DIV 10 ;
    if (cont = 2) then
        puntoB := true
    else
        puntoB := false;
    end;
end;
procedure puntoA (l : li ; v : arrayPoliza );
begin
    while (l <> nil) do begin
        if (puntoB(l^.dato.cliDNI) = true) then
            writeln('Nombre de la persona a la cual su DNI supera 2 veces: ', l^.dato.cliNom);
        writeln('DNI: ', l^.dato.cliDNI , ' nombre: ' , l^.dato.cliNom , ' monto total a abonar:', l^.dato.cliMon*v[l^.dato.cliPol] );
        l := l^.sig;
    end;
end;
// Programa principal
var
    lista,ult : li;
    vectorPoliza : arrayPoliza;
begin
    lista:= nil;
    ult := nil;
    cargaPolizas(vectorPoliza);
    carga(ult,lista);
    puntoA(lista,vectorPoliza);
end.