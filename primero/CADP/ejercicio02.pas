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
      cliNom : string[20];
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
    i:rangoPoliza
begin
    for i:= 1 to ULTPOL do begin
        writeln("Ingresar precio adicional.")
        readln(v[i]);
    end;
end;

procedure cargaCliente (var c:cli);
begin
    writeln('Ingresar codigo de cliente.');
    readln(c.cliCod);
    writeln('Ingresar DNI de cliente.');
    c.cliDNI := Random(5000)+1;
    writeln(c.cliDNI);
    writeln('Ingresar nombre de cliente.');
    readln(c.cliNom);
    writeln('Ingresar poliza(1..12)');
    c.cliPol := Random(0)+12;
    writeln(c.cliPol);
    writeln('Ingresar monto.');
    c.cliMon := Random(1200)+4241;
    writeln(c.cliMon);
end;
procedure almacenarDatosEnLista (var ult : li;var l:li ; c : cli);
var
    act : li;
begin
    new(act);
    act^.dato := c;
    act := nil;
    if (l = nil) then
        l:= act
    else
        act^.sig := ult;
    ult := act;
end;
procedure carga (Var ult: li ; var l:li);
var
    c: cli;
begin
    repeat
        cargaCliente(c);
        almacenarDatosEnLista(ult,l,c)
    until (c.clicod = CORTE);
end;
// Programa principal
begin
end.