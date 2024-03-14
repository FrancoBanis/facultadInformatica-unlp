program ejercicio03;
const
    CORTE = 'fin';
    CONDICION = 70;
type
    rangoString = string[20];
    rangoOpciones = 1..5;
    empleado  = record
      num : integer;
      apell : rangoString;
      edad : integer;
      DNI : integer;
      nom : rangoString;
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
    if (e.nom = nomBus) or (e.apell = apBus) then begin
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
procedure opcionesDeListado();
begin
    writeln('------1) Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado, el cual se proporciona desde el teclado.---');
    writeln('------2) Listar en pantalla los empleados de a uno por linea.------');
    writeln('------3) Listar en pantalla los empleados mayores de 70 anios, proximos a jubilarse.------');
    writeln('------4) Finalizar el programa------')
end;
procedure buscarNomyApe (var a : archEmp);
var
    nomBus,apBus : rangoString;
    regLeido : empleado;
begin
    Seek(a,0);
    write('Ingresar nombre a buscar: '); readln(nomBus);
    write('Ingresar apellido a buscar: '); readln(apBus);
    writeln('---------------');
    while not EoF(a) do begin
        read(a,regLeido); 
        puntoI(regLeido,apBus,nomBus);
    end;
    writeln('----busqueda finalizada----');
end;
procedure proximosJubilarse (var a :archEmp);
var
    regLeido : empleado;
begin
    Seek(a,0);
    writeln('Empleados proximos a jubilarse: ');
    while not EoF(a) do begin
        read(a,regLeido);
        puntoIII(regLeido);
        end;
    writeln('-punto iii finalizado-');
end;
procedure recorrerlistado(var a :archEmp);
var
    regLeido: empleado;
begin
    Seek(a,0);
    writeln('Lectura de empleados: ');
    while not EoF(a) do begin
        read(a,regLeido);
        informar(regLeido);
    end;
end;
procedure elegirListado (var a: archEmp);
var
    indiceOpciones : rangoOpciones;
begin
    writeln('----------Menu----------');
    writeln('--------Ingresar que hacer :--------');
    opcionesDeListado();
    write(': '); readln(indiceOpciones);
    while (indiceOpciones <> 4) do begin
        writeln('---------------------------------');
        case indiceOpciones of
            1:  buscarNomyApe(a);
            2:  recorrerlistado(a); 
            3:  proximosJubilarse(a);
        end;
        writeln('---------------------------------');
        opcionesDeListado();
        write(': '); readln(indiceOpciones);
   end;
end;
// Programa principal
var
    archivoAct,archivoCont,archivoFaltantes : archEmp;
    nombreArchivo : rangoString;
begin
    generarArchivo(archivoAct,nombreArchivo);
    insertarRegistro(archivoAct);
    elegirListado(archivoAct);
    Close(archivoAct);
end.