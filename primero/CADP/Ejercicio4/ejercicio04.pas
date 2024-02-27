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
    v[diml] := varPeso;
    diml := diml+1;
    writeln('Ingresar peso de la semana');
    readln(varPeso);
  end;
end;
procedure leerPaciente ( var p : paciente);
begin
    writeln('Ingresar nombre de paciente');
    readln(p.nomAp);
    if (p.nomAp <> 'zzz') then begin
        p.diml:= 1;
        leerPesoSemanal(p.semanas,p.diml);
    end;
end;
function aumentoTotal (v : vSemanas; diml:integer): integer;
var
    i,cont: integer;
begin
    cont:= 0;
    for i:= 1 to diml do 
        cont := cont + v[i];
    aumentoTotal := cont;
end;
procedure mayorAumento (v : vSemanas; diml: integer);
var
    i,mayorSemana,maxPeso : integer;
begin
    mayorSemana:= -1; maxPeso:= -1;
    for i := 1 to diml do begin
        if (maxPeso < v[i]) then begin
            maxPeso := v[i];
            mayorSemana := i;
        end;
    end; 
    writeln('La semana con mayor aumento de peso es: ', mayorSemana);
end;
procedure lecturaEjecucion ();
var
    reg : paciente;
begin
    leerPaciente(reg);
    while (reg.nomAp <> 'zzz') do begin
        mayorAumento(reg.semanas,reg.diml);
        writeln('El aumento total del peso es: ',aumentoTotal(reg.semanas,reg.diml));
        leerPaciente(reg);
    end;
end;

// Programa principal
begin
    lecturaEjecucion();
end.