unit archivos_obras;

interface
         uses crt, archivos_artistas, archivos_museos;

         type
             st2=string[2];
             st20=string[20];
             st30=string[30];
             st100=string[100];

             r_obras=record
                     nombre_obr:st20;
                     codigo_obr:integer;
                     dni_artista:integer;
                     anio:integer;
                     descr:st100;
                     material:st20;
                     estilo:st20;
                     tipo:st20;
                     altura:real;
                     peso:real;
                     completo:st2;
                     can_partes:integer;
                     codigo_museo:integer;
                     estado_obra:boolean;
                     end;
         t_obras = file of r_obras;

         procedure abrir_archivo_obra(var arch:t_obras; nom_arch:string);
         procedure leer_obra(var arch:t_obras; nom_arch:string; var pos:integer; var dato_leido:r_obras);
         procedure guardar_obra(var arch:t_obras ; nom_arch:string ; var escribir_dato:r_obras);
         procedure modificar_obra(var arch:t_obras; var arch_a:t_artistas ; var arch_m:t_museos ;nom_arch:string; nom_arch_a:string; nom_arch_m:string ;pos:integer);
         procedure busqueda_nombre_obra(var arch:t_obras; nom_arch:string; buscado:st20; var pos:integer);
         procedure busqueda_tipo_obra(var arch:t_obras; nom_arch:string; buscado:st20; var pos:integer);
         procedure busqueda_codigo_obra(var arch:t_obras; nom_arch:string; buscado:integer; var pos:integer);
         procedure alta_obra(var arch:t_obras; var arch_a:t_artistas; var arch_m:t_museos; nom_arch_m:string; nom_arch_a:string; nom_arch:string; var reg:r_obras);
         procedure baja_obra(var arch:t_obras; nom_arch:string; var pos:integer);
         procedure alta_estado_obra(var arch:t_obras; nom_arch:string; var pos:integer);
         procedure busqueda_consulta_museo(var arch:t_obras; nom_arch:string; buscado:integer; var pos:integer);
         procedure busqueda_consulta_artista(var arch:t_obras; nom_arch:string; buscado:integer; var pos:integer);
         procedure estadistica_museo(var arch:t_obras; nom_arch:string; buscado:integer; var pos:integer);
         procedure eliminar_archivo_obra(var arch:t_obras);

implementation
              procedure abrir_archivo_obra(var arch:t_obras;  nom_arch:string); //Abre archivo de tipo texto en modo escritura que borra el contenido y escribe
              begin
                   assign(arch, nom_arch);
                   {$I-}                           //{$I-} directiva para deshabilitar mensajes de error de el sistema operativo.
                        reset(arch);
                   {$I-}
                   if ioresult<>0 then
                      rewrite(arch); //Si la directiva {$I-} devuelve un valor distinto de cero quiere decir que no existe el fichero o hay un problema.                   close(arch);
                   //close(arch);
              end;
              procedure leer_obra(var arch:t_obras; nom_arch:string; var pos:integer; var dato_leido:r_obras); //Lee archivo de tipo texto
              begin
                   abrir_archivo_obra(arch, nom_arch);
                   seek(arch, pos);                  //seek posiciona el puntero en la posicion que indica el segundo parametro
                   read(arch, dato_leido);        //recorre el archivo y lee secuencialmente
                   close(arch);
              end;

              procedure guardar_obra(var arch:t_obras ; nom_arch:string ; var escribir_dato:r_obras); //Escribe en archivo de tipo texto
              var
                 reg_control:r_obras;
                 pos:integer;
              begin
                   pos:=0;
                   leer_obra(arch,nom_arch, pos, reg_control);
                   abrir_archivo_obra(arch, nom_arch);
                   seek(arch, filesize(arch));
                   if filepos(arch)=1 then
                      begin
                           if reg_control.codigo_obr=0 then         //
                              begin                                 // Debido a la inicializacion la posicion 0 ya esta ocupada
                                   seek(arch, 0);                   // Cuando filepos(Que indica la posicion el puntero en el archivo) sea 1
                                   write(arch, escribir_dato);      // los datos que hay que guardar hay que guardarlas en la posicion 0
                              end                                   //
                                 else
                                     begin
                                          seek(arch, filesize(arch));
                                          write(arch, escribir_dato);
                                     end;
                      end
                         else
                             begin
                                   seek(arch, filesize(arch));
                                   write(arch, escribir_dato);         //Escribe en el archivo lo que hay en escribir dato
                             end;         //Escribe en el archivo lo que hay en escribir dato
                   close(arch);
              end;

              procedure modificar_obra(var arch:t_obras; var arch_a:t_artistas ; var arch_m:t_museos ;nom_arch:string; nom_arch_a:string; nom_arch_m:string ;pos:integer);
              var
                 reg:r_obras;
                 control:char;
                 validacion,x,y,i:integer;
                 posi:integer;
                 reg_a:r_artistas;
                 reg_m:r_museos;
              begin
                   clrscr;
                   leer_obra(arch, nom_arch, pos, reg);
                   if reg.estado_obra then
                   begin
                   clrscr;
                 textcolor (blue);
                 x:=20;
                 y:=2;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=60;
                 y:=2;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=21;
                 y:=15;
                 For i:=1 to 41 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=102;
                 y:=2;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=21;
                 y:=1;
                 For i:=1 to 41 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                   textcolor (white);
                   gotoxy(21,3);
                   writeln('Nombre de la obra: ', reg.nombre_obr);
                   gotoxy(21,4);
                   writeln('DNI del artista: ', reg.dni_artista);
                   gotoxy(21,5);
                   writeln('Estilo: ', reg.estilo);
                   gotoxy(21,6);
                   writeln('Material: ', reg.material);
                   gotoxy(21,7);
                   writeln('Descripcion: ', reg.descr);
                   gotoxy(21,8);
                   writeln('Tipo: ', reg.tipo);
                   if (reg.tipo = 'Estatua') then
                      begin
                           gotoxy(21,11);
                           writeln('Altura: ', reg.altura:2:2);
                           gotoxy(21,12);
                           writeln('Peso: ', reg.peso:2:2);
                      end
                         else
                             begin
                                  if (reg.tipo = 'Fosil') then
                                     begin
                                          gotoxy(21,11);
                                          writeln('Completo: ',reg.completo);
                                          gotoxy(21,12);
                                          writeln('Cantidad de partes: ', reg.can_partes);
                                     end;
                             end;
                   gotoxy(21,9);
                   writeln('Año: ', reg.anio);
                   gotoxy(21,10);
                   writeln('Codigo del museo: ', reg.codigo_museo);
                   gotoxy(61,2);
                   writeln(#168,'Que desea modificar?');
                   gotoxy(61,3);
                   writeln('1: Nombre de la obra: ');
                   gotoxy(61,4);
                   writeln('2: DNI del artista: ');
                   gotoxy(61,5);
                   writeln('3: Estilo: ');
                   gotoxy(61,6);
                   writeln('4: Material: ');
                   gotoxy(61,7);
                   writeln('5: Descripcion: ');
                   gotoxy(61,8);
                   writeln('6: Tipo: ');
                   if (reg.tipo = 'Estatua') then
                      begin
                           gotoxy(61,11);
                           writeln('                            ');
                           gotoxy(61,11);
                           writeln('a: Altura: ');
                           gotoxy(61,12);
                           writeln('                            ');
                           gotoxy(61,12);
                           writeln('b Peso: ');
                      end
                         else
                             begin
                                  if (reg.tipo = 'Fosil') then
                                     begin
                                          gotoxy(61,11);
                                          writeln('c: Completo: ');
                                          gotoxy(61,12);
                                          writeln('d: Cantidad de partes: ');
                                     end
                                        else
                                            begin
                                                 gotoxy(61,11);
                                                 writeln('                            ');
                                                 gotoxy(61,11);
                                                 writeln('                            ');
                                            end;
                             end;

                   gotoxy(61,9);
                   writeln('7: Año: ');
                   gotoxy(61,10);
                   writeln('8: Codigo del museo: ');
                   gotoxy(61,13);
                   writeln('ESC: Salir');
                   repeat
                         gotoxy(21,16);
                         writeln('                                                                                   ');
                         gotoxy(21,13);
                         control:=readkey;
                         keypressed;
                         case control of
                         '1':begin
                                  gotoxy(83,3);
                                  writeln('                   ');
                                  gotoxy(83,3);
                                  readln(reg.nombre_obr);
                                  gotoxy(40,3);
                                  writeln('                ');
                                  gotoxy(40,3);
                                  writeln(reg.nombre_obr);
                                  abrir_archivo_obra(arch, nom_arch);
                                  seek(arch, pos);
                                  write(arch, reg);
                                  close(arch);
                             end;
                         '2':begin
                                  gotoxy(81,4);
                                  writeln('                    ');
                                  gotoxy(81,4);
                                  {$I-}
                                       readln(reg.dni_artista);
                                  {$I+}
                                  validacion:=ioresult();
                                  if validacion=0 then
                                     begin
                                          busqueda_dni_artista(arch_a, nom_arch_a, reg.dni_artista, posi);
                                          if posi>-1 then
                                             begin
                                                  leer_artista(arch_a, nom_arch_a, posi, reg_a);
                                                  if reg_a.estado_artista then
                                                     begin
                                                          gotoxy(38,4);
                                                          writeln('                     ');
                                                          gotoxy(38,4);
                                                          writeln(reg.dni_artista);
                                                          abrir_archivo_obra(arch, nom_arch);
                                                          seek(arch, pos);
                                                          write(arch, reg);
                                                          close(arch);
                                                     end
                                                        else
                                                            begin
                                                                 gotoxy(21,16);
                                                                 writeln('                                                                   ');
                                                                 gotoxy(21,16);
                                                                 Textcolor(red);
                                                                 writeln('El artista esta dado de baja. Debe darlo de alta primero');
                                                                 Textcolor(white);
                                                                 readkey;
                                                            end;
                                             end
                                                else
                                                    begin
                                                         gotoxy(21,16);
                                                         writeln('                                                                   ');
                                                         textcolor(red);
                                                         gotoxy(21,16);
                                                         writeln('El artista no esta registrado. Debe registrar el artista primero');
                                                         textcolor(white);
                                                         readkey;
                                                    end;
                                     end
                                        else
                                            begin
                                                 gotoxy(21,16);
                                                 writeln('                                                                   ');
                                                 textcolor(red);
                                                 gotoxy(21,16);
                                                 writeln('Debe ingresar solo numeros. Presione enter para intentar de nuevo');
                                                 textcolor(white);
                                                 readkey;
                                            end;
                             end;
                         '3':begin
                                  gotoxy(72,5);
                                  writeln('                         ');
                                  gotoxy(72,5);
                                  readln(reg.estilo);
                                  gotoxy(29,5);
                                  writeln('                       ');
                                  gotoxy(29,5);
                                  writeln(reg.estilo);
                                  abrir_archivo_obra(arch, nom_arch);
                                  seek(arch, pos);
                                  write(arch, reg);
                                  close(arch);
                             end;
                         '4':begin
                                  gotoxy(74,6);
                                  writeln('                         ');
                                  gotoxy(74,6);
                                  readln(reg.material);
                                  gotoxy(31,6);
                                  writeln('                       ');
                                  gotoxy(31,6);
                                  writeln(reg.material);
                                  abrir_archivo_obra(arch, nom_arch);
                                  seek(arch, pos);
                                  write(arch, reg);
                                  close(arch);
                             end;
                         '5':begin
                                  gotoxy(77,7);
                                  writeln('                         ');
                                  gotoxy(77,7);
                                  readln(reg.descr);
                                  gotoxy(34,7);
                                  writeln('                       ');
                                  gotoxy(34,7);
                                  writeln(reg.descr);
                                  abrir_archivo_obra(arch, nom_arch);
                                  seek(arch, pos);
                                  write(arch, reg);
                                  close(arch);
                             end;
                         '6':begin
                                  gotoxy(72,8);
                                  writeln('                         ');
                                  textcolor(yellow);
                                  gotoxy(21,16);
                                  writeln('Presione p:Pintura ; e:Estatua; f:Fosil');
                                  textcolor(white);
                                  gotoxy(70,8);
                                  writeln('                       ');
                                  gotoxy(70,8);
                                  reg.tipo:=readkey;
                                  keypressed;
                                  if (reg.tipo='p') or (reg.tipo='e') or (reg.tipo='f') then
                                     begin
                                          if reg.tipo='p' then
                                             begin
                                                  reg.tipo:='Pintura';
                                                  gotoxy(70,8);
                                                  writeln(reg.tipo);
                                                  gotoxy(21,11);
                                                  writeln('                       ');
                                                  gotoxy(21,12);
                                                  writeln('                       ');
                                                  gotoxy(61,11);
                                                  writeln('                      ');
                                                  gotoxy(61,12);
                                                  writeln('                      ');
                                                  abrir_archivo_obra(arch, nom_arch);
                                                  seek(arch, pos);
                                                  write(arch, reg);
                                                  close(arch);
                                             end
                                             else
                                                 if reg.tipo='f' then
                                                    begin
                                                         reg.tipo:='Fosil';
                                                         gotoxy(70,8);
                                                         writeln(reg.tipo);
                                                         reg.completo:='No';
                                                         reg.can_partes:=0;
                                                         gotoxy(21,11);
                                                         writeln('                                      ');
                                                         gotoxy(21,11);
                                                         writeln('Completo: ', reg.completo);
                                                         gotoxy(21,12);
                                                         writeln('Cantidad de partes: ', reg.can_partes);
                                                         gotoxy(61,11);
                                                         writeln('                                      ');
                                                         gotoxy(61,11);
                                                         writeln('c: Completo: ');
                                                         gotoxy(61,12);
                                                         writeln('d: Cantidad de partes: ');
                                                         abrir_archivo_obra(arch, nom_arch);
                                                         seek(arch, pos);
                                                         write(arch, reg);
                                                         close(arch);
                                                    end
                                                    else
                                                        begin
                                                             reg.tipo:='Estatua';
                                                             gotoxy(70,8);
                                                             writeln(reg.tipo);
                                                             reg.altura:=0;
                                                             reg.peso:=0;
                                                             gotoxy(21,1);
                                                             writeln('                    ');
                                                             gotoxy(21,11);
                                                             writeln('Altura: ', reg.altura:2:2);
                                                             gotoxy(21,12);
                                                             writeln('                        ');
                                                             gotoxy(21,12);
                                                             writeln('Peso: ', reg.peso:2:2);
                                                             gotoxy(61,11);
                                                             writeln('                            ');
                                                             gotoxy(61,11);
                                                             writeln('a: Altura: ');
                                                             gotoxy(61,12);
                                                             writeln('                            ');
                                                             gotoxy(61,12);
                                                             writeln('b Peso: ');
                                                             abrir_archivo_obra(arch, nom_arch);
                                                             seek(arch, pos);
                                                             write(arch, reg);
                                                             close(arch);
                                                        end;
                                          gotoxy(27,8);
                                          writeln('                       ');
                                          gotoxy(27,8);
                                          writeln(reg.tipo);
                                       end
                                          else
                                              begin
                                                   gotoxy(21,16);
                                                   writeln('                                      ');
                                                   gotoxy(21,16);
                                                   textcolor(red);
                                                   writeln('Letra erronea');
                                                   textcolor(white);
                                                   readkey;
                                              end;

                             end;
                         '7':begin
                                  gotoxy(69,9);
                                  writeln('                         ');
                                  gotoxy(69,9);
                                  {$I-}
                                       readln(reg.anio);
                                  {$I+}
                                  validacion:=ioresult();
                                  if validacion=0 then
                                     begin
                                          gotoxy(26,9);
                                          writeln('                     ');
                                          gotoxy(26,9);
                                          writeln(reg.anio);
                                          abrir_archivo_obra(arch, nom_arch);
                                          seek(arch, pos);
                                          write(arch, reg);
                                          close(arch);
                                     end
                                        else
                                            begin
                                                 gotoxy(21,16);
                                                 writeln('                                      ');
                                                 gotoxy(21,16);
                                                 Textcolor(red);
                                                 writeln('Debe ingresar solo numeros. Presione enter para intentar de nuevo');
                                                 Textcolor(white);
                                                 readkey;
                                            end;
                             end;
                         '8':begin
                                  gotoxy(82,10);
                                  writeln('                    ');
                                  gotoxy(82,10);
                                  {$I-}
                                       readln(reg.codigo_museo);
                                  {$I+}
                                  validacion:=ioresult();
                                  if validacion=0 then
                                     begin
                                          busqueda_codigo_museo(arch_m, nom_arch_m, reg.codigo_museo, posi);
                                          if posi>-1 then
                                             begin
                                                  leer_museo(arch_m, nom_arch_m, posi, reg_m);
                                                  if reg_a.estado_artista then
                                                     begin
                                                          gotoxy(41,10);
                                                          writeln('                     ');
                                                          gotoxy(41,10);
                                                          writeln(reg.codigo_museo);
                                                          abrir_archivo_obra(arch, nom_arch);
                                                          seek(arch, pos);
                                                          write(arch, reg);
                                                          close(arch);
                                                     end
                                                        else
                                                            begin
                                                                 gotoxy(21,16);
                                                                 writeln('                                                                   ');
                                                                 gotoxy(21,16);
                                                                 Textcolor(red);
                                                                 writeln('El museo esta dado de baja. Debe darlo de alta primero');
                                                                 Textcolor(white);
                                                                 readkey;
                                                            end;
                                             end
                                                else
                                                    begin
                                                         gotoxy(21,16);
                                                         writeln('                                                                   ');
                                                         gotoxy(21,16);
                                                         Textcolor(red);
                                                         writeln('El museo no esta registrado. Debe registrar el museo primero');
                                                         Textcolor(white);
                                                         readkey;
                                                    end;
                                     end
                                        else
                                            begin
                                                 gotoxy(21,16);
                                                 writeln('                                                                   ');
                                                 gotoxy(21,16);
                                                 Textcolor(red);
                                                 writeln('Debe ingresar solo numeros. Presione enter para intentar de nuevo');
                                                 Textcolor(white);
                                                 readkey;
                                            end;
                             end;
                         'a':begin
                                  gotoxy(72,11);
                                  writeln('                         ');
                                  gotoxy(72,11);
                                  {$I-}
                                       readln(reg.altura);
                                  {$I+}
                                  validacion:=ioresult();
                                  if validacion=0 then
                                     begin
                                          gotoxy(29,11);
                                          writeln('                 ');
                                          gotoxy(29,11);
                                          writeln(reg.altura:2:2);
                                          abrir_archivo_obra(arch, nom_arch);
                                          seek(arch, pos);
                                          write(arch, reg);
                                          close(arch);
                                     end
                                        else
                                            begin
                                                 gotoxy(21,16);
                                                 writeln('                                      ');
                                                 gotoxy(21,16);
                                                 Textcolor(red);
                                                 writeln('Debe ingresar solo numeros. Presione enter para intentar de nuevo');
                                                 Textcolor(white);
                                                 readkey;
                                            end;
                             end;
                         'b':begin
                                  gotoxy(69,12);
                                  writeln('                         ');
                                  gotoxy(69,12);
                                  {$I-}
                                       readln(reg.peso);
                                  {$I+}
                                  validacion:=ioresult();
                                  if validacion=0 then
                                     begin
                                          gotoxy(27,12);
                                          writeln('                 ');
                                          gotoxy(27,12);
                                          writeln(reg.peso:2:2);
                                          abrir_archivo_obra(arch, nom_arch);
                                          seek(arch, pos);
                                          write(arch, reg);
                                          close(arch);
                                     end
                                        else
                                            begin
                                                 gotoxy(21,16);
                                                 writeln('                                      ');
                                                 gotoxy(21,16);
                                                 Textcolor(red);
                                                 writeln('Debe ingresar solo numeros. Presione enter para intentar de nuevo');                                                 writeln('Debe ingresar solo numeros. Presione enter para intentar de nuevo');
                                                 Textcolor(white);
                                                 readkey;
                                            end;
                              end;
                         'c':begin
                                  textcolor(yellow);
                                  gotoxy(21,16);
                                  writeln('Presione s:Si ; n: No');
                                  textcolor(white);
                                  gotoxy(74,11);
                                  writeln('                       ');
                                  gotoxy(74,11);
                                  reg.completo:=readkey;
                                  keypressed;
                                  if reg.completo='s' then
                                     begin
                                          reg.completo:='Si';
                                          gotoxy(74,11);
                                          writeln(reg.completo);
                                          gotoxy(31,11);
                                          writeln('         ');
                                          gotoxy(31,11);
                                          writeln(reg.completo);
                                          abrir_archivo_obra(arch, nom_arch);
                                          seek(arch, pos);
                                          write(arch, reg);
                                          close(arch);
                                     end
                                        else
                                            begin
                                                 if reg.completo='n' then
                                                    begin
                                                         reg.completo:='No';
                                                         gotoxy(74,11);
                                                         writeln(reg.completo);
                                                         gotoxy(31,11);
                                                         writeln('         ');
                                                         gotoxy(31,11);
                                                         writeln(reg.completo);
                                                         abrir_archivo_obra(arch, nom_arch);
                                                         seek(arch, pos);
                                                         write(arch, reg);
                                                         close(arch);
                                                    end
                                                       else
                                                           begin
                                                                gotoxy(21,16);
                                                                writeln('                                      ');
                                                                gotoxy(21,16);
                                                                Textcolor(red);
                                                                writeln('Letra erronea');
                                                                Textcolor(white);
                                                                readkey;
                                                           end;
                                            end;
                             end;
                         'd':begin
                                  gotoxy(84,12);
                                  writeln('              ');
                                  gotoxy(84,12);
                                  {$I-}
                                       readln(reg.can_partes);
                                  {$I+}
                                  validacion:=ioresult();
                                  if validacion = 0 then
                                     begin
                                          gotoxy(41,12);
                                          writeln('          ');
                                          gotoxy(41,12);
                                          writeln(reg.can_partes);
                                          abrir_archivo_obra(arch, nom_arch);
                                          seek(arch, pos);
                                          write(arch, reg);
                                          close(arch);
                                     end
                                        else
                                            begin
                                                 gotoxy(21,16);
                                                 writeln('                                      ');
                                                 gotoxy(21,16);
                                                 Textcolor(red);
                                                 writeln('Debe ingresar solo numeros. Presione enter para intentar de nuevo');
                                                 Textcolor(white);
                                                 readkey;
                                            end;
                             end;
                         end;
                   until control=#27;
                   end
                      else
                          begin
                               textcolor(red);
                               writeln('La obra esta dada de baja');
                               textcolor(white);
                               readkey;
                          end;
              end;

              procedure busqueda_nombre_obra(var arch:t_obras; nom_arch:string; buscado:st20; var pos:integer);
              var
                 reg_aux:r_obras;
                 i:integer;
              begin
                   i:=0;
                   pos := -1;
                   abrir_archivo_obra(arch, nom_arch);
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.nombre_obr = buscado then
                           begin
                                pos:=i;
                           end;
                        i:=i+1;
                        seek(arch, i);
                   end;
                   close(arch);
              end;

              procedure busqueda_tipo_obra(var arch:t_obras; nom_arch:string; buscado:st20; var pos:integer);
              var
                 reg_aux:r_obras;
                 i:integer;
              begin
                   i:=0;
                   pos := -1;
                   abrir_archivo_obra(arch, nom_arch);
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.tipo = buscado then
                           begin
                                pos:=i;
                           end;
                        i:=i+1;
                        seek(arch, i);
                   end;
                   close(arch);
              end;

              procedure busqueda_consulta_artista(var arch:t_obras; nom_arch:string; buscado:integer; var pos:integer);
              var
                 reg_aux:r_obras;
                 i,y,z,x:integer;
              begin
                   y:=4;
                   i:=0;
                   pos := -1;
                   gotoxy (61,4);
                   writeln('Obras: ');
                   abrir_archivo_obra(arch, nom_arch);
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.dni_artista = buscado then
                           begin
                                pos:=1;
                                if reg_aux.estado_obra then
                                   begin
                                        gotoxy (69,y);
                                        writeln('* ', reg_aux.nombre_obr);
                                        y:=y+1;
                                   end;
                           end;
                        i:=i+1;
                        seek(arch, i);
                   end;
                   textcolor (blue);
                   x:=51;
                   z:=2;
                   For i:=1 to y+2 do
                       Begin
                            Gotoxy (x,z);
                            Writeln('|');
                            inc (z);
                       End;
                   x:=52;
                   z:=y+3;
                   For i:=1 to 23 do
                       Begin
                            Gotoxy (x,z);
                            Writeln ('_');
                            x:=x+2
                       End;
                   x:=97;
                   z:=2;
                   For i:=1 to y+2 do
                       Begin
                            Gotoxy (x,z);
                            Writeln('|');
                            inc (z);
                       End;
                   x:=52;
                   z:=1;
                   For i:=1 to 23 do
                       Begin
                            Gotoxy (x,z);
                            Writeln ('_');
                            x:=x+2
                       End;
                   textcolor (white);
                   close(arch);
                   textcolor(yellow);
                   gotoxy(51, y+4);
                   writeln('Presione enter para salir.');
                   textcolor(white);
              end;

              procedure busqueda_codigo_obra(var arch:t_obras; nom_arch:string; buscado:integer; var pos:integer);
              var
                 reg_aux:r_obras;
                 i:integer;
              begin
                   i:=0;
                   pos := -1;
                   abrir_archivo_obra(arch, nom_arch);
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.codigo_obr = buscado then
                           begin
                                pos:=i;
                           end;
                        i:=i+1;
                        seek(arch, i);
                   end;
                   close(arch);
              end;

              procedure busqueda_consulta_museo(var arch:t_obras; nom_arch:string; buscado:integer; var pos:integer);
              var
                 reg_aux:r_obras;
                 i,y,x,z:integer;
              begin
                   y:=6;
                   i:=0;
                   pos := -1;
                   abrir_archivo_obra(arch, nom_arch);
                   gotoxy (61,6);
                   writeln('Obras: ');
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.codigo_museo = buscado then
                           begin
                                if reg_aux.estado_obra then
                                begin
                                     gotoxy (68,y);
                                     writeln('*', reg_aux.nombre_obr);
                                     pos:=1;
                                     y:=y+1;
                                end;
                           end;
                   i:=i+1;
                   seek(arch, i);
                   end;
                   textcolor (blue);
                   x:=51;
                   z:=2;
                   For i:=1 to y+2 do
                       Begin
                            Gotoxy (x,z);
                            Writeln('|');
                            inc (z);
                       End;
                   x:=52;
                   z:=y+3;
                   For i:=1 to 23 do
                       Begin
                            Gotoxy (x,z);
                            Writeln ('_');
                            x:=x+2
                       End;
                   x:=97;
                   z:=2;
                   For i:=1 to y+2 do
                       Begin
                            Gotoxy (x,z);
                            Writeln('|');
                            inc (z);
                       End;
                   x:=52;
                   z:=1;
                   For i:=1 to 23 do
                       Begin
                            Gotoxy (x,z);
                            Writeln ('_');
                            x:=x+2
                       End;
                   textcolor (white);
                   close(arch);
                   gotoxy(51,y+4);
                   textcolor(yellow);
                   writeln('Presione enter para salir.');
                   textcolor(white);
                   readkey;
              end;

              procedure estadistica_museo(var arch:t_obras; nom_arch:string; buscado:integer; var pos:integer);
              var
                 reg_aux:r_obras;
                 i:integer;
                 x,y,co:integer;
                 cp:integer;
                 ce:integer;
                 cf:integer;
                 pp:real;
                 pe:real;
                 pf:real;
              begin
                   i:=0;
                   cp:=0;
                   ce:=0;
                   cf:=0;
                   co:=0;
                   pos := -1;
                   abrir_archivo_obra(arch, nom_arch);
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.codigo_museo = buscado then
                           begin
                                if reg_aux.estado_obra then
                                begin
                                     pos:=1;
                                     co:=co+1;
                                     if (reg_aux.tipo='Pintura') then
                                        cp:=cp+1
                                        else
                                        if (reg_aux.tipo='Estatua') then
                                           ce:=ce+1
                                           else
                                               cf:=cf+1;
                            end;
                           end;
                        i:=i+1;
                        seek(arch, i);
                   end;
                   if pos=1 then
                      begin
                           textcolor (blue);
                           x:=49;
                           y:=2;
                           For i:=1 to 8 do
                               Begin
                                    Gotoxy (x,y);
                                    Writeln('|');
                                    inc (y);
                               End;
                           x:=50;
                           y:=9;
                           For i:=1 to 20 do
                               Begin
                                    Gotoxy (x,y);
                                    Writeln ('_');
                                    x:=x+2
                               End;
                           x:=89;
                           y:=2;
                           For i:=1 to 8 do
                               Begin
                                    Gotoxy (x,y);
                                    Writeln('|');
                                    inc (y);
                               End;
                               x:=50;
                               y:=1;
                           For i:=1 to 20 do
                           Begin
                                Gotoxy (x,y);
                                Writeln ('_');
                                x:=x+2
                           End;
                           textcolor (white);
                           pp:=(100*cp)div co;
                           pe:=(100*ce)div co;
                           pf:=(100*cf)div co;
                           gotoxy(52,5);
                           writeln('Obras:');
                           gotoxy(61,4);
                           writeln(pp :2:0,'% son pinturas');
                           gotoxy(61,5);
                           writeln(pe :2:0,'% son estatuas');
                           gotoxy(61,6);
                           writeln(pf :2:0,'% son fosiles');
                      end
                         else
                             writeln('Este museo no tiene registrada ninguna obra ');
                   close(arch);
              end;

              procedure baja_obra(var arch:t_obras; nom_arch:string; var pos:integer);
              var
                 reg:r_obras;
              begin
                   leer_obra(arch, nom_arch, pos, reg);
                   reg.estado_obra:=false;
                   abrir_archivo_obra(arch, nom_arch);
                   seek(arch, pos);
                   write(arch, reg);
                   close(arch);
              end;

              procedure alta_estado_obra(var arch:t_obras; nom_arch:string; var pos:integer);
              var
                 reg:r_obras;
              begin
                   leer_obra(arch, nom_arch, pos, reg);
                   reg.estado_obra:=true;
                   abrir_archivo_obra(arch, nom_arch);
                   seek(arch, pos);
                   write(arch, reg);
                   close(arch);
              end;

              procedure alta_obra(var arch:t_obras; var arch_a:t_artistas; var arch_m:t_museos; nom_arch_m:string ;nom_arch_a:string; nom_arch:string; var reg:r_obras);
              var
                 posi,x,y,i:integer;
                 control:char;
                 asd:string;
                 validacion:integer;
                 reg_a:r_artistas;
                 reg_m:r_museos;
                 reg_aux_cod:r_obras;
                 ultima_posicion:integer;
              begin
                   abrir_archivo_obra(arch,nom_arch); //
                   if filesize(arch)=0 then           //
                      begin                           //
                           reg.codigo_obr:=0;        //  Inicializacion del archivo
                           write(arch, reg)          //
                      end;                           //
                   close(arch);                     //
                   clrscr;
                 textcolor (blue);
                 x:=44;
                 y:=2;
                 For i:=1 to 20 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=45;
                 y:=21;
                 For i:=1 to 29 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=102;
                 y:=2;
                 For i:=1 to 20 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=45;
                 y:=1;
                 For i:=1 to 29 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                   textcolor (white);
                   posi:=-1;
                   gotoxy(66,2);
                   writeln('Alta de Obra');
                   gotoxy(45,4);
                   writeln('Nombre: ');
                   gotoxy(45,5);
                   writeln('DNI del Artista: ');
                   gotoxy(45,6);
                   writeln('Codigo del museo: ');
                   gotoxy(45,7);
                   writeln('Estilo: ');
                   gotoxy(45,8);
                   writeln('Material: ');
                   gotoxy(45,9);
                   writeln('Descripcion: ');
                   gotoxy(45,10);
                   writeln('Año: ');
                   gotoxy(45,11);
                   writeln('Tipo: ');
                   gotoxy(45,15);
                   writeln('Codigo: ');
                   gotoxy(53,4);
                   readln(asd);
                   abrir_archivo_obra(arch, nom_arch); //
                   ultima_posicion:=filesize(arch)-1;  // lectura de la posicion del ultimo registro
                   close(arch);                        //
                   leer_obra(arch, nom_arch, ultima_posicion, reg_aux_cod); //
                   reg.codigo_obr:=reg_aux_cod.codigo_obr+1;                // generar codigo de obra automaticamente
                   gotoxy(53,15);
                   writeln(reg.codigo_obr);
                   busqueda_nombre_obra(arch, nom_arch, asd, posi);
                   if posi = -1 then
                      begin
                           reg.nombre_obr:=asd;
                           repeat
                                 gotoxy(62,5);
                                 writeln('                                      ');
                                 gotoxy(62,5);
                                 {$I-}
                                      readln(reg.dni_artista);
                                 {$I+}
                                 validacion:=ioresult();
                                 if validacion<>0 then
                                    begin
                                         gotoxy(45,16);
                                         Textcolor (red);
                                         writeln('Debe ingresar solo numeros');
                                         Textcolor (white);
                                    end;
                           until validacion=0;
                           gotoxy(45,16);
                           writeln('                                           ');
                           busqueda_dni_artista(arch_a, nom_arch_a, reg.dni_artista, posi);
                           if posi>-1 then
                              begin
                              leer_artista(arch_a, nom_arch_a, posi, reg_a);
                              if reg_a.estado_artista then
                                 begin
                                      repeat
                                            gotoxy(63,6);
                                            writeln('                                     ');
                                            gotoxy(63,6);
                                            {$I-}
                                                 readln(reg.codigo_museo);
                                            {$I-}
                                            validacion:=ioresult();
                                            if validacion<>0 then
                                               begin
                                                    gotoxy(45,16);
                                                    Textcolor (red);
                                                    writeln('Debe ingresar solo numeros');
                                                    Textcolor (white);
                                               end;
                                      until validacion = 0;
                                      gotoxy(45,16);
                                      writeln('                                           ');
                                      busqueda_codigo_museo(arch_m, nom_arch_m, reg.codigo_museo, posi);
                                      if posi>-1 then
                                         begin
                                              leer_museo(arch_m, nom_arch_m, posi, reg_m);
                                              if reg_m.estado_museo then
                                              begin
                                                   gotoxy(53,7);
                                                   readln(reg.estilo);
                                                   gotoxy(55,8);
                                                   readln(reg.material);
                                                   gotoxy(58,9);
                                                   readln(reg.descr);
                                                   repeat
                                                         gotoxy(50,10);
                                                         writeln('                                     ');
                                                         gotoxy(50,10);
                                                         {$I-}
                                                              readln(reg.anio);
                                                         {$I+}
                                                         validacion:=ioresult();
                                                         if validacion<>0 then
                                                            begin
                                                                 gotoxy(45,16);
                                                                 Textcolor (red);
                                                                 writeln('Debe ingresar solo numeros...');
                                                                 Textcolor (white);
                                                            end;
                                                   until validacion=0;
                                                   gotoxy(45,16);
                                                   writeln('                                                         ');
                                                   repeat
                                                         gotoxy(45,16);
                                                         writeln('Pulse "p" para pintura; "e" para estatua; "f" para fosil.');
                                                         gotoxy(51,11);
                                                         writeln('                             ');
                                                         gotoxy(51,11);
                                                         control:=readkey;
                                                         keypressed;
                                                         case control of
                                                              'p':begin
                                                                       reg.tipo:='Pintura';
                                                                       gotoxy(51,11);
                                                                       writeln(reg.tipo);
                                                                  end;
                                                              'e':begin
                                                                       reg.tipo:='Estatua';
                                                                       gotoxy(51,11);
                                                                       writeln(reg.tipo);
                                                                  end;
                                                              'f':begin
                                                                       reg.tipo:='Fosil';
                                                                       gotoxy(51,11);
                                                                       writeln(reg.tipo);
                                                                  end;
                                                              else
                                                                  begin
                                                                       gotoxy(45,16);
                                                                       Textcolor (red);
                                                                       writeln('La letra ingresada es erronea:...');
                                                                       Textcolor (white);
                                                                  end;
                                                         end;
                                                   until (reg.tipo = 'Pintura') or (reg.tipo = 'Estatua') or (reg.tipo = 'Fosil');
                                                   gotoxy(45,16);
                                                   writeln('                                                         ');
                                                   if reg.tipo='Estatua' then
                                                      begin
                                                           gotoxy(45,12);
                                                           writeln('Altura: ');
                                                           gotoxy(45,13);
                                                           writeln('Peso: ');
                                                           repeat
                                                                 gotoxy(53,12);
                                                                 writeln('                    ');
                                                                 gotoxy(53,12);
                                                                 {$I-}
                                                                      readln(reg.altura);
                                                                 {$I+}
                                                                 validacion:=ioresult();
                                                                 if validacion<>0 then
                                                                    begin
                                                                         gotoxy(45,16);
                                                                         Textcolor (red);
                                                                         writeln('Debe ingresar solo numeros.');
                                                                         Textcolor (white);
                                                                    end;
                                                           until validacion=0;
                                                           gotoxy(45,16);
                                                           writeln('                               ');
                                                           repeat
                                                                 gotoxy(51,13);
                                                                 writeln('                                 ');
                                                                 gotoxy(51,13);
                                                                 {$I-}
                                                                      readln(reg.peso);
                                                                 {$I+}
                                                                 validacion:=ioresult();
                                                                 if validacion<>0 then
                                                                    begin
                                                                         gotoxy(45,16);
                                                                         Textcolor (red);
                                                                         writeln('Debe ingresar solo numeros.');
                                                                         Textcolor (white);
                                                                    end;
                                                           until validacion=0;
                                                           gotoxy(45,16);
                                                           writeln('                                                         ');
                                                      end
                                                         else
                                                             if reg.tipo='Fosil' then
                                                                begin
                                                                     gotoxy(45,12);
                                                                     writeln(#168'El fosil esta completo?: ');
                                                                     gotoxy(45,13);
                                                                     writeln('Cantidad de partes: ');
                                                                     repeat
                                                                           gotoxy(45,16);
                                                                           writeln('Pulse "s": si esta completo ; "n": si no esta completo.');
                                                                           gotoxy(71,12);
                                                                           writeln('            ');
                                                                           gotoxy(71,12);
                                                                           control:=readkey;
                                                                           keypressed;
                                                                           case control of
                                                                                's':begin
                                                                                         reg.completo:='Si';
                                                                                         gotoxy(71,12);
                                                                                         writeln(reg.completo);
                                                                                    end;
                                                                                'n':begin
                                                                                         reg.completo:='No';
                                                                                         gotoxy(71,12);
                                                                                         writeln(reg.completo);
                                                                                    end;
                                                                                else
                                                                                    begin
                                                                                         gotoxy(45,16);
                                                                                         Textcolor (red);
                                                                                         writeln('La letra ingresada es erronea: ');
                                                                                         Textcolor (white);
                                                                                    end;
                                                                           end;
                                                                     until (reg.completo = 'Si') or (reg.completo = 'No');
                                                                     gotoxy(45,16);
                                                                     writeln('                                                         ');
                                                                     repeat

                                                                           gotoxy(65,13);
                                                                           writeln('                        ');
                                                                           gotoxy(65,13);
                                                                           {$I-}
                                                                                readln(reg.can_partes);
                                                                           {$I+}
                                                                           validacion:=ioresult();
                                                                           if validacion<>0 then
                                                                              begin
                                                                                   gotoxy(45,16);
                                                                                   Textcolor (red);
                                                                                   writeln('Debe ingresar solo numeros.');
                                                                                   Textcolor (white);
                                                                              end;
                                                                     until validacion=0;
                                                                     gotoxy(45,16);
                                                                     writeln('                               ');
                                                                end;
                                                   reg.estado_obra:=true;
                                                   guardar_obra(arch, nom_arch, reg);
                                                   gotoxy(45,16);
                                                   Textcolor (green);
                                                   writeln('Listo!');
                                                   Textcolor (white);
                                                   readkey;
                                              end
                                                 else
                                                     begin
                                                          gotoxy(45,16);
                                                          Textcolor (red);
                                                          writeln('El museo esta dado de baja.');
                                                          Gotoxy (45,17);
                                                          Writeln('Dar de alta para continuar');
                                                          Textcolor (white);
                                                          readkey;
                                                     end;
                                         end
                                           else
                                               begin
                                                    gotoxy(45,16);
                                                    Textcolor (red);
                                                    writeln('El museo no esta registrado.');
                                                    gotoxy(45,17);
                                                    writeln('Registre primero el museo para continuar');
                                                    Textcolor (white);
                                                    readkey;
                                               end;
                                 end
                                    else
                                        begin
                                             gotoxy(45,16);
                                             Textcolor (red);
                                             writeln('El artista esta dado de baja.');
                                             Gotoxy (45,17);
                                             writeln ('Dar de alta para continuar');
                                             Textcolor (white);
                                             readkey;
                                        end;
                              end
                                 else
                                     begin
                                          gotoxy(45,16);
                                          Textcolor (red);
                                          writeln('El artista no esta registrado.');
                                          Gotoxy(46,17);
                                          Writeln ('Registre primero el artista para continuar');
                                          Textcolor (white);
                                          readkey;
                                     end;
                      end
                         else
                             begin
                                  leer_obra(arch, nom_arch, posi, reg);
                                  if (reg.estado_obra) then
                                     begin
                                          repeat
                                                gotoxy(45,16);
                                                writeln('Esta obra ya esta registrada.' ,#168,'Que desea hacer?');
                                                gotoxy(45,17);
                                                writeln('1: Modificar');
                                                gotoxy(45,18);
                                                writeln('2: Dar baja');
                                                gotoxy(45,19);
                                                writeln('ESC: Volver');
                                                control:=readkey;
                                                keypressed;
                                                if (control = '1') then
                                                   modificar_obra(arch, arch_a ,arch_m,nom_arch, nom_arch_a, nom_arch_m,posi)
                                                      else
                                                          if (control='2') then
                                                             begin
                                                                  gotoxy(45,16);
                                                                  writeln('                                                         ');
                                                                  gotoxy(45,17);
                                                                  writeln('                ');
                                                                  gotoxy(45,18);
                                                                  writeln('                     ');
                                                                  gotoxy(45,19);
                                                                  writeln('              ');
                                                                  baja_obra (arch,nom_arch, posi);
                                                                  gotoxy(45,16);
                                                                  writeln('Listo!');
                                                                  readkey;
                                                             end
                                                             else
                                                                 if (control=#27) then
                                                                    clrscr
                                                                       else
                                                                           begin
                                                                                gotoxy(45,16);
                                                                                writeln('                                                         ');
                                                                                gotoxy(45,17);
                                                                                writeln('                ');
                                                                                gotoxy(45,18);
                                                                                writeln('                     ');
                                                                                gotoxy(45,19);
                                                                                writeln('              ');
                                                                                gotoxy(45,16);
                                                                                Textcolor (red);
                                                                                writeln('La tecla ingresada es erronea...');
                                                                                Textcolor (white);
                                                                                readkey;
                                                                           end;
                                          until (control = '1') or (control='2') or (control = #27);
                                     end
                                        else
                                        begin
                                            repeat
                                                  gotoxy(45,16);
                                                  writeln('Esta obra esta registrada pero esta dada de baja.');
                                                  gotoxy(45,17);
                                                  writeln('1: Dar de alta');
                                                  gotoxy(45,18);
                                                  writeln('ESC: Volver');
                                                  control:=readkey;
                                                  keypressed;
                                                  if (control = '1') then
                                                     begin
                                                          gotoxy(45,16);
                                                          writeln('                                                         ');
                                                          gotoxy(45,17);
                                                          writeln('               ');
                                                          gotoxy(45,18);
                                                          writeln('            ');
                                                          alta_estado_obra(arch, nom_arch, posi);
                                                          gotoxy(45,16);
                                                          Textcolor (green);
                                                          writeln('Listo!');
                                                          Textcolor (white);
                                                          readkey;
                                                     end
                                                        else
                                                            if (control=#27) then
                                                               clrscr
                                                                  else
                                                                      begin
                                                                           gotoxy(45,16);
                                                                           writeln('                                                         ');
                                                                           gotoxy(45,17);
                                                                           writeln('               ');
                                                                           gotoxy(45,18);
                                                                           writeln('            ');
                                                                           gotoxy(45,16);
                                                                           Textcolor (red);
                                                                           writeln('La letra ingresada es erronea...');
                                                                           Textcolor (white);
                                                                           readkey;
                                                                      end;
                                            until (control = '1') or (control = #27);
                                        end;
                             end;
              end;

              procedure eliminar_archivo_obra(var arch:t_obras);
              begin
                   erase(arch);
              end;

begin

end.
