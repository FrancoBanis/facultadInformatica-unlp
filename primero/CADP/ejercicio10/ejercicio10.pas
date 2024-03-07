program ejercicio10;
const
    LIM = 20;
    CORTEEMP = -1;
    CORTECULT = 0;
    COND = 'San Miguel del Monte';
    CONDB = 'Trigo';
    CONDC = 'Soja';
    CONDD = 'Maíz';
    CONDE = 'Girsaol';
    CONDED = 5;
type
    rangoCult = 1..LIM;

    cultivos = record
        tipo : string[15];
        canthect : integer;
        tiemp : integer;
    end;
    vCult = array[rangoCult] of cultivos;
    empresa = record
      cod : integer;
      nom : string[20];
      cui : string[20];
      cond: string[7]; 
      dimL : integer;
      totCult : vCult;
    end;

    li = ^nodo;
    nodo = record
        d : empresa;
        s : li
    end;

//
    // Array dentro de empresa. totcult.
procedure leerCul (var c : cultivos);
begin
    writeln('--------------');
    write('Ingresar cantidad de hectareas: ');
    readln(c.canthect);
    if (c.canthect <> CORTECULT) then begin
        write('Ingresar tipo de cultivo: ');
        readln(c.tipo);
        write('Ingresar cantidad de tiempo: '); 
        c.tiemp := Random(12)+1; writeln(c.tiemp);
    end;        
end;
procedure cargarVCult ( var v: vCult ; var dimlog : integer);
var
    cultAct : cultivos;
begin
    leerCul(cultAct);
    while (cultAct.canthect <> CORTECULT) and (dimlog < LIM) do begin
        dimlog := dimlog +1;
        v[dimlog] := cultAct;
        leerCul(cultAct);
    end;
end;
    // empresa
procedure leerEmp (var e:empresa);
begin
    writeln('////Empresa////');
    write('Ingresar codigo de empresa: ');
    readln(e.cod);
    if (e.cod <> CORTEEMP) then begin
        write('Ingresar nombre de empresa: ');
        readln(e.nom);
        write('Ingresar nombre de cuidad: ');
        readln(e.cui);
        write('Ingresar condicion de empresa: ');
        readln(e.cond);
        e.dimL := 0;
        writeln('///Cultivos///');
        cargarVCult(e.totCult,e.dimL);
    end;
end;
procedure inNodo (var ult: li; var l : li ; r : empresa);
var
    nue: li;
begin
    new(nue);
    nue^.d := r;
    nue^.s := nil;
    if (l = nil) then
        l := nue
    else
        ult^.s := nue;
    ult := nue;
end;
procedure cargarLi (var ult : li ; var l : li);
var
    empAct : empresa;
begin
    leerEmp(empAct);
    while (empAct.cod <> CORTEEMP) do begin
        inNodo(ult,l,empAct);
        leerEmp(empAct);
    end;
end;
//  puntos
function soloCONDB (v : vCult; dimL : integer): boolean;
var
    i: rangoCult;
begin
    soloCONDB := true;
    i:= 1;
    while ( i < dimL) and (soloCONDB <> true) do begin
        if (v[i].tipo <> CONDB) then
            soloCONDB := false;
        i:= i+1;
    end;
end;
function descomponer (num : integer): boolean;
var
    dig ,cont : integer;
begin
    cont := 0; dig := 0;
    while (num <> 0) and (cont < 2) do begin
        dig := dig MOD 10;
        if (dig = 0) then
            cont:= cont+1;
        num := num DIV 10;
    end;    
    descomponer := (cont = 2);
end;
procedure recorrerVect (var nomMax : string; nom : string ;var max: integer; var contadorCONDC : integer  ;var  v: vCult ; dimL : integer );
var
    i : rangoCult;
begin
    for i:= 1 to dimL do begin
        writeln('degg');
        if (v[diml].tipo = CONDC) then
            contadorCONDC :=contadorCONDC + v[diml].canthect;
        if (v[diml].tipo = CONDD) then
            if (v[diml].tiemp > max) then begin
                nomMax:= nom;
                max := v[diml].tiemp;
            end;
        if (v[diml].tipo = CONDE) and (v[diml].canthect >= CONDED) then
            v[diml].tiemp := v[diml].tiemp +1;
    end;
end;
procedure recorrerLista ( l : li);
var
    maximo,contadorC,totalHect : integer;
    maximoNom : string;
    prom: real;
begin
    totalHect := 0; contadorC := totalHect; prom := totalHect;
    maximo:= -1 ; maximoNom := '';
    while (l <> nil) do begin
        if (l^.d.cui = COND) and (soloCONDB(l^.d.totcult,l^.d.dimL) = true) and (descomponer(l^.d.cod) = true) then
            writeln('Nombre de empresa que cumple condiciones: ', l^.d.nom);
        recorrerVect(maximoNom,l^.d.nom,maximo,contadorC,l^.d.totCult,l^.d.dimL);
        totalHect := l^.d.dimL + totalHect;
        l:= l^.s;
    end;
    if (contadorC = 0) then
        prom := 0
    else
        prom := totalHect / contadorC;
    writeln('Porcentaje: ', totalHect , '%');
    writeln('Mayor cultivo de maiz: ', maximoNom);
end;
procedure recorrer (l : li);
begin
    while (l <> nil ) do begin
        writeln('./// ');
        writeln(l^.d.cod);
        writeln('Dimension logica: ', l^.d.diml);
        l:= l^.s;
    end;
end;
// programa principal
var
    ult,listaEmpresas : li;
begin
    ult := nil;
    listaEmpresas := nil;
    cargarLi(ult,listaEmpresas);
    recorrer(listaEmpresas);
    recorrerLista(listaEmpresas);
end.