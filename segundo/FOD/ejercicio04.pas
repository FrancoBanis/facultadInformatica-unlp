program ejercicio04;
const
type
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
    writeln('Ingresar que hacer:');
    opcionesMenu;
    write(': ');readln(opciones);
    end;
    writeln('--------------------');

end;