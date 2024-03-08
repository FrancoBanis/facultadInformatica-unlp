program ejercicio03;
const
    CORTE = 'fin';
    CONDICION = 70;
type
    empleado  = record
      num : integer;
      apell : string[20];
      edad : integer;
      DNI : integer;
      nom : string[20];
    end;
    archEmp = file of empleado;

procedure leerEmpleado(var e : empleado);
begin
    writeln('-------------------');
    write('Ingresar apellido: ');
    readln(e.apell);
    if (e.apell <> CORTE) then begin
        write('Ingresar nombre: ');
        readln(e.nom);
        write('Ingresar numero de empleado: ');
        e.num := Random(2000)+1;
        writeln(e.num);
        write('Ingresar edad : ');
        e.edad := Random(90)+18;
        writeln(e.edad);
        write('Ingresar DNI: ');
        readln(e.DNI);
    end;
end;
procedure generarArchivo (var a : archEmp;var n:string);
begin
    write('Ingresar nombre del archivo: ');
    readln(n);
    Assign(a,n);
    Rewrite(a);
end;
procedure insertarRegistro (var a: archEmp);
var
    empAct : empleado;
begin
    leerEmpleado(empAct);
    while (empAct.apell <> CORTE) do begin
        write(a,empAct);
        leerEmpleado(empAct);
    end;
end;
procedure informar(e : empleado);
begin
    writeln('--Empleado--');
    writeln('Nombre: ', e.nom);
    writeln('Apellido: ', e.apell);
    writeln('Edad:', e.edad);
    writeln('DNI: ', e.DNI);
    writeln('Numero de empleado: ',e.num);
end;
procedure puntoI (e : empleado ;apBus : string; nomBus: string  );
begin
    if (e.nom = nomBus)  then begin
        writeln('El : ');
        informar(e); 
        writeln(' cumple la condicion de I.');
    end
    else
        if (e.apell = apBus ) then begin
            writeln('El : ');
            informar(e); 
            writeln(' cumple la condicion de I.');
        end;
end;
procedure puntoIII (e : empleado );
begin
    if (e.edad > CONDICION) then begin
        writeln('El : ');
        informar(e);
        writeln(' esta proximo a jubilarse.');
    end;
end;
procedure Listar (var a : archEmp; ult: integer);
var
    i: integer;
    regLeido : empleado;
begin
    for i:= 0 to ult-1 do begin
        Seek(a,i);
        read(a,regLeido);
        puntoI(regLeido,'Banis','Franco');
        puntoIII(regLeido);
        informar(regLeido);
    end;
end;

// Otra manera de hacerlo :
procedure ListarAlter(var a : archEmp; ult:integer);
var
    i,j : integer;
    regLeido : empleado;
begin
    for j := 1 to 3 do begin
        writeln('---------------');
        if (j = 1 ) then begin
            writeln('Empleados a buscar:');
            for i:=0 to ult-1 do begin
                Seek(a,i);
                read(a,regLeido); 
                puntoI(regLeido,'Banis','Franco')
            end;
            writeln('-punto i finalizado-');
        end
        else begin
            if (j = 2) then begin
                writeln('Empleados proximos a jubilarse: ');
                for i:=0 to ult-1 do begin
                    Seek(a,i);
                    read(a,regLeido);
                    puntoIII(regLeido);
                end;
                writeln('-punto iii finalizado-');
            end 
            else begin
                    writeln('Lectura de empleados: ');
                    for i:=0 to ult-1 do begin
                    Seek(a,i);
                    read(a,regLeido);
                    informar(regLeido);
                end;
            end;
        end;
 end;
end;
// Programa principal
var
    archivoAct : archEmp;
    nombreArchivo : string;
    up : integer;
begin
    generarArchivo(archivoAct,nombreArchivo);
    insertarRegistro(archivoAct);
    up := filepos(archivoAct);
    //  Listar(archivoAct,up);
    ListarAlter(archivoAct,up);
    Close(archivoAct);
end.