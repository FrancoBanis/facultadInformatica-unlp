program ejercicio06;
const
    CONDICION = 0;
type
    rango_nombre = string[15];
    rango_descripcion = string[150];
    rCelulares = record
        cod : integer;
        nom : rango_nombre;
        marca : rango_nombre;
        descripcion : rango_descripcion;
        precio : real;
        stockMin : integer;
        stockDis : integer;
    end;
    archCel = file of rCelulares;
procedure leerCelular ( var r : rCelulares);
begin
    write('Ingresar codigo del celular: '); readln(r.cod);
    write('Ingresar nombre del celular: '); readln(r.nom);
    write('Ingresar descripcion del celular: '); readln(r.descripcion);
    write('Ingresar precio del celular: '); readln(r.precio);
    write('Ingresar stock minimo del celular: '); readln(r.stockMin);
    write('Ingresar stock disponiblez del celular: '); readln(r.stockDis);
end;
procedure mensaje();
begin
    writeln('--------------------------------------------------------');
    writeln('--------------------------MENU--------------------------');
    writeln('a.) Añadir celular.');
    writeln('b.) Modificar stock de celular.');
    writeln('c.) Exportar a los celulares sin stock a sinStock.txt.');
    writeln('d.) Finalizar programa.');
    writeln('-------------------------------------------------------');
end;
procedure añadirAlCatalogo ();
var
begin
end;
procedure menu();
var
    varSeleccionadora : char;
begin
    mensaje();
    while (varSeleccionadora <> 'd') do begin
        write(': '); readln(varSeleccionadora);
        {case varSeleccionadora of 
            'a':
            'b':
            'c':
        end;}
    end;
    mensaje();
end;
begin
  menu()
  
end.