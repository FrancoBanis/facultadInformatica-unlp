program ejercicio04;
const
    TOTALSEM = 42;
    CONDCORTE = -1;
type
    rangoSem = 1..TOTALSEM;
    vSemanas = array[rangoSem] of integer;
    paciente = record
        nomAp : string[15];
        semanas : vSemanas;
        diml : integer;
    end;

    li = ^nodo;
    nodo = record
        dato : paciente;
        sig : li;
    end;

procedure leerPesoSemanal ( var v: vSemanas; var diml : integer);
var
    varPeso: integer;
begin
  varPeso:= 0;
  writeln('Ingresar peso de la semana');
  readln(varPeso);
  while (varPeso <> CONDCORTE) do begin
    diml := diml+1;
    v[diml] := varPeso;
    writeln('Ingresar peso de la semana');
    readln(varPeso);
  end;
end;
procedure leerPaciente ( var p : paciente);
begin
    writeln('Ingresar nombre de paciente');
    readln(p.nomAp);
    if (p.nomAp <> 'zzz') then begin
        p.diml:= 0;
        leerPesoSemanal(p.semanas,p.diml);
    end;
end;
procedure lecturaEjecucion ();
var
    reg : paciente;
begin
    leerPaciente(reg);
    while (reg.nomAp <> 'zzz') do begin
        leerPaciente(reg);
    end;
end;

// Programa principal
begin
    lecturaEjecucion();
end.