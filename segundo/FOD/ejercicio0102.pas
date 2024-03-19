program ejercicio0102;
const
    CORTE = 30000;
    CONDICION = 1500;
type
    archNum = file of integer;
var
    nomEl : string;
    archivoNumeros : archNum;
    numLeido,i,numAct,total,contador : integer;
    prom : real;
begin
  write('Ingresar nombre del archivo: ');
  readln(nomEl);
  Assign(archivoNumeros, nomEl);
  Rewrite(archivoNumeros);
  write('Ingresar numero: ');
  readln(numLeido);
  while( numLeido <> CORTE) do begin
    write(archivoNumeros,numLeido);
    write('Ingresar numero: ');
    readln(numLeido);
  end;  
  total := filepos(archivoNumeros);
  writeln('Total: ', total);
  for i:=filepos(archivoNumeros)-1 downto 0  do begin
    Seek(archivoNumeros,filepos(archivoNumeros)-1);
    read(archivoNumeros,numAct);
    if (numAct < CONDICION) then 
        writeln(numAct);
    contador := contador + numAct;
    Seek(archivoNumeros,filepos(archivoNumeros)-1);
    end;
    prom := contador / total;
    writeln('Promedio   : ', prom);
    Close(archivoNumeros);
end.