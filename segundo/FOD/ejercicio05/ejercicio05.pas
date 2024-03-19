program ejercicio05;

type
    rango_nombre = string[25];
    rango_descripcion = string[150];
    reg_celulares = record
        cod : integer;
        nom : rango_nombre;
        marca: rango_nombre;
        descripcion : rango_descripcion;
        precio : real;
        stockMin : integer;
        stockDis : integer;
    end;
    archivoCelulares = file of reg_celulares;

procedure leerCelular(var c:reg_celulares);
begin
    writeln('----');
    write('Ingresar codigo de celular: ');
    c.cod := Random(500)+1; writeln(c.cod);
    write('Ingresar nombre del celular: ');
    readln(c.nom);
    write('Ingresar marca del celular: ');
    readln(c.marca);
    write('Ingresar descripcion del celular: ');
    readln(c.descripcion);
    write('Ingresar precio del celular: ');
    c.precio := Random(500)+1 / Random(500)+1;
    writeln(c.precio);
    write('Ingresar stock minimo: ');
    c.stockMin := Random(150)+1;
    writeln(c.stockMin);
    write('Ingresar stock disponible: ');
    c.stockDis := Random(150);
    writeln(c.stockDis);
end;
procedure listarEnPantalla (var arch : archivoCelulares);
var
    regAct : reg_celulares; 
begin
    Seek(arch,0);
    read(arch,regAct);
    while not eof(arch) do begin
        if (regAct.stockDis < regAct.stockMin) then begin
            writeln('-- Celular con stock inferior --');
            writeln('Codigo: ', regAct.cod);
            writeln('Marca: ', regAct.marca);
            writeln('Precio: ', regAct.precio);
            writeln('---------------------------------');
            
        end;
        read(arch,regAct);
    end;
end;
procedure generarTxtCelulares(var arch : text);
var
    cel : reg_celulares;
    i : integer;
begin
    for i:=1 to 3 do begin
        leerCelular(cel);
        writeln(arch, cel.cod,' ',cel.marca,' ',cel.precio);
        writeln(arch,cel.descripcion,' ',cel.stockMin,' ',cel.stockDis);
        writeln(arch,cel.nom);
    end;
end;
procedure buscarPorDescripcion(var archCel : archivoCelulares);
var
    descIng : rango_descripcion;
    celLeido : reg_celulares;
begin
    Seek(archCel,0);
    writeln('--------------------------------------');
    write('Ingresar datos descriptivos a buscar: '); 
    readln(descIng);
    read(archCel,celLeido);
    while not eof(archCel) do begin    
        if (celLeido.descripcion = descIng) then begin
            writeln('La descripcion ingresada encaja con: ');
            writeln('Nombre: ', celLeido.nom, '.');
        end;
        read(archCel,celLeido);
    end;
end;
procedure crearArchivoNuevo ( var archCel : archivoCelulares;var nomArch: rango_nombre);
var
    cel : reg_celulares;
    texto_logico: text;
begin
    Assign(texto_logico,'celulares.txt');
    Reset(texto_logico);
    write('Ingresar nombre del archivo: ');
    readln(nomArch);
    Assign(archCel,nomArch);
    Rewrite(archCel);
    while (not eof(texto_logico)) do begin
        readln(texto_logico, cel.cod,cel.precio,cel.marca);
        readln(texto_logico, cel.stockMin,cel.stockDis,cel.descripcion);
        readln(texto_logico, cel.nom);
        Write(archCel,cel);
    end;
    close(texto_logico);
end;
procedure opciones ();
begin
    writeln(' --- Menu --- ');
    writeln('--- A) Crear un archivo.');
    writeln('--- B) Listar en pantalla con stock menor al minimo.');
    writeln('--- C) Buscar por descripcion.');
    writeln('--- D) Exportar el archivo creado a "celulares.txt" ');
    writeln('--- E) Finalizar.');
    writeln('-----------------------------');
end;
procedure exportarATxt (var a: archivoCelulares);
var
    celularesV2 : text;
    cel : reg_celulares;
begin
    Assign(celularesV2,'celularesV2.txt');
    Rewrite(celularesV2);
    Seek(a,0);
    while not eof(a) do begin
        Read(a,cel);
        writeln(celularesV2,' ',cel.nom,' ', cel.descripcion,' ',cel.precio);
    end;
    close(celularesV2);
end;
procedure menu ( );
var
    op: char;
    archNue : archivoCelulares;
    nomEl : rango_nombre;
begin
    opciones();
    write(': '); readln(op);
    while(op <> 'E') do begin
        case op of 
        'A': crearArchivoNuevo(archNue,nomEl);
        'B': listarEnPantalla(archNue);
        'C': buscarPorDescripcion(archNue);
        'D': exportarATxt(archNue);
        end;
        opciones();
        write(': '); readln(op);
    end;
    close(archNue);
end;
var
    archivoTextoCelulares : text;
begin
{ Assign(archivoTextoCelulares,'celulares.txt');
  Rewrite(archivoTextoCelulares);
 generarTxtCelulares(archivoTextoCelulares);
  close(archivoTextoCelulares);}
  menu();
end.