program ejercicio04;
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
    procedure opcionesMenu();
begin
    writeln('------1)Agregar un empleado al archivo.');
    writeln('------2)Modificar edad a una o mas empleados.');
    writeln('------3)Exportar contenido a un .txt.');
    writeln('------4)Exportar a un archivo todos los empleados con DNI faltante.');
    writeln('------5)Finalizar el programa.');
end;
procedure menu ( var archOr : archEmp; var archC : archEmp; var archFal : archEmp);
var
    opciones : rangoOpciones;
begin
    writeln('----------Menu----------');
    writeln('--------Ingresar que hacer :--------');
    opcionesMenu();
    write(': ');readln(opciones);
    while (opciones <> 5) do begin
    case opciones of
    1: agregarEmpleado
    2: modificarEdad
    3: ExportarTxt
    4: ExportarFaltantes
    writeln('Ingresar que hacer:');
    opcionesMenu;
    write(': ');readln(opciones);
    end;
    writeln('--------------------');
end;

var
    archOriginal,archivoFaltantes,archivoCopia : archEmp;
begin
    Assign(archOriginal,'prueba.txt');
    Reset(archOriginal);
    Assign
end.