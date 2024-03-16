program ejercicio04;
const
    CORTE = 'fin';
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

procedure opcionesMenu();
begin
    writeln('------1)Agregar un empleado al archivo.');
    writeln('------2)Modificar edad a una o mas empleados.');
    writeln('------3)Exportar contenido a un .txt.');
    writeln('------4)Exportar a un archivo todos los empleados con DNI faltante.');
    writeln('------5)Finalizar el programa.');
end;
procedure AgregarEmpleado(var arch : archEmp);
var
    empLeido : empleado;
    consulta : char;
begin
    leerEmpleado(empLeido);
    Seek(arch,FileSize(arch));
    write(arch,empLeido);
    write('Agregar otro empleado? S/N: ');
    readln(consulta);
    while (consulta <> 'N') do begin
        leerEmpleado(empLeido);
        write(arch,empLeido);
        write('Agregar otro empleado? S/N: ');
        readln(consulta);
    end;
end;
procedure modificarEdad (var arch : archEmp);
var
    numMod : integer;
    empAct : empleado;
    consulta: char ;
begin
    write('Ingresar numero de empleado: '); 
    readln(numMod);
    Seek(arch,0);
    read(arch,empAct);
    while (numMod <> empAct.num) and (not EOF(arch)) do
        read(arch,empAct);
    write('Ingresar cambio de edad: '); readln(empAct.edad);
    write(arch,empAct);
    write('Cambiar otra edad? S/N:'); readln(consulta);
    while (consulta <> 'N') do begin
        write('Ingresar numero de empleado: '); readln(numMod);
        Seek(arch,0);
        read(arch,empAct);
        while (numMod <> empAct.num) and (not EOF(arch)) do
            read(arch,empAct);
        write('Ingresar cambio de edad: '); readln(empAct.edad);
        write(arch,empAct);
        write('Cambiar otra edad? S/N:'); readln(consulta);
    end;
end;
procedure exportar_empleados(var arch :archEmp);
var
    archivoCopia : text;
    empAct : empleado;
begin
    Assign(archivoCopia,'todos_empleados.txt');
    Rewrite(archivoCopia);
    Seek(arch,0);
    while not EOF(arch) do begin
        read(arch,empAct);
        write(archivoCopia,' ',empAct.num,' : Apellido y nombre : ',empAct.apell, ' ',empAct.nom,' edad: ',empAct.edad,' dni: ',empAct.DNI,'. ');
    end;
    Close(archivoCopia);
end;
procedure exportar_faltantes (var arch : archEmp);
var
    archivoFaltantes: text;
    empAct : empleado;
begin
    Assign(archivoFaltantes,'faltaDNIEmpleado.txt');
    Rewrite(archivoFaltantes);
    while not EOF(arch) do begin
        read(arch,empAct);
        if (empAct.DNI = 0) then
            write(archivoFaltantes,' ',empAct.num,' : Apellido y nombre : ',empAct.apell, ' ',empAct.nom,' edad: ',empAct.edad,' dni: ',empAct.DNI,'. '); 
    end;
    Close(archivoFaltantes);
end;
procedure menu ( var archOr : archEmp);
var
    opciones : rangoOpciones;
begin
    writeln('----------Menu----------');
    writeln('--------Ingresar que hacer :--------');
    opcionesMenu();
    write(': ');readln(opciones);
    while (opciones <> 5) do begin
    case opciones of
     1 : AgregarEmpleado(archOr);
     2 : modificarEdad(archOr);
     3 : exportar_empleados(archOr);
     4 : exportar_faltantes(archOr);
    end;
    writeln('Ingresar que hacer:');
    opcionesMenu;
    write(': ');readln(opciones);
    end;
    close(archOr);
    writeln('--------------------');
end;

var
    archOriginal : archEmp;
begin
    Assign(archOriginal,'prueba.txt');
    Reset(archOriginal);
    menu(archOriginal);
end.