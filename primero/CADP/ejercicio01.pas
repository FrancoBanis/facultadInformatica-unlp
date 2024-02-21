program ejercicio;
const
	ULT = 12;
	CONDICION = 0;
type
	rango_tipo = 1..ULT;
	
	string_acortado = string[20];
	
	publicacion = record
		titulo_publicacion : string_acortado;
		nombre_autor : string_acortado;
		DNI_autor : integer;
		tipo_publicacion : rango_tipo;
	end;
	
	array_tipo = array[rango_tiport] of integer;
	
	li = ^nodo;
	nodo = record
		nombre : string_acortado;
		contador : integer;
		sig : li;
	end;
	
procedure inicializar_array (var v: array_tipo);
var
	i : rango_tipo;
begin
	for i:= 1 to ULT do
		v[i] := 0;
end;

procedure leer_publicacion (var publicacion_actual : publicacion);
begin
	writeln('Ingresar DNI del autor');
	readln(publicacion_actual.DNI_autor);
	if (publicacion_actual.DNI_autor <> CONDICION) then begin
		writeln('Ingresar titulo de publicacion');
		readln(publicacion_actual.titulo_publicacion);
		writeln('Ingresar nombre de autor');
		readln(publicacion_actual.nombre_autor);
		writeln('Ingresar tipo de publicacion(1..12)'); 
		//readln(publicacion_actual.tipo_publicacion);
		publicacion_actual.tipo_publicacion := Random(11)+1; 
		writeln(publicacion_actual.tipo_publicacion);
	end;
end;

procedure agregar_adelante (var l:li ; nombre_autor_actual : string; contador : integer);
var
	new_nodo : li;
begin
	new(new_nodo);
	new_nodo^.nombre := nombre_autor_actual;
	new_nodo^.contador := contador;
	new_nodo^.sig := l;
	l := new_nodo;
end;

procedure acomodar_informacion (var l:li ; var v: array_tipo);
var
	p : publicacion;
	DNI_act,contador : integer;
begin
	p.DNI_autor := 0;
	contador := 0;
	leer_publicacion(p);
	while (p.DNI_autor <> CONDICION) do begin
		DNI_act := p.DNI_autor;
		while (p.DNI_autor <> CONDICION) and (DNI_act = p.DNI_autor) do begin
			contador := contador + 1;
			v[p.tipo_publicacion] := v[p.tipo_publicacion] +1;
				leer_publicacion(p);
				end;
		agregar_adelante (l,p.nombre_autor,contador);

	end;
end;

procedure mayor_publicacion (v : array_tipo);
var
	max_tipo,max : integer;
	i: rango_tipo;
begin
	max_tipo := -1; max:= -1;
	for i:= 1 to ULT do begin
		if (v[i] > max) then begin
		max:= v[i];		
		max_tipo := i;
	end;
end;
	writeln(max_tipo); // Posicion del array donde se encuentra el maximo.
end;

procedure publicaciones_autores (l : li);
begin
	while (l <> nil) do begin
		writeln(l^.nombre);
		writeln(l^.contador);
		l := l^.sig;
	end;
end;

var
	arrtipos : array_tipo;
	li_autores : li;
begin
	li_autores := nil;
	inicializar_array(arrtipos);
	acomodar_informacion(li_autores,arrtipos);
	mayor_publicacion(arrtipos);
	publicaciones_autores(li_autores);
end.
