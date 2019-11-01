unit archivos_museos;

interface
         uses crt, archivos_directores;

         type
             st10=string[10];
             st20=string[20];
             st30=string[30];
             st100=string[100];

             r_museos=record
                     nombre_mus:st20;
                     codigo_mus:integer;
                     direccion:st30;
                     ciudad:st30;
                     pais:st30;
                     telefono:integer;
                     dni_director:integer;
                     estado_museo:boolean;
                     end;
         t_museos = file of r_museos;

         procedure abrir_archivo_museo(var arch:t_museos; nom_arch:string);
         procedure leer_museo(var arch:t_museos; nom_arch:string; var pos:integer; var dato_leido:r_museos);
         procedure guardar_museo(var arch:t_museos ; nom_arch:string ; var escribir_dato:r_museos);
         procedure modificar_museo(var arch:t_museos; var arch_d:t_directores; nom_arch:string ; nom_arch_d:string ;pos:integer);
         procedure busqueda_nombre_museo(var arch:t_museos; nom_arch:string; buscado:st20; var pos:integer);
         procedure busqueda_ciudad_museo(var arch:t_museos; nom_arch:string; buscado:st30; var pos:integer);
         procedure busqueda_dni_director_museo(var arch:t_museos; nom_arch:string; buscado:integer; var pos:integer);
         procedure busqueda_codigo_museo(var arch:t_museos; nom_arch:string; buscado:integer; var pos:integer);
         procedure alta_museo(var arch:t_museos; var arch_d:t_directores ;nom_arch:string; nom_arch_d:string ;var reg:r_museos);
         procedure baja_museo(var arch:t_museos; nom_arch:string; var pos:integer);
         procedure alta_estado_museo(var arch:t_museos; nom_arch:string; var pos:integer);
         procedure eliminar_archivo_museo(var arch:t_museos);

implementation
              procedure abrir_archivo_museo(var arch:t_museos;  nom_arch:string); //Abre archivo de tipo texto en modo escritura que borra el contenido y escribe
              begin
                   assign(arch, nom_arch);
                   {$I-}                           //{$I-} directiva para deshabilitar mensajes de error de el sistema operativo.
                        reset(arch);
                   {$I-}
                   if ioresult<>0 then
                      rewrite(arch); //Si la directiva {$I-} devuelve un valor distinto de cero quiere decir que no existe el fichero o hay un problema.                   close(arch);
                   //close(arch);
              end;
              procedure leer_museo(var arch:t_museos; nom_arch:string; var pos:integer; var dato_leido:r_museos); //Lee archivo de tipo texto
              begin
                   abrir_archivo_museo(arch, nom_arch);
                   seek(arch, pos);                  //seek posiciona el puntero en la posicion que indica el segundo parametro
                   read(arch, dato_leido);        //recorre el archivo y lee secuencialmente
                   close(arch);
              end;

              procedure guardar_museo(var arch:t_museos ; nom_arch:string ; var escribir_dato:r_museos); //Escribe en archivo de tipo texto
              var
                 reg_control:r_museos;
                 pos:integer;
              begin
                   pos:=0;
                   leer_museo(arch, nom_arch, pos, reg_control);
                   abrir_archivo_museo(arch, nom_arch);
                   seek(arch, filesize(arch));
                   if filepos(arch)=1 then
                      begin
                           if reg_control.codigo_mus=0 then         //
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
                             end;
                   close(arch);
              end;

              procedure modificar_museo(var arch:t_museos; var arch_d:t_directores; nom_arch:string ; nom_arch_d:string ;pos:integer);
              var
                 x,y,i:integer;
                 reg:r_museos;
                 validacion:integer;
                 control:char;
                 posi:integer;
              begin
                   clrscr;
                   leer_museo(arch, nom_arch, pos, reg);
                   if reg.estado_museo then
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
                   writeln('Nombre del museo: ', reg.nombre_mus);
                   gotoxy(21,4);
                   writeln('DNI del director: ', reg.dni_director);
                   gotoxy(21,5);
                   writeln('Direccion: ', reg.direccion);
                    gotoxy(21,6);
                   writeln('Ciudad: ', reg.ciudad);
                   gotoxy(21,7);
                   writeln('Pais: ', reg.pais);
                   gotoxy(21,8);
                   writeln('Telefono: ', reg.telefono);
                   gotoxy(61,2);
                   writeln(#168,'Que desea modificar?');
                   gotoxy(61,3);
                   writeln('1: Nombre del museo: ');
                   gotoxy(61,4);
                   writeln('2: DNI del director: ');
                   gotoxy(61,5);
                   writeln('3: Direccion: ');
                   gotoxy(61,6);
                   writeln('4: Ciudad: ');
                   gotoxy(61,7);
                   writeln('5: Pais: ');
                   gotoxy(61,8);
                   writeln('6: Telefono: ');
                   gotoxy(61,9);
                   writeln('ESC: Salir');
                   repeat
                         gotoxy(21,10);
                         control:=readkey;
                         keypressed;
                         case control of
                              '1':begin
                                       gotoxy(82,3);
                                       writeln('                           ');
                                       gotoxy(82,3);
                                       readln(reg.nombre_mus);
                                       gotoxy(38,3);
                                       writeln('              ');
                                       gotoxy(38,3);
                                       writeln(reg.nombre_mus);
                                       reg.estado_museo:=true;
                                       abrir_archivo_museo(arch, nom_arch);
                                       seek(arch, pos);
                                       write(arch, reg);
                                       close(arch);
                                   end;
                               '2':begin
                                        repeat
                                              gotoxy(21,16);
                                              writeln('                                                                       ');
                                              gotoxy(82,4);
                                              writeln('                 ');
                                              gotoxy(82,4);
                                              {$I-}
                                                   readln(reg.dni_director);
                                              {$I+}
                                              validacion:=ioresult();
                                              if validacion<>0 then
                                                 begin
                                                      gotoxy(21,16);
                                                      textcolor(red);
                                                      writeln('Debe ingresar solo numeros. Presione enter para intentar de nuevo.');
                                                      Textcolor (white);
                                                      readkey;
                                                 end;
                                        until validacion=0;
                                        busqueda_dni_director(arch_d, nom_arch_d, reg.dni_director, posi);
                                        if posi>-1 then
                                           begin
                                                gotoxy(39,4);
                                                writeln('               ');
                                                gotoxy(39,4);
                                                writeln(reg.dni_director);
                                                abrir_archivo_museo(arch, nom_arch);
                                                seek(arch, pos);
                                                write(arch, reg);
                                                close(arch);
                                           end
                                              else
                                                  begin
                                                       gotoxy(21,16);
                                                       writeln('                                                                    ');
                                                       gotoxy(21,16);
                                                       Textcolor (red);
                                                       writeln('El director no esta registrado. Debe registrar primero el director');
                                                       Textcolor(white);
                                                       readkey;
                                                       gotoxy(21,16);
                                                       writeln('                                                                    ');
                                                  end;
                                   end;
                               '3':begin
                                        gotoxy(75,5);
                                        writeln('                           ');
                                        gotoxy(75,5);
                                        readln(reg.direccion);
                                        gotoxy(32,5);
                                        writeln('              ');
                                        gotoxy(32,5);
                                        writeln(reg.direccion);
                                        reg.estado_museo:=true;
                                        abrir_archivo_museo(arch, nom_arch);
                                        seek(arch, pos);
                                        write(arch, reg);
                                        close(arch);
                                   end;
                               '4':begin
                                        gotoxy(72,6);
                                        writeln('                           ');
                                        gotoxy(72,6);
                                        readln(reg.ciudad);
                                        gotoxy(29,6);
                                        writeln('              ');
                                        gotoxy(29,6);
                                        writeln(reg.ciudad);
                                        reg.estado_museo:=true;
                                        abrir_archivo_museo(arch, nom_arch);
                                        seek(arch, pos);
                                        write(arch, reg);
                                        close(arch);
                                   end;
                               '5':begin
                                        gotoxy(70,7);
                                        writeln('                           ');
                                        gotoxy(70,7);
                                        readln(reg.pais);
                                        gotoxy(27,7);
                                        writeln('              ');
                                        gotoxy(27,7);
                                        writeln(reg.pais);
                                        reg.estado_museo:=true;
                                        abrir_archivo_museo(arch, nom_arch);
                                        seek(arch, pos);
                                        write(arch, reg);
                                        close(arch);
                                   end;
                               '6':begin
                                        repeat
                                              gotoxy(21,16);
                                              writeln('                                                                       ');
                                              gotoxy(74,8);
                                              writeln('                           ');
                                              gotoxy(74,8);
                                              {$I-}
                                                   readln(reg.telefono);
                                              {$I+}
                                              validacion:=ioresult();
                                              if validacion <> 0 then
                                              begin
                                                   gotoxy(21,16);
                                                   textcolor(red);
                                                   writeln('Debe ingresar solo numeros. Presione enter para intentar de nuevo.');
                                                   Textcolor (white);
                                                   readkey;
                                              end;
                                         until validacion=0;
                                         gotoxy(31,8);
                                         writeln('              ');
                                         gotoxy(31,8);
                                         writeln(reg.telefono);
                                         reg.estado_museo:=true;
                                         abrir_archivo_museo(arch, nom_arch);
                                         seek(arch, pos);
                                         write(arch, reg);
                                         close(arch);
                                   end;
                         end;
                   until control=#27;
                   end
                      else
                          begin
                               textcolor(yellow);
                               writeln('El museo esta dado de baja');
                               textcolor(white);
                               readkey;
                          end;
              end;

              procedure busqueda_nombre_museo(var arch:t_museos; nom_arch:string; buscado:st20; var pos:integer);
              var
                 reg_aux:r_museos;
                 i:integer;
              begin
                   i:=0;
                   pos := -1;
                   abrir_archivo_museo(arch, nom_arch);
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.nombre_mus = buscado then
                           begin
                                pos:=i;
                           end;
                        i:=i+1;
                        seek(arch, i);
                   end;
                   close(arch);
              end;

              procedure busqueda_ciudad_museo(var arch:t_museos; nom_arch:string; buscado:st30; var pos:integer);
              var
                 reg_aux:r_museos;
                 i:integer;
              begin
                   i:=0;
                   pos := -1;
                   abrir_archivo_museo(arch, nom_arch);
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.ciudad = buscado then
                           begin
                                pos:=i;
                           end;
                        i:=i+1;
                        seek(arch, i);
                   end;
                   close(arch);
              end;

              procedure busqueda_dni_director_museo(var arch:t_museos; nom_arch:string; buscado:integer; var pos:integer);
              var
                 reg_aux:r_museos;
                 i:integer;
              begin
                   i:=0;
                   pos := -1;
                   abrir_archivo_museo(arch, nom_arch);
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

              procedure busqueda_codigo_museo(var arch:t_museos; nom_arch:string; buscado:integer; var pos:integer);
              var
                 reg_aux:r_museos;
                 i:integer;
              begin
                   i:=0;
                   pos := -1;
                   abrir_archivo_museo(arch, nom_arch);
                   while not eof(arch) do
                   begin
                        read(arch, reg_aux);
                        if reg_aux.codigo_mus = buscado then
                           begin
                                pos:=i;
                           end;
                        i:=i+1;
                        seek(arch, i);
                   end;
                   close(arch);
              end;

              procedure baja_museo(var arch:t_museos; nom_arch:string; var pos:integer);
              var
                 reg:r_museos;
              begin
                   leer_museo(arch, nom_arch, pos, reg);
                   reg.estado_museo:=false;
                   abrir_archivo_museo(arch, nom_arch);
                   seek(arch, pos);
                   write(arch, reg);
                   close(arch);
              end;

              procedure alta_estado_museo(var arch:t_museos; nom_arch:string; var pos:integer);
              var
                 reg:r_museos;
              begin
                   leer_museo(arch, nom_arch, pos, reg);
                   reg.estado_museo:=true;
                   abrir_archivo_museo(arch, nom_arch);
                   seek(arch, pos);
                   write(arch, reg);
                   close(arch);
              end;

              procedure alta_museo(var arch:t_museos; var arch_d:t_directores ;nom_arch:string; nom_arch_d:string ;var reg:r_museos);
              var
                 posi,x,y,i:integer;
                 control:char;
                 asd:string;
                 validacion:integer;
                 reg_d:r_directores;
                 ultima_posicion:integer;
                 reg_aux_cod:r_museos;
              begin
                   abrir_archivo_museo(arch,nom_arch); //
                   if filesize(arch)=0 then            //
                      begin                           //
                           reg.codigo_mus:=0;         //  Inicializacion del archivo
                           seek(arch,0);
                           write(arch, reg);          //
                      end;                            //
                   close(arch);                      //
                   clrscr;
                 textcolor (blue);
                 x:=44;
                 y:=2;
                 For i:=1 to 17 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=45;
                 y:=18;
                 For i:=1 to 26 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=96;
                 y:=2;
                 For i:=1 to 17 do
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
                   writeln('Alta de Museo');
                   gotoxy(45,4);
                   writeln('Nombre: ');
                   gotoxy(45,5);
                   writeln('DNI del director: ');
                   gotoxy(45,6);
                   writeln('Direccion: ');
                   gotoxy(45,7);
                   writeln('Ciudad: ');
                   gotoxy(45,8);
                   writeln('Pais: ');
                   gotoxy(45,9);
                   writeln('Telefono: ');
                   gotoxy(45,11);
                   writeln('Codigo: ');
                   gotoxy(53,4);
                   readln(asd);
                   abrir_archivo_museo(arch, nom_arch); //
                   ultima_posicion:=filesize(arch)-1;  // lectura de la posicion del ultimo registro
                   close(arch);                        //
                   leer_museo(arch, nom_arch, ultima_posicion, reg_aux_cod); //
                   reg.codigo_mus:=reg_aux_cod.codigo_mus+1;                // generar codigo de obra automaticamente
                   gotoxy(53,11);
                   writeln(reg.codigo_mus);
                   busqueda_nombre_museo(arch, nom_arch, asd, posi);
                   if posi = -1 then
                      begin
                           reg.nombre_mus:=asd;
                           repeat
                                 gotoxy(63,5);
                                 writeln('                           ');
                                 gotoxy(63,5);
                                 {$I-}
                                      readln(reg.dni_director);
                                 {$I+}
                                 validacion:=ioresult();
                                 if validacion<>0 then
                                    begin
                                         gotoxy(45,12);
                                         textcolor (red);
                                         writeln('Debe ingresar solo numeros.');
                                         textcolor (white);
                                    end;
                           until validacion=0;
                           gotoxy(45,12);
                           writeln('                                   ');
                           busqueda_dni_director(arch_d, nom_arch_d, reg.dni_director, posi);
                           if posi>-1 then
                              begin
                                   leer_director(arch_d, nom_arch_d, posi, reg_d);
                                   if reg_d.estado_director then
                                      begin
                                           gotoxy(56,6);
                                           readln(reg.direccion);
                                           gotoxy(53,7);
                                           readln(reg.ciudad);
                                           gotoxy(51,8);
                                           readln(reg.pais);
                                           repeat
                                                 gotoxy(55,9);
                                                 writeln('                                 ');
                                                 gotoxy(55,9);
                                                 {$I-}
                                                      readln(reg.telefono);
                                                 {$I+}
                                                 validacion:=ioresult();
                                                 if validacion <> 0 then
                                                    begin
                                                         gotoxy(45,12);
                                                         textcolor (red);
                                                         writeln('Debe ingresar solo numeros');
                                                         textcolor (white);
                                                    end;
                                           until validacion=0;
                                           gotoxy(45,12);
                                           writeln('                                   ');
                                           reg.estado_museo:=true;
                                           guardar_museo(arch, nom_arch, reg);
                                           gotoxy(45,12);
                                           textcolor (green);
                                           writeln('Listo!');
                                           textcolor (white);
                                           readkey;
                                      end
                                         else
                                             begin
                                                  gotoxy(45,12);
                                                  textcolor (red);
                                                  writeln('El director esta registrado pero dado de baja.');
                                                  gotoxy(45,13);
                                                  writeln('Debe darlo de alta para continuar');
                                                  textcolor (white);
                                                  readkey;
                                             end;
                              end
                                 else
                                     begin
                                          gotoxy(45,12);
                                          textcolor (red);
                                          writeln('El director del museo no esta registrado.');
                                          Gotoxy(45,13);
                                          Writeln('Registre primero el director para continuar.');
                                          textcolor (white);
                                          readkey;
                                     end;
                      end
                         else
                             begin
                                  leer_museo(arch, nom_arch, posi, reg);
                                  if (reg.estado_museo) then
                                     begin
                                          repeat
                                                gotoxy(45,12);
                                                writeln('Esta museo ya esta registrado.', #168'Que desea hacer?');
                                                gotoxy(45,13);
                                                writeln('1: Modificar');
                                                gotoxy(45,14);
                                                writeln('2: Dar de baja');
                                                gotoxy(45,15);
                                                writeln('ESC: Volver');
                                                control:=readkey;
                                                keypressed;
                                                if (control = '1') then
                                                   modificar_museo(arch, arch_d ,nom_arch, nom_arch_d ,posi)
                                                      else
                                                          if (control='2') then
                                                             begin
                                                                  gotoxy(45,12);
                                                                  writeln('                                                       ');
                                                                  gotoxy(45,13);
                                                                  writeln('                          ');
                                                                  gotoxy(45,14);
                                                                  writeln('                  ');
                                                                  gotoxy(45,15);
                                                                  writeln('                ');
                                                                  baja_museo (arch,nom_arch, posi);
                                                                  gotoxy(45,12);
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
                                                                                gotoxy(45,12);
                                                                                writeln('                               ');
                                                                                gotoxy(45,13);
                                                                                writeln('                          ');
                                                                                gotoxy(45,14);
                                                                                writeln('                  ');
                                                                                gotoxy(45,15);
                                                                                writeln('                ');
                                                                                gotoxy(45,12);
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
                                                    gotoxy(45,12);
                                                    writeln('Este museo esta registrado pero esta dado de baja.');
                                                    gotoxy(45,13);
                                                    writeln('1: Dar de alta');
                                                    gotoxy(45,14);
                                                    writeln('ESC: Volver');
                                                    control:=readkey;
                                                    keypressed;
                                                    if (control = '1') then
                                                       begin
                                                            gotoxy(45,12);
                                                            writeln('                                                  ');
                                                            gotoxy(45,13);
                                                            writeln('                  ');
                                                            gotoxy(45,14);
                                                            writeln('                       ');
                                                            alta_estado_museo(arch, nom_arch, posi);
                                                            gotoxy(45,12);
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
                                                                          gotoxy(45,12);
                                                                          writeln('                                    ');
                                                                          gotoxy(45,13);
                                                                          writeln('                  ');
                                                                          gotoxy(45,14);
                                                                          writeln('                       ');
                                                                          gotoxy(45,12);
                                                                          writeln('La tecla ingresada es erronea...');
                                                                          readkey;
                                                                     end;
                                              until (control = '1') or (control = #27);
                                          end;
                             end;
              end;

              procedure eliminar_archivo_museo(var arch:t_museos);
              begin
                   erase(arch);
              end;
begin

end.
