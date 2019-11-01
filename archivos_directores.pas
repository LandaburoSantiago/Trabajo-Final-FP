unit archivos_directores;

interface
         uses crt;

         type
             st10=string[10];
             st20=string[20];
             st30=string[30];
             st100=string[100];

             r_directores=record
                     nombre_director:st20;
                     direccion_director:st30;
                     dni_director:integer;
                     telefono_director:integer;
                     periodo_director:integer;
                     estado_director:boolean;
                     end;
         t_directores = file of r_directores;

         procedure abrir_archivo_director(var arch:t_directores; nom_arch:string);
         procedure leer_director(var arch:t_directores; nom_arch:string; var pos:integer; var dato_leido:r_directores);
         procedure guardar_director(var arch:t_directores ; nom_arch:string ; var escribir_dato:r_directores);
         procedure modificar_director(var arch:t_directores; nom_arch:string ;pos:integer);
         procedure busqueda_nombre_director(var arch:t_directores; nom_arch:string; buscado:st20; var pos:integer);
         procedure busqueda_dni_director(var arch:t_directores; nom_arch:string; buscado:integer; var pos:integer);
         procedure alta_director(var arch:t_directores; nom_arch:string; var reg:r_directores);
         procedure baja_director(var arch:t_directores; nom_arch:string; var pos:integer);
         procedure alta_estado_director(var arch:t_directores; nom_arch:string; var pos:integer);
         procedure eliminar_archivo_director(var arch:t_directores);

implementation
              procedure abrir_archivo_director(var arch:t_directores;  nom_arch:string); //Abre archivo de tipo texto en modo escritura que borra el contenido y escribe
              begin
                   assign(arch, nom_arch);
                   {$I-}                           //{$I-} directiva para deshabilitar mensajes de error de el sistema operativo.
                        reset(arch);
                   {$I-}
                   if ioresult<>0 then
                      rewrite(arch); //Si la directiva {$I-} devuelve un valor distinto de cero quiere decir que no existe el fichero o hay un problema.
                   //close(arch);
              end;
              procedure leer_director(var arch:t_directores; nom_arch:string; var pos:integer; var dato_leido:r_directores); //Lee archivo de tipo texto
              begin
                   abrir_archivo_director(arch, nom_arch);
                   seek(arch, pos);                  //seek posiciona el puntero en la posicion que indica el segundo parametro
                   read(arch, dato_leido);        //recorre el archivo y lee secuencialmente
                   close(arch);
              end;

              procedure guardar_director(var arch:t_directores; nom_arch:string ; var escribir_dato:r_directores); //Escribe en archivo de tipo texto
              begin
                   abrir_archivo_director(arch, nom_arch);
                   seek(arch, filesize(arch));
                   write(arch, escribir_dato);         //Escribe en el archivo lo que hay en escribir dato
                   close(arch);
              end;

              procedure modificar_director(var arch:t_directores; nom_arch:string ;pos:integer);
              var
                 x,y,i:integer;
                 reg:r_directores;
                 control:char;
                 validacion:integer;
              begin
                   clrscr;
                   leer_director(arch, nom_arch, pos, reg);
                   if reg.estado_director then
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
                   gotoxy(55,1);
                   writeln('Modificar Director');
                   gotoxy(21,4);
                   writeln('Nombre: ', reg.nombre_director);
                   gotoxy(21,5);
                   writeln('Direccion: ', reg.direccion_director);
                   gotoxy(21,6);
                   writeln('Telefono: ', reg.telefono_director);
                   gotoxy(21,7);
                   writeln('Periodo: ',reg.periodo_director);
                   gotoxy(61,3);
                   writeln(#168,'Que desea modificar?');
                   gotoxy(61,4);
                   writeln('1: Nombre: ');
                   gotoxy(61,5);
                   writeln('2: Direccion: ');
                   gotoxy(61,6);
                   writeln('3: Telefono: ');
                   gotoxy(61,7);
                   writeln('4: Periodo: ');
                   gotoxy(61,8);
                   writeln('ESC: Salir ');
                   repeat
                         gotoxy(21,9);
                         control:=readkey;
                         keypressed;
                         case control of
                              '1':begin
                                       gotoxy(72,4);
                                       writeln('                           ');
                                       gotoxy(72,4);
                                       readln(reg.nombre_director);
                                       gotoxy(29,4);
                                       writeln('              ');
                                       gotoxy(29,4);
                                       writeln(reg.nombre_director);
                                       reg.estado_director:=true;
                                       abrir_archivo_director(arch, nom_arch);
                                       seek(arch, pos);
                                       write(arch, reg);
                                       close(arch);
                                  end;
                               '2':begin
                                       gotoxy(75,5);
                                       writeln('                           ');
                                       gotoxy(75,5);
                                       readln(reg.direccion_director);
                                       gotoxy(32,5);
                                       writeln('              ');
                                       gotoxy(32,5);
                                       writeln(reg.direccion_director);
                                       reg.estado_director:=true;
                                       abrir_archivo_director(arch, nom_arch);
                                       seek(arch, pos);
                                       write(arch, reg);
                                       close(arch);
                                   end;
                                '3':begin
                                         repeat
                                               gotoxy(21,10);
                                               writeln('                           ');
                                               gotoxy(21,11);
                                               writeln('                                      ');
                                               gotoxy(74,6);
                                               writeln('                           ');
                                               gotoxy(74,6);
                                               {$I-}
                                                    readln(reg.telefono_director);
                                               {$I+}
                                               validacion:=ioresult();
                                               if validacion<>0 then
                                                  begin
                                                       textcolor(red);
                                                       gotoxy(21,10);
                                                       writeln('Debe ingresar solo numeros.');
                                                       gotoxy(21,11);
                                                       writeln('Presione enter para intentar de nuevo.');
                                                       textcolor(white);
                                                       readkey;
                                                  end;
                                         until validacion=0;
                                         gotoxy(21,10);
                                         writeln('                           ');
                                         gotoxy(21,11);
                                         writeln('                                      ');
                                         gotoxy(31,6);
                                         writeln('              ');
                                         gotoxy(31,6);
                                         writeln(reg.telefono_director);
                                         reg.estado_director:=true;
                                         abrir_archivo_director(arch, nom_arch);
                                         seek(arch, pos);
                                         write(arch, reg);
                                         close(arch);
                                    end;
                                '4':begin
                                         repeat
                                               gotoxy(21,10);
                                               writeln('                           ');
                                               gotoxy(21,11);
                                               writeln('                                      ');
                                               gotoxy(73,7);
                                               writeln('                           ');
                                               gotoxy(73,7);
                                               {$I-}
                                                    readln(reg.periodo_director);
                                               {$I+}
                                               validacion:=ioresult();
                                               if validacion<>0 then
                                                  begin
                                                       textcolor(red);
                                                       gotoxy(21,10);
                                                       writeln('Debe ingresar solo numeros.');
                                                       gotoxy(21,11);
                                                       writeln('Presione enter para intentar de nuevo.');
                                                       textcolor(white);
                                                       readkey;
                                                  end;
                                         until validacion=0;
                                         gotoxy(21,10);
                                         writeln('                           ');
                                         gotoxy(21,11);
                                         writeln('                                      ');
                                         gotoxy(30,7);
                                         writeln('              ');
                                         gotoxy(30,7);
                                         writeln(reg.periodo_director);
                                         reg.estado_director:=true;
                                         abrir_archivo_director(arch, nom_arch);
                                         seek(arch, pos);
                                         write(arch, reg);
                                         close(arch);
                                    end;
                         end;
                   until control=#27;
                   end
                      else
                          begin
                               writeln('El director esta dado de baja.');
                               readkey;
                          end;
              end;

              procedure busqueda_nombre_director(var arch:t_directores; nom_arch:string; buscado:st20; var pos:integer);
              var
                 reg_aux:r_directores;
                 i:integer;
              begin
                   i:=0;
                   pos := -1;
                   abrir_archivo_director(arch, nom_arch);
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.nombre_director = buscado then
                           begin
                                pos:=i;
                           end;
                        i:=i+1;
                        seek(arch, i);
                   end;
                   close(arch);
              end;

              procedure busqueda_dni_director(var arch:t_directores; nom_arch:string; buscado:integer; var pos:integer);
              var
                 reg_aux:r_directores;
                 i:integer;
              begin
                   i:=0;
                   pos:=-1;
                   abrir_archivo_director(arch, nom_arch);
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.dni_director = buscado then
                           begin
                                pos:=i;
                           end;
                        i:=i+1;
                        seek(arch, i);
                   end;
                   close(arch);
              end;

              procedure baja_director(var arch:t_directores; nom_arch:string; var pos:integer);
              var
                 reg:r_directores;
              begin
                   leer_director(arch, nom_arch, pos, reg);
                   reg.estado_director:=false;
                   abrir_archivo_director(arch, nom_arch);
                   seek(arch, pos);
                   write(arch, reg);
                   close(arch);
              end;

              procedure alta_estado_director(var arch:t_directores; nom_arch:string; var pos:integer);
              var
                 reg:r_directores;
              begin
                   leer_director(arch, nom_arch, pos, reg);
                   reg.estado_director:=true;
                   abrir_archivo_director(arch, nom_arch);
                   seek(arch, pos);
                   write(arch, reg);
                   close(arch);
              end;

              procedure alta_director(var arch:t_directores; nom_arch:string; var reg:r_directores);
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
                 For i:=1 to 28 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=100;
                 y:=2;
                 For i:=1 to 14 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=45;
                 y:=1;
                 For i:=1 to 28 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                   textcolor (white);
                   posi:=-1;
                   gotoxy(63,2);
                   writeln('Alta de Director');
                   gotoxy(45,4);
                   writeln('Nombre y apellido: ');
                   gotoxy(45,5);
                   writeln('DNI: ');
                   gotoxy(45,6);
                   writeln('Direccion: ');
                   gotoxy(45,7);
                   writeln('Telefono: ');
                   gotoxy(45,8);
                   writeln('Periodo en años: ');
                   gotoxy(64,4);
                   readln(asd);
                   busqueda_nombre_director(arch, nom_arch, asd, posi);
                   if posi = -1 then
                      begin
                           reg.nombre_director:=asd;
                           repeat
                                 gotoxy(50,5);
                                 writeln('                                             ');
                                 gotoxy(50,5);
                                 {$I-}
                                      readln(reg.dni_director);
                                 {$I+}
                                 validacion:=ioresult();
                                 if validacion=0 then
                                    begin
                                         busqueda_dni_director(arch, nom_arch, reg.dni_director, posi);
                                         if posi>-1 then
                                            begin
                                                 gotoxy(45,10);
                                                 textcolor (red);
                                                 writeln('El DNI ya esta registrado. Debe ingresar otro.');
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
                           writeln('                                              ');
                           gotoxy(56,6);
                           readln(reg.direccion_director);
                           repeat
                                        gotoxy(55,7);
                                        writeln('                                        ');
                                        gotoxy(55,7);
                                        {$I-}
                                             readln(reg.telefono_director);
                                        {$I+}
                                        validacion:=ioresult();
                                        if validacion<>0 then
                                           begin
                                                gotoxy(45,10);
                                                textcolor (red);
                                                writeln('Debe ingresar solo numeros');
                                                textcolor (white);
                                           end;
                                   until validacion=0;
                                   gotoxy(45,10);
                                   writeln('                                              ');
                                   repeat
                                          gotoxy(62,8);
                                          writeln('                                  ');
                                          gotoxy(62,8);
                                         {$I-}
                                              readln(reg.periodo_director);
                                         {$I+}
                                         validacion:=ioresult();
                                         if validacion<>0 then
                                            begin
                                                gotoxy(45,10);
                                                textcolor (red);
                                                writeln('Debe ingresar solo numeros');
                                                textcolor (white);
                                            end;
                                   until validacion=0;
                                   gotoxy(45,10);
                                   writeln('                                              ');
                           reg.estado_director:=true;
                           guardar_director(arch, nom_arch, reg);
                           gotoxy(45,10);
                           textcolor (green);
                           writeln('Listo!');
                           textcolor (white);
                           readkey;
                      end
                         else
                             begin
                                  leer_director(arch, nom_arch, posi, reg);
                                  if (reg.estado_director) then
                                     begin
                                          repeat
                                                gotoxy(45,10);
                                                writeln('Este director ya esta registrado.', #168'Que desea hacer?');
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
                                                   modificar_director(arch, nom_arch, posi)
                                                      else
                                                          if (control='2') then
                                                             begin
                                                                  baja_director (arch,nom_arch, posi);
                                                                  gotoxy(45,10);
                                                                  writeln('                                                  ');
                                                                  gotoxy(45,11);
                                                                  writeln('                                              ');
                                                                  gotoxy(45,12);
                                                                  writeln('                                              ');
                                                                  gotoxy(45,13);
                                                                  writeln('                                              ');
                                                                  gotoxy(45,14);
                                                                  writeln('                                              ');
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
                                                                         writeln('                                                  ');
                                                                         gotoxy(45,11);
                                                                         writeln('                                              ');
                                                                         gotoxy(45,12);
                                                                         writeln('                                              ');
                                                                         gotoxy(45,13);
                                                                         writeln('                                              ');
                                                                         gotoxy(45,14);
                                                                         writeln('                                              ');
                                                                         reg.nombre_director:=asd;
                                                                         repeat
                                                                               gotoxy(50,5);
                                                                               writeln('                                     ');
                                                                               gotoxy(50,5);
                                                                               {$I-}
                                                                                    readln(reg.dni_director);
                                                                               {$I+}
                                                                               validacion:=ioresult();
                                                                               if validacion=0 then
                                                                                  begin
                                                                                       busqueda_dni_director(arch, nom_arch, reg.dni_director, posi);
                                                                                       if posi>-1 then
                                                                                          begin
                                                                                               gotoxy(45,10);
                                                                                               textcolor(red);
                                                                                               writeln('El DNI ya esta registrado. Debe ingresar otro');
                                                                                               textcolor(white);
                                                                                          end;
                                                                                  end
                                                                                     else
                                                                                         begin
                                                                                              gotoxy(45,10);
                                                                                              textcolor(red);
                                                                                              writeln('Debe ingresar solo numeros');
                                                                                              textcolor(white);
                                                                                         end;
                                                                         until (posi=-1) and (validacion=0);
                                                                         gotoxy(45,10);
                                                                         writeln('                                              ');
                                                                         gotoxy(56,6);
                                                                         readln(reg.direccion_director);
                                                                         repeat
                                                                                gotoxy(55,7);
                                                                                writeln('                                       ');
                                                                                gotoxy(55,7);
                                                                               {$I-}
                                                                                    readln(reg.telefono_director);
                                                                               {$I+}
                                                                               validacion:=ioresult();
                                                                               if validacion<>0 then
                                                                                  begin
                                                                                       gotoxy(45,10);
                                                                                       textcolor(red);
                                                                                       writeln('Debe ingresar solo numeros');
                                                                                       textcolor(white);
                                                                                  end;
                                                                         until validacion=0;
                                                                         gotoxy(45,10);
                                                                         writeln('                                         ');
                                                                         repeat
                                                                               gotoxy(62,8);
                                                                               writeln('                                  ');
                                                                               gotoxy(62,8);
                                                                               {$I-}
                                                                                    readln(reg.periodo_director);
                                                                               {$I+}
                                                                               validacion:=ioresult();
                                                                               if validacion<>0 then
                                                                                  begin
                                                                                       gotoxy(45,10);
                                                                                       textcolor(red);
                                                                                       writeln('Debe ingresar solo numeros');
                                                                                       textcolor(white);
                                                                                  end;
                                                                         until validacion=0;
                                                                         gotoxy(45,10);
                                                                         writeln('                                      ');
                                                                         reg.estado_director:=true;
                                                                         guardar_director(arch, nom_arch, reg);
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
                                                                                          gotoxy(45,10);
                                                                                          writeln('                                                  ');
                                                                                          gotoxy(45,11);
                                                                                          writeln('                                              ');
                                                                                          gotoxy(45,12);
                                                                                          writeln('                                              ');
                                                                                          gotoxy(45,13);
                                                                                          writeln('                                              ');
                                                                                          gotoxy(45,14);
                                                                                          writeln('                                              ');
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
                                               gotoxy(45,10);
                                               writeln('Este director esta registrado pero esta dada de baja.');
                                               gotoxy(45,11);
                                               writeln('1: Dar de alta');
                                               gotoxy(45,12);
                                               writeln('ESC: Volver');
                                               control:=readkey;
                                               keypressed;
                                               gotoxy(45,10);
                                               writeln('                                                     ');
                                               gotoxy(45,11);
                                               writeln('                                              ');
                                               gotoxy(45,12);
                                               writeln('                                              ');
                                               if (control = '1') then
                                                  begin
                                                       alta_estado_director(arch, nom_arch, posi);
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
                                                                        gotoxy(45,10);
                                                                        writeln('                                                     ');
                                                                        gotoxy(45,11);
                                                                        writeln('                                              ');
                                                                        gotoxy(45,12);
                                                                        writeln('                                              ');
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

              procedure eliminar_archivo_director(var arch:t_directores);
              begin
                   erase(arch);
              end;
begin

end.
