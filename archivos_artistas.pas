unit archivos_artistas;

interface
         uses crt;

         type
             st10=string[10];
             st20=string[20];
             st30=string[30];
             st100=string[100];

             r_artistas=record
                     nombre_artista:st20;
                     direccion_artista:st30;
                     ciudad_artista:st30;
                     pais_artista:st30;
                     dni_artista:integer;
                     estado_artista:boolean;
                     end;
         t_artistas = file of r_artistas;

         procedure abrir_archivo_artista(var arch:t_artistas; nom_arch:string);
         procedure leer_artista(var arch:t_artistas; nom_arch:string; var pos:integer; var dato_leido:r_artistas);
         procedure guardar_artista(var arch:t_artistas ; nom_arch:string ; var escribir_dato:r_artistas);
         procedure modificar_artista(var arch:t_artistas; nom_arch:string ;pos:integer);
         procedure busqueda_nombre_artista(var arch:t_artistas; nom_arch:string; buscado:st20; var pos:integer);
         procedure busqueda_dni_artista(var arch:t_artistas; nom_arch:string; buscado:integer; var pos:integer);
         procedure alta_artista(var arch:t_artistas; nom_arch:string; var reg:r_artistas);
         procedure baja_artista(var arch:t_artistas; nom_arch:string; var pos:integer);
         procedure alta_estado_artista(var arch:t_artistas; nom_arch:string; var pos:integer);
         procedure eliminar_archivo_artista(var arch:t_artistas);


implementation
              procedure abrir_archivo_artista(var arch:t_artistas;  nom_arch:string); //Abre archivo de tipo texto en modo escritura que borra el contenido y escribe
              begin
                   assign(arch, nom_arch);
                   {$I-}                           //{$I-} directiva para deshabilitar mensajes de error de el sistema operativo.
                        reset(arch);
                   {$I-}
                   if ioresult<>0 then
                      rewrite(arch); //Si la directiva {$I-} devuelve un valor distinto de cero quiere decir que no existe el fichero o hay un problema.
              end;
              procedure leer_artista(var arch:t_artistas; nom_arch:string; var pos:integer; var dato_leido:r_artistas); //Lee en el archivo lo que esta en la posicion de pos y lo guarda en dato_leido
              begin
                   abrir_archivo_artista(arch, nom_arch);
                   seek(arch, pos);                  //seek posiciona el puntero en la posicion que indica el segundo parametro
                   read(arch, dato_leido);        //recorre el archivo y lee secuencialmente
                   close(arch);
              end;

              procedure guardar_artista(var arch:t_artistas; nom_arch:string ; var escribir_dato:r_artistas); //Va hasta el final del archivo y guarda lo que hay en escribir_dato
              begin
                   abrir_archivo_artista(arch, nom_arch);
                   seek(arch, filesize(arch));          //Filesize nos da el tamaño del archivo. Con seek posicionamos en lo que nos de Filesize porque siempre va a ser la ultima posicion
                   write(arch, escribir_dato);         //Escribe en el archivo lo que hay en escribir dato
                   close(arch);
              end;

              procedure modificar_artista(var arch:t_artistas; nom_arch:string ;pos:integer);
              var
                 x,y,i:integer;           //x;y son de coordenadas para hacer el recuadro que se muestra en pantalla. i es el indice para un ciclo for.
                 reg:r_artistas;          //reg es un registro auxiliar que nos sirve para levantar los datos que queremos modificar desde el archivo
                 control:char;
              begin
                   clrscr;
                   leer_artista(arch, nom_arch, pos, reg);
                   if reg.estado_artista then
                   begin
                   clrscr;
                 textcolor (blue);
                 x:=20;
                 y:=3;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=60;
                 y:=3;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=21;
                 y:=16;
                 For i:=1 to 41 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=102;
                 y:=3;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=21;
                 y:=2;
                 For i:=1 to 41 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                   textcolor (white);
                   gotoxy(53,1);
                   writeln('Modificar Artista');
                   gotoxy(21,4);
                   writeln('Nombre: ', reg.nombre_artista);
                   gotoxy(21,5);
                   writeln('Direccion: ', reg.direccion_artista);
                   gotoxy(21,6);
                   writeln('Ciudad: ', reg.ciudad_artista);
                   gotoxy(21,7);
                   writeln('Pais: ', reg.pais_artista);
                   gotoxy(61,3);
                   writeln(#168,'Que desea modificar?');
                   gotoxy(61,4);
                   writeln('1: Nombre: ');
                   gotoxy(61,5);
                   writeln('2: Direccion: ');
                   gotoxy(61,6);
                   writeln('3: Ciudad: ');
                   gotoxy(61,7);
                   writeln('4: Pais: ');
                   gotoxy(61,8);
                   writeln('ESC: Salir ');
                   repeat
                         gotoxy(21,9);
                         control:=readkey;
                         keypressed;
                         case control of
                              '1':begin
                                       gotoxy(72,4);
                                       writeln('                  ');
                                       gotoxy(72,4);
                                       readln(reg.nombre_artista);
                                       gotoxy(29,4);
                                       writeln('                  ');
                                       gotoxy(29,4);
                                       writeln(reg.nombre_artista);
                                       reg.estado_artista:=true;
                                       abrir_archivo_artista(arch, nom_arch);
                                       seek(arch, pos);
                                       write(arch, reg);
                                       close(arch);
                                  end;
                              '2':begin
                                       gotoxy(75,5);
                                       writeln('                  ');
                                       gotoxy(75,5);
                                       readln(reg.direccion_artista);
                                       gotoxy(32,5);
                                       writeln('                  ');
                                       gotoxy(32,5);
                                       writeln(reg.direccion_artista);
                                       reg.estado_artista:=true;
                                       abrir_archivo_artista(arch, nom_arch);
                                       seek(arch, pos);
                                       write(arch, reg);
                                       close(arch);
                                  end;
                              '3':begin
                                       gotoxy(72,6);
                                       writeln('                  ');
                                       gotoxy(72,6);
                                       readln(reg.ciudad_artista);
                                       gotoxy(29,6);
                                       writeln('                  ');
                                       gotoxy(29,6);
                                       writeln(reg.ciudad_artista);
                                       reg.estado_artista:=true;
                                       abrir_archivo_artista(arch, nom_arch);
                                       seek(arch, pos);
                                       write(arch, reg);
                                       close(arch);
                                  end;
                              '4':begin
                                       gotoxy(69,7);
                                       writeln('                  ');
                                       gotoxy(70,7);
                                       readln(reg.pais_artista);
                                       gotoxy(27,7);
                                       writeln('                  ');
                                       gotoxy(27,7);
                                       writeln(reg.pais_artista);
                                       reg.estado_artista:=true;
                                       abrir_archivo_artista(arch, nom_arch);
                                       seek(arch, pos);
                                       write(arch, reg);
                                       close(arch);
                                  end;
                          end;
                   until control=#27;
                   end
                      else
                          begin
                               writeln('El artista esta dado de baja');
                               readkey;
                          end;
              end;

              procedure busqueda_nombre_artista(var arch:t_artistas; nom_arch:string; buscado:st20; var pos:integer);
              var
                 reg_aux:r_artistas;
                 i:integer;
              begin
                   i:=0;
                   pos := -1;
                   abrir_archivo_artista(arch, nom_arch);
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.nombre_artista = buscado then
                           begin
                                pos:=i;
                           end;
                        i:=i+1;
                        seek(arch, i);
                   end;
                   close(arch);
              end;

              procedure busqueda_dni_artista(var arch:t_artistas; nom_arch:string; buscado:integer; var pos:integer);
              var
                 reg_aux:r_artistas;
                 i:integer;
              begin
                   i:=0;
                   pos := -1;
                   abrir_archivo_artista(arch, nom_arch);
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.dni_artista = buscado then
                           begin
                                pos:=i;
                           end;
                        i:=i+1;
                        seek(arch, i);
                   end;
                   close(arch);
              end;

              procedure baja_artista(var arch:t_artistas; nom_arch:string; var pos:integer);
              var
                 reg:r_artistas;
              begin
                   leer_artista(arch, nom_arch, pos, reg);
                   reg.estado_artista:=false;
                   abrir_archivo_artista(arch, nom_arch);
                   seek(arch, pos);
                   write(arch, reg);
                   close(arch);
              end;

              procedure alta_estado_artista(var arch:t_artistas; nom_arch:string; var pos:integer);
              var
                 reg:r_artistas;
              begin
                   leer_artista(arch, nom_arch, pos, reg);
                   reg.estado_artista:=true;
                   abrir_archivo_artista(arch, nom_arch);
                   seek(arch, pos);
                   write(arch, reg);
                   close(arch);
              end;

              procedure alta_artista(var arch:t_artistas; nom_arch:string; var reg:r_artistas);
              var
                 posi,x,y,i:integer;
                 control:char;
                 asd:string;
                 validacion:integer;
              begin
                   clrscr;
                 textcolor (blue);
                 x:=44;
                 y:=2;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=45;
                 y:=15;
                 For i:=1 to 27 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=97;
                 y:=2;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=45;
                 y:=1;
                 For i:=1 to 26 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                   textcolor (white);
                   posi:=-1;
                   gotoxy(63,2);
                   writeln('Alta de Artista');
                   gotoxy(45,4);
                   writeln('Nombre y apellido: ');
                   gotoxy(45,5);
                   writeln('DNI: ');
                   gotoxy(45,6);
                   writeln('Direccion: ');
                   gotoxy(45,7);
                   writeln('Ciudad: ');
                   gotoxy(45,8);
                   writeln('Pais: ');
                   gotoxy(64,4);
                   readln(asd);
                   busqueda_nombre_artista(arch, nom_arch, asd, posi);
                   if posi = -1 then
                      begin
                           reg.nombre_artista:=asd;
                           repeat
                                  gotoxy(50,5);
                                  writeln('                   ');
                                  gotoxy(50,5);
                                 {$I-}
                                      readln(reg.dni_artista);
                                 {$I+}
                                 validacion:=ioresult();
                                 if validacion=0 then
                                    begin
                                         busqueda_dni_artista(arch, nom_arch, reg.dni_artista, posi);
                                         if posi>-1  then
                                            begin
                                                 gotoxy(45,10);
                                                 textcolor (red);
                                                 writeln('El dni del artista ya existe. Debe ingresar otro');
                                                 textcolor (white);
                                            end;
                                    end
                                       else
                                           begin
                                                gotoxy(45,10);
                                                textcolor (red);
                                                writeln('Debe ingresar solo numeros');
                                                textcolor (white);
                                           end;
                           until (posi=-1) and (validacion=0);
                           gotoxy(45,10);
                           writeln('                                                 ');
                           gotoxy(56,6);
                           readln(reg.direccion_artista);
                           gotoxy(53,7);
                           readln(reg.ciudad_artista);
                           gotoxy(51,8);
                           readln(reg.pais_artista);
                           reg.estado_artista:=true;
                           guardar_artista(arch, nom_arch, reg);
                           gotoxy(45,10);
                           textcolor (green);
                           writeln('Listo!');
                           textcolor (white);
                           readkey;
                      end
                         else
                             begin
                                  leer_artista(arch, nom_arch, posi, reg);
                                  if (reg.estado_artista) then
                                     begin
                                          repeat
                                                gotoxy(45,10);
                                                writeln('Este artista ya esta registrado.', #168'Que desea hacer?');
                                                gotoxy(45,11);
                                                writeln('1: Modificar');
                                                gotoxy(45,12);
                                                writeln('2: Dar de baja');
                                                gotoxy(45,13);
                                                writeln('3: Cargar igual');
                                                gotoxy(45,14);
                                                writeln('ESC: Volver');
                                                control:=readkey;
                                                keypressed;
                                                if (control = '1') then
                                                   modificar_artista(arch, nom_arch, posi)
                                                      else
                                                          if (control='2') then
                                                             begin
                                                                  gotoxy(45,10);
                                                                  writeln('                                                 ');
                                                                  gotoxy(45,11);
                                                                  writeln('                         ');
                                                                  gotoxy(45,12);
                                                                  writeln('                         ');
                                                                  gotoxy(45,13);
                                                                  writeln('                         ');
                                                                  gotoxy(45,14);
                                                                  writeln('                        ');
                                                                  baja_artista (arch,nom_arch, posi);
                                                                  gotoxy(45,10);
                                                                  textcolor (green);
                                                                  writeln('Listo!');
                                                                  textcolor (white);
                                                                  readkey;
                                                             end
                                                             else
                                                                 if (control='3') then
                                                                    begin
                                                                         gotoxy(45,10);
                                                                         writeln('                                                 ');
                                                                         gotoxy(45,11);
                                                                         writeln('                                                 ');
                                                                         gotoxy(45,12);
                                                                         writeln('                                                 ');
                                                                         gotoxy(45,13);
                                                                         writeln('                                                 ');
                                                                         gotoxy(45,14);
                                                                         writeln('                                                 ');
                                                                         repeat
                                                                               gotoxy(50,5);
                                                                               writeln('                                        ');
                                                                               gotoxy(50,5);
                                                                               {$I-}
                                                                                    readln(reg.dni_artista);
                                                                               {$I+}
                                                                               validacion:=ioresult();
                                                                               if validacion=0 then
                                                                                  begin
                                                                                       busqueda_dni_artista(arch, nom_arch, reg.dni_artista, posi);
                                                                                       if posi>-1  then
                                                                                          begin
                                                                                               gotoxy(45,10);
                                                                                               textcolor (red);
                                                                                               writeln('El dni del artista ya existe. Debe ingresar otro');
                                                                                               textcolor (white);
                                                                                          end;
                                                                                  end
                                                                                     else
                                                                                         begin
                                                                                              gotoxy(45,10);
                                                                                              textcolor (red);
                                                                                              writeln('Debe ingresar solo numeros');
                                                                                              textcolor (white);
                                                                                         end;
                                                                         until (posi=-1) and (validacion=0);
                                                                         gotoxy(45,10);
                                                                         writeln('                                                 ');
                                                                         gotoxy(56,6);
                                                                         readln(reg.direccion_artista);
                                                                         gotoxy(53,7);
                                                                         readln(reg.ciudad_artista);
                                                                         gotoxy(51,8);
                                                                         readln(reg.pais_artista);
                                                                         reg.estado_artista:=true;
                                                                         guardar_artista(arch, nom_arch, reg);
                                                                         gotoxy(45,10);
                                                                         textcolor (green);
                                                                         writeln('Listo!');
                                                                         textcolor (white);
                                                                         readkey;
                                                                    end
                                                                       else
                                                                           if (control=#27) then
                                                                              clrscr
                                                                                 else
                                                                                     begin
                                                                                          gotoxy(45,10);
                                                                                          writeln('                                                 ');
                                                                                          gotoxy(45,11);
                                                                                          writeln('                                                 ');
                                                                                          gotoxy(45,12);
                                                                                          writeln('                                                 ');
                                                                                          gotoxy(45,13);
                                                                                          writeln('                                                 ');
                                                                                          gotoxy(45,14);
                                                                                          writeln('                                                 ');
                                                                                          gotoxy(45,10);
                                                                                          textcolor(red);
                                                                                          writeln('La tecla ingresada es erronea...');
                                                                                          textcolor(white);
                                                                                          readkey;
                                                                                     end;
                                          until (control = '1') or (control='2') or (control='3') or (control = #27);
                                     end
                                     else
                                     begin
                                         repeat
                                               gotoxy(45,11);
                                               writeln('1: Dar de alta');
                                               gotoxy(45,10);
                                               writeln('Este artista esta registrado pero esta dada de baja.');
                                               gotoxy(45,12);
                                               writeln('ESC: Volver');
                                               control:=readkey;
                                               keypressed;
                                               if (control = '1') then
                                                  begin
                                                       gotoxy(45,11);
                                                       writeln('                                                 ');
                                                       gotoxy(45,10);
                                                       writeln('                                                    ');
                                                       gotoxy(45,12);
                                                       writeln('                                                 ');
                                                       alta_estado_artista(arch, nom_arch, posi);
                                                       gotoxy(45,10);
                                                       textcolor(green);
                                                       writeln('Listo!');
                                                       readkey;
                                                  end
                                                     else
                                                         if (control=#27) then
                                                            clrscr
                                                               else
                                                                   begin
                                                                        gotoxy(45,11);
                                                                        writeln('                                                 ');
                                                                        gotoxy(45,10);
                                                                        writeln('                                                 ');
                                                                        gotoxy(45,12);
                                                                        writeln('                                                 ');
                                                                        gotoxy(45,10);
                                                                        textcolor(red);
                                                                        writeln('La tecla ingresada es erronea...');
                                                                        textcolor(white);
                                                                        readkey;
                                                                   end;
                                         until (control = '1') or (control = #27);
                                     end;
                             end;
              end;

              procedure eliminar_archivo_artista(var arch:t_artistas);
              begin
                   erase(arch);
              end;
begin

end.
