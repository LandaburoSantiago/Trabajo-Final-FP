Unit menu;
Interface
         Uses crt, archivos_obras, archivos_museos, archivos_directores, archivos_artistas, vectores_obras, vectores_museos, vectores_directores,vectores_artistas;

         Procedure menu_principal;
         Procedure menu_abmc;
         Procedure menu_listado;
         Procedure menu_estadistica;
         Procedure menu_alta;
         Procedure menu_baja;
         Procedure menu_modificar;
         Procedure menu_consultar;
         procedure consulta_obra(var arch_o:t_obras;var arch_a:t_artistas;var arch_m:t_museos; nom_o:string; nom_m:string;nom_a:string);
         procedure consulta_museo(var arch_o:t_obras; var arch_m:t_museos;var arch_d:t_directores;nom_d:string ;nom_o:string; nom_m:string);
         procedure consulta_artista(var arch_o:t_obras; var arch_a:t_artistas ;nom_o:string; nom_a:string);
         procedure estadistica(var arch_o:t_obras; var arch_m:t_museos; nom_o:string; nom_m:string);
var
   nombre_o:string;
   nombre_m:string;
   nombre_d:string;
   nombre_a:string;
   arch_obra:t_obras;
   arch_museo:t_museos;
   arch_director:t_directores;
   arch_artista:t_artistas;


Implementation
            Procedure menu_principal;
            var
               x,y,i, color:integer;
               control,control2:char;
            Begin
                 abrir_archivo_obra(arch_obra, nombre_o);
                 close(arch_obra);
                 abrir_archivo_museo(arch_museo, nombre_m);
                 close(arch_museo);
                 abrir_archivo_director(arch_director, nombre_d);
                 close(arch_director);
                 abrir_archivo_artista(arch_artista, nombre_a);
                 close(arch_artista);
                 repeat
                 clrscr;
                 textcolor (white);
                 color:=1;
                 x:=46;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=25;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=96;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 Gotoxy (63,3);
                 Writeln (#168'Que desea hacer?');
                 Gotoxy (48,6);
                 Writeln ('1: ABMC');
                 Gotoxy (48,10);
                 Writeln ('2: Listados');
                 Gotoxy (48,14);
                 Writeln ('3: Estadisticas');
                 Gotoxy (48,18);
                 Writeln ('4: Vaciar archivos');
                 Gotoxy (48,22);
                 Writeln ('5: Salir');

                 Repeat
                 textcolor (color);
                 For i:=1 to 1 do
                 Begin
                 Gotoxy (63,3);
                 Writeln (#168'Que desea hacer?');
                 End;
                 x:=46;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                      delay(5);
                 End;
                 x:=47;
                 y:=25;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2;
                      delay(5);
                 End;
                 x:=96;
                 y:=25;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      y:=y-1;
                      delay(5);
                 End;
                 x:=95;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x-2;
                      delay(5);
                 End;
                 inc (color);
                 Until (keypressed = true);
                 control:=readkey;
                 case control of
                      '1':Begin
                               clrscr;
                               menu_abmc;
                          End;

                      '2':Begin
                               clrscr;
                               menu_listado
                          End;
                      '3':begin
                               clrscr;
                               menu_estadistica;
                          end;

                      '4': Begin
                                clrscr;
                                textcolor (white);
                                clrscr;
                                  color:=1;
                                  x:=46;
                                  y:=2;
                                  For i:=1 to 16 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln('|');
                                       inc (y);
                                  End;
                                  x:=47;
                                  y:=17;
                                  For i:=1 to 25 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln ('_');
                                       x:=x+2;
                                  End;
                                  x:=97;
                                  y:=17;
                                  For i:=1 to 16 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln('|');
                                       y:=y-1;
                                  End;
                                  x:=96;
                                  y:=1;
                                  For i:=1 to 25 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln ('_');
                                       x:=x-2;
                                  End;
                                  textcolor (white);
                                  Gotoxy (54,4);
                                  Writeln (#168'Seguro que desea vaciar los archivos?');
                                  Gotoxy (54,7);
                                  writeln ('1:SI');
                                  Gotoxy (87,7);
                                  Writeln ('2:NO');
                                  Repeat
                                  textcolor (color);
                                  Gotoxy (54,4);
                                  Writeln (#168'Seguro que desea vaciar los archivos?');
                                  x:=46;
                                  y:=2;
                                  For i:=1 to 16 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln('|');
                                       inc (y);
                                       delay(5);
                                  End;
                                  x:=47;
                                  y:=17;
                                  For i:=1 to 25 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln ('_');
                                       x:=x+2;
                                       delay(5);
                                  End;
                                  x:=97;
                                  y:=17;
                                  For i:=1 to 16 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln('|');
                                       y:=y-1;
                                       delay(5);
                                  End;
                                  x:=96;
                                  y:=1;
                                  For i:=1 to 25 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln ('_');
                                       x:=x-2;
                                       delay(5);
                                  End;
                                  inc (color);
                                  Until (keypressed = true);
                                  control2:=readkey;
                                Repeat
                                      If control2 = '1' then
                                         begin
                                              eliminar_archivo_obra(arch_obra);
                                              eliminar_archivo_museo(arch_museo);
                                              eliminar_archivo_artista(arch_artista);
                                              eliminar_archivo_director(arch_director);
                                              clrscr;
                                              textcolor(green);
                                              writeln('Listo!');
                                              textcolor(white);
                                              readkey;
                                              clrscr;
                                              menu_principal
                                         end;

                                      If control2 = '2' then
                                         Begin
                                              clrscr;
                                              menu_principal;
                                         End;
                                  until (control2='1') or (control2='2');
                           End;

                         '5':begin
                                  textcolor (white);
                                  clrscr;
                                  repeat
                                  color:=1;
                                  x:=46;
                                  y:=2;
                                  For i:=1 to 16 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln('|');
                                       inc (y);
                                  End;
                                  x:=47;
                                  y:=1;
                                  For i:=1 to 25 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln ('_');
                                       x:=x+2
                                  End;
                                  x:=96;
                                  y:=2;
                                  For i:=1 to 16 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln('|');
                                       inc (y);
                                  End;
                                  x:=47;
                                  y:=17;
                                  For i:=1 to 25 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln ('_');
                                       x:=x+2
                                  End;
                                  textcolor (white);
                                  Gotoxy (58,4);
                                  Writeln (#168'Seguro que desea salir?');
                                  Gotoxy (58,7);
                                  writeln ('1:SI');
                                  Gotoxy (78,7);
                                  Writeln ('2:NO');
                                  Gotoxy (82,16);
                                  Textcolor (color);
                                  Writeln ('F.G. S.L. N.M.');
                                  Repeat
                                  textcolor (color);
                                  Gotoxy (58,4);
                                  Writeln (#168'Seguro que desea salir?');
                                  x:=46;
                                  y:=2;
                                  For i:=1 to 16 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln('|');
                                       inc (y);
                                       delay(5);
                                  End;
                                  x:=47;
                                  y:=17;
                                  For i:=1 to 25 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln ('_');
                                       x:=x+2;
                                       delay(5);
                                  End;
                                  x:=96;
                                  y:=17;
                                  For i:=1 to 16 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln('|');
                                       y:=y-1;
                                       delay(5);
                                  End;
                                  x:=95;
                                  y:=1;
                                  For i:=1 to 25 do
                                  Begin
                                       Gotoxy (x,y);
                                       Writeln ('_');
                                       x:=x-2;
                                       delay(5);
                                  End;
                                  inc (color);
                                  Until (keypressed = true);
                                  control2:=readkey;
                                  If control2 = '1' then
                                     halt;
                                  If control2 = '2' then
                                     Begin
                                          clrscr;
                                          menu_principal;
                                     End;
                                  until (control2='1') or (control2='2');
                             end;

                 else
                     clrscr;
                     textcolor (white);
                     Writeln ('El numero ingresado es erroneo');
                     Writeln ('Presione una tecla para continuar');
                     readkey;
                     clrscr;
                 End;
                 Until (control='1') or (control='2') or (control='3');
                 Readkey;
            End;


            Procedure menu_abmc;
            var
            x,y,i, color:integer;
            control:char;
            Begin
                 clrscr;
                 repeat
                 textcolor (white);
                 color:=1;
                 x:=46;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=96;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=25;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 Gotoxy (63,3);
                 Writeln(#168'Que desea hacer?');
                 Gotoxy (47,6);
                 Writeln ('1: Dar de alta');
                 Gotoxy (47,10);
                 Writeln ('2: Dar de baja');
                 Gotoxy (47,14);
                 Writeln ('3: Modificar');
                 Gotoxy (47,18);
                 Writeln ('4: Consultar');
                 Gotoxy (47,22);
                 Writeln ('5: Volver al menu principal');

                 Repeat
                 textcolor (color);
                 Gotoxy (63,3);
                 Writeln (#168'Que desea hacer?');
                 x:=46;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                      delay(5);
                 End;
                 x:=47;
                 y:=25;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2;
                      delay(5);
                 End;
                 x:=96;
                 y:=25;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      y:=y-1;
                      delay(5);
                 End;
                 x:=95;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x-2;
                      delay(5);
                 End;
                 inc (color);
                 Until (keypressed = true);
                 control:=readkey;
                 case control of
                      '1':Begin
                               textcolor(white);
                               clrscr;
                               menu_alta;
                          End;
                      '2':Begin
                               textcolor(white);
                               clrscr;
                               menu_baja;
                          End;
                      '3':Begin
                               textcolor(white);
                               clrscr;
                               menu_modificar;
                          End;
                      '4':Begin
                               clrscr;
                               menu_consultar;
                          End;
                      '5':Begin
                               textcolor(white);
                               clrscr;
                               menu_principal
                          End;
                 else
                     clrscr;
                     textcolor (white);
                     Writeln ('El numero ingresado es erroneo');
                     Writeln ('Presione una tecla para continuar');
                     readkey;
                     clrscr;
                 End;
                 Until (control='1') or (control='2') or (control='3') or (control='4') or (control='5');
                 Readkey;
            End;


            Procedure menu_listado;
            var
               x,y,i, color:integer;
               control:char;
               vo:v_obras;
               vm:v_museos;
               vd:v_directores;
               va:v_artistas;
            Begin
                 inicializar_vector_obra(vo);
                 inicializar_vector_museo(vm);
                 inicializar_vector_director(vd);
                 inicializar_vector_artista(va);
                 clrscr;
                 repeat
                 textcolor (white);
                 color:=1;
                 x:=41;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=42;
                 y:=1;
                 For i:=1 to 30 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=101;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=42;
                 y:=25;
                 For i:=1 to 30 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 Gotoxy (60,3);
                 Writeln(#168'Que desea ver?');
                 Gotoxy (42,6);
                 Writeln ('1: Museos ordenados alfabeticamente');
                 Gotoxy (42,10);
                 Writeln ('2: Artistas ordenados alfabeticamente');
                 Gotoxy (42,14);
                 Writeln ('3: Obras ordenadas alfabeticamente');
                 Gotoxy (42,18);
                 Writeln ('4: Directores ordenados alfabeticamente');
                 Gotoxy (42,22);
                 Writeln ('5: Volver al menu principal');
                 Repeat
                 textcolor (color);
                 Gotoxy (60,3);
                 Writeln(#168'Que desea ver?');
                 x:=41;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                      delay(5);
                 End;
                 x:=42;
                 y:=25;
                 For i:=1 to 30 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2;
                      delay(5);
                 End;
                 x:=101;
                 y:=25;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      y:=y-1;
                      delay(5);
                 End;
                 x:=100;
                 y:=1;
                 For i:=1 to 30 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x-2;
                      delay(5);
                 End;
                 inc (color);
                 Until (keypressed = true);
                 control:=readkey;
                 case control of
                      '1': begin
                                textcolor(white);
                                clrscr;
                                listado_museo(arch_museo, nombre_m, vm);
                                menu_principal;
                           end;
                      '2':begin
                                textcolor(white);
                                clrscr;
                                listado_artista(arch_artista, nombre_a, va);
                                menu_principal;
                           end;
                      '3': begin
                                textcolor(white);
                                clrscr;
                                listado_obras(arch_obra, nombre_o, vo);
                                menu_principal;
                           end;
                      '4': begin
                                textcolor(white);
                                clrscr;
                                listado_director(arch_director, nombre_d, vd);
                                menu_principal;
                           end;
                      '5':Begin
                               clrscr;
                               menu_principal;
                          End;
                 else
                     clrscr;
                     textcolor (white);
                     Writeln ('El numero ingresado es erroneo');
                     Writeln ('Presione una tecla para continuar');
                     readkey;
                     clrscr;
                 End;
                 Until (control='1') or (control='2') or (control='3') or (control='4') or (control='5'); //-------
                 Readkey;
            End;

            Procedure menu_alta;
            var
               x,y,i, color:integer;
               control:char;
               ro:r_obras;
               rm:r_museos;
               rd:r_directores;
               ra:r_artistas;
            Begin
                 repeat
                 textcolor (white);
                 color:=1;
                 x:=46;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=96;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=25;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 Gotoxy (59,3);
                 Writeln(#168'Que desea dar de alta?');
                 Gotoxy (47,6);
                 Writeln ('1: Museo');
                 Gotoxy (47,10);
                 Writeln ('2: Obra');
                 Gotoxy (47,14);
                 Writeln ('3: Director');
                 Gotoxy (47,18);
                 Writeln ('4: Artista');
                 Gotoxy (47,22);
                 Writeln ('5: Volver al menu principal');

                 Repeat
                 textcolor (color);
                 Gotoxy (59,3);
                 Writeln(#168'Que desea dar de alta?');
                 x:=46;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                      delay(5);
                 End;
                 x:=47;
                 y:=25;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2;
                      delay(5);
                 End;
                 x:=96;
                 y:=25;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      y:=y-1;
                      delay(5);
                 End;
                 x:=95;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x-2;
                      delay(5);
                 End;
                 inc (color);
                 Until (keypressed = true);
                 control:=readkey;
                 case control of
                      '1':begin
                               textcolor(white);
                               clrscr;
                               alta_museo(arch_museo, arch_director ,nombre_m, nombre_d ,rm);
                               menu_principal;
                          end;
                      '2':begin
                                textcolor(white);
                                clrscr;
                                alta_obra(arch_obra,arch_artista,arch_museo,nombre_m,nombre_a,nombre_o, ro);
                                menu_principal;
                          end;
                      '3':begin
                                textcolor(white);
                                clrscr;
                                alta_director(arch_director, nombre_d, rd);
                                menu_principal;
                          end;
                      '4':begin
                                textcolor(white);
                                clrscr;
                                alta_artista(arch_artista, nombre_a, ra);
                                menu_principal;
                          end;
                      '5':Begin
                               clrscr;
                               menu_principal;
                          End;
                 else
                     clrscr;
                     textcolor (white);
                     Writeln ('El numero ingresado es erroneo');
                     Writeln ('Presione una tecla para continuar');
                     readkey;
                     clrscr;
                 End;
                 Until (control='1') or (control='2') or (control='3') or (control='4') or (control='5');
                 Readkey;
            End;


            Procedure menu_baja;
            var
               x,y,i, color:integer;
               control:char;
               aux:integer;
               pos:integer;
               validacion:integer;
            Begin
                 repeat
                 textcolor (white);
                 color:=1;
                 x:=46;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=96;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=25;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 Gotoxy (59,3);
                 Writeln(#168'Que desea dar de baja?');
                 Gotoxy (47,6);
                 Writeln ('1: Museo');
                 Gotoxy (47,10);
                 Writeln ('2: Obra');
                 Gotoxy (47,14);
                 Writeln ('3: Director');
                 Gotoxy (47,18);
                 Writeln ('4: Artista');
                 Gotoxy (47,22);
                 Writeln ('5: Volver al menu principal');

                 Repeat
                 textcolor (color);
                 Gotoxy (59,3);
                 Writeln(#168'Que desea dar de baja?');
                 x:=46;
                 y:=2;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                      delay(5);
                 End;
                 x:=47;
                 y:=25;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2;
                      delay(5);
                 End;
                 x:=96;
                 y:=25;
                 For i:=1 to 24 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      y:=y-1;
                      delay(5);
                 End;
                 x:=95;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x-2;
                      delay(5);
                 End;
                 inc (color);
                 Until (keypressed = true);
                 control:=readkey;
                 case control of
                      '1':begin
                               textcolor(white);
                               repeat
                                     clrscr;
                                     repeat
                                           writeln('Ingrese el codigo del museo que desea dar de baja: ');
                                           {$I-}
                                                readln(aux);
                                           {$I+}
                                           validacion:=ioresult();
                                           if validacion<>0 then
                                              begin
                                                   textcolor(red);
                                                   writeln('Debe ingresar solo numeros.');
                                                   textcolor(white);
                                              end;
                                     until validacion=0;
                                     busqueda_codigo_museo(arch_museo, nombre_m, aux, pos);
                                     if pos>-1 then
                                     begin
                                        baja_museo(arch_museo, nombre_m, pos);
                                        textcolor(green);
                                        writeln('Listo!. Presione cualquier tecla...');
                                        textcolor(white);
                                        readkey;
                                        menu_abmc;
                                        end
                                        else
                                            begin
                                                 textcolor(red);
                                                 writeln('El museo no esta registrado.. Presione cualquier tecla para continuar. ');
                                                 textcolor(white);
                                                 readkey;
                                                 menu_abmc;
                                            end;
                                 until (pos>-1)
                          end;
                      '2':begin
                               textcolor(white);
                               repeat
                                     clrscr;
                                     repeat
                                           writeln('Ingrese el codigo de la obra que desea dar de baja: ');
                                           {$I-}
                                                readln(aux);
                                           {$I+}
                                           validacion:=ioresult();
                                           if validacion<>0 then
                                              begin
                                                   textcolor(red);
                                                   writeln('Debe ingresar solo numeros.');
                                                   textcolor(white);
                                              end;
                                      until validacion=0;
                                     busqueda_codigo_obra(arch_obra, nombre_o, aux, pos);
                                     if pos>-1 then
                                        begin
                                             baja_obra(arch_obra, nombre_o, pos);
                                             textcolor(green);
                                             writeln('Listo!. Presione cualquier tecla...');
                                             textcolor(white);
                                             readkey;
                                             menu_abmc;
                                        end
                                        else
                                            begin
                                                 textcolor(red);
                                                 writeln('La obra no esta registrada.. Presione cualquier tecla para continuar. ');
                                                 textcolor(white);
                                                 readkey;
                                                 menu_abmc;
                                            end;
                                 until (pos>-1)
                          end;
                      '3':begin
                               textcolor(white);
                               repeat
                                     clrscr;
                                     repeat
                                           writeln('Ingrese el DNI del director que desea dar de baja: ');
                                           {$I-}
                                                readln(aux);
                                           {$I+}
                                           validacion:=ioresult();
                                           if validacion<>0 then
                                              begin
                                                   textcolor(red);
                                                   writeln('Debe ingresar solo numeros.');
                                                   textcolor(white);
                                              end;
                                     until validacion=0;
                                     busqueda_dni_director(arch_director, nombre_d, aux, pos);
                                     if pos>-1 then
                                        begin
                                             baja_director(arch_director, nombre_d, pos);
                                             textcolor(green);
                                             writeln('Listo!. Presione cualquier tecla...');
                                             textcolor(white);
                                             readkey;
                                             menu_abmc;
                                        end
                                        else
                                            begin
                                                 textcolor(red);
                                                 writeln('El director no esta registrado.. Presione cualquier tecla para continuar. ');
                                                 textcolor(white);
                                                 readkey;
                                                 menu_abmc;
                                            end;
                                 until (pos>-1)
                          end;
                      '4':begin
                               textcolor(white);
                               repeat
                                     clrscr;
                                     repeat
                                           writeln('Ingrese el DNI del artista que desea dar de baja: ');
                                           {$I-}
                                                readln(aux);
                                           {$I+}
                                           validacion:=ioresult();
                                           if validacion<>0 then
                                              begin
                                                   textcolor(red);
                                                   writeln('Debe ingresar solo numeros.');
                                                   textcolor(white);
                                              end;
                                     until validacion=0;
                                     busqueda_dni_artista(arch_artista, nombre_a, aux, pos);
                                     if pos>-1 then
                                        begin
                                             baja_artista(arch_artista, nombre_a, pos);
                                             textcolor(green);
                                             writeln('Listo!. Presione cualquier tecla...');
                                             textcolor(white);
                                             readkey;
                                             menu_abmc;
                                        end
                                        else
                                            begin
                                                 textcolor(red);
                                                 writeln('El artista no esta registrado.. Presione cualquier tecla para continuar. ');
                                                 textcolor(white);
                                                 readkey;
                                                 menu_abmc;
                                            end;
                                 until (pos>-1)
                          end;
                      '5':Begin
                               clrscr;
                               menu_principal;
                          End;
                 else
                     clrscr;
                     textcolor (white);
                     Writeln ('El numero ingresado es erroneo');
                     Writeln ('Presione una tecla para continuar...');
                     readkey;
                     clrscr;
                 End;
                 Until (control='1') or (control='2') or (control='3') or (control='4') or (control='5');
                 Readkey;
            End;


            Procedure menu_modificar;
            var
               x,y,i, color:integer;
               control:char;
               aux:integer;
               pos:integer;
               validacion:integer;
            Begin
                 repeat
                 textcolor (white);
                 color:=1;
                 x:=46;
                 y:=2;
                 For i:=1 to 16 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=96;
                 y:=2;
                 For i:=1 to 16 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=17;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 Gotoxy (61,3);
                 Writeln(#168'Que desea modificar?');
                 Gotoxy (47,6);
                 Writeln ('1: Museo');
                 Gotoxy (47,10);
                 Writeln ('2: Obra');
                 Gotoxy (47,14);
                 Writeln ('3: Volver al menu principal');

                 Repeat
                 textcolor (color);
                 Gotoxy (61,3);
                 Writeln(#168'Que desea modificar?');
                 x:=46;
                 y:=2;
                 For i:=1 to 16 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                      delay(5);
                 End;
                 x:=47;
                 y:=17;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2;
                      delay(5);
                 End;
                 x:=96;
                 y:=17;
                 For i:=1 to 16 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      y:=y-1;
                      delay(5);
                 End;
                 x:=95;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x-2;
                      delay(5);
                 End;
                 inc (color);
                 Until (keypressed = true);
                 control:=readkey;
                 case control of
                      '1': begin
                           textcolor(white);
                               repeat
                                     clrscr;
                                           writeln('Ingrese el codigo del museo que desea modificar: ');
                                           {$I-}
                                                readln(aux);
                                           {$I+}
                                           validacion:=ioresult();
                                           if validacion=0 then
                                              begin
                                                   busqueda_codigo_museo(arch_museo, nombre_m, aux, pos);
                                                   if pos>-1 then
                                                   begin
                                                        modificar_museo(arch_museo, arch_director ,nombre_m, nombre_d,pos);
                                                        menu_principal;
                                                   end
                                                      else
                                                          begin
                                                               writeln('El museo no esta registrado.. Presione cualquier tecla para continuar. ');
                                                               readkey;
                                                               menu_abmc;
                                                          end;
                                              end
                                                 else
                                                     begin
                                                          writeln('Debe ingresar solo numeros');
                                                          readkey;
                                                     end;
                                 until (pos>-1) and (validacion=0);
                          end;
                      '2': begin
                               textcolor(white);
                               repeat
                                     clrscr;
                                           writeln('Ingrese el codigo de la obra que desea modificar: ');
                                           {$I-}
                                                readln(aux);
                                           {$I+}
                                           validacion:=ioresult();
                                           if validacion=0 then
                                              begin
                                                   busqueda_codigo_obra(arch_obra, nombre_o, aux, pos);
                                                   if pos>-1 then
                                                   begin
                                                        modificar_obra(arch_obra,arch_artista,arch_museo,nombre_o,nombre_a,nombre_m,pos);
                                                        menu_principal;
                                                   end
                                                      else
                                                          begin
                                                               writeln('La obra no esta registrada.. Presione cualquier tecla para continuar. ');
                                                               readkey;
                                                               menu_abmc;
                                                          end;
                                              end
                                                 else
                                                     begin
                                                          writeln('Debe ingresar solo numeros');
                                                          readkey;
                                                     end;
                                 until (pos>-1) and (validacion=0);
                          end;
                      '3':Begin
                               clrscr;
                               menu_principal;
                          End;
                 else
                     clrscr;
                     textcolor (white);
                     Writeln ('El numero ingresado es erroneo');
                     Writeln ('Presione una tecla para continuar');
                     readkey;
                     clrscr;
                 End;
                 Until (control='1') or (control='2') or (control='3');
                 Readkey;
            End;

            Procedure menu_consultar;
            var
               x,y,i, color:integer;
               control:char;
            Begin
                 clrscr;
                 repeat
                 textcolor (white);
                 color:=1;
                 x:=46;
                 y:=2;
                 For i:=1 to 20 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 x:=96;
                 y:=2;
                 For i:=1 to 20 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                 End;
                 x:=47;
                 y:=21;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2
                 End;
                 Gotoxy (61,3);
                 Writeln(#168'Que desea consultar?');
                 Gotoxy (47,6);
                 Writeln ('1: Museo');
                 Gotoxy (47,10);
                 Writeln ('2: Obra');
                 Gotoxy (47,14);
                 Writeln ('3: Artista');
                 Gotoxy (47,18);
                 Writeln ('4: Volver al menu principal');

                 Repeat
                 textcolor (color);
                 Gotoxy (61,3);
                 Writeln(#168'Que desea consultar?');
                 x:=46;
                 y:=2;
                 For i:=1 to 20 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      inc (y);
                      delay(5);
                 End;
                 x:=47;
                 y:=21;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x+2;
                      delay(5);
                 End;
                 x:=96;
                 y:=21;
                 For i:=1 to 20 do
                 Begin
                      Gotoxy (x,y);
                      Writeln('|');
                      y:=y-1;
                      delay(5);
                 End;
                 x:=95;
                 y:=1;
                 For i:=1 to 25 do
                 Begin
                      Gotoxy (x,y);
                      Writeln ('_');
                      x:=x-2;
                      delay(5);
                 End;
                 inc (color);
                 Until (keypressed = true);
                 control:=readkey;
                 case control of
                      '1':begin
                               clrscr;
                               consulta_museo(arch_obra, arch_museo, arch_director, nombre_d, nombre_o, nombre_m);
                               menu_principal;
                          end;
                      '2':begin
                               clrscr;
                               consulta_obra(arch_obra,  arch_artista,arch_museo,nombre_o, nombre_m, nombre_a);
                               gotoxy(51,10);
                               textcolor(yellow);
                               writeln('Presione enter para salir.');
                               textcolor(white);
                               readkey;
                               menu_principal;
                          end;
                      '3':begin
                               clrscr;
                               consulta_artista(arch_obra,  arch_artista, nombre_o, nombre_a);
                               readkey;
                               menu_principal;
                          end;
                      '4':Begin
                               clrscr;
                               menu_principal;
                          End;
                 else
                     clrscr;
                     textcolor (white);
                     Writeln ('El numero ingresado es erroneo');
                     Writeln ('Presione una tecla para continuar');
                     readkey;
                     clrscr;
                 End;
                 Until (control='1') or (control='2') or (control='3') or (control='4');
                 Readkey;
            End;

            Procedure menu_estadistica;
            Begin
                 estadistica(arch_obra, arch_museo, nombre_o, nombre_m);
                 gotoxy(51,10);
                 textcolor(yellow);
                 writeln('Presione enter para salir.');
                 textcolor(white);
                 readkey;
                 menu_principal;
            End;

            procedure consulta_obra(var arch_o:t_obras;var arch_a:t_artistas;var arch_m:t_museos; nom_o:string; nom_m:string;nom_a:string);
            var
               reg_o:r_obras;
               reg_m:r_museos;
               reg_a:r_artistas;
               aux:string;
               pos,x,y,i:integer;
            begin
                 textcolor(white);
                 writeln('Ingrese nombre de la obra que desea consultar:');
                 Gotoxy (48,1);
                 readln(aux);
                 busqueda_nombre_obra(arch_o, nom_o, aux, pos);
                 if pos>-1 then
                    begin
                         clrscr;
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
                         leer_obra(arch_o, nom_o, pos, reg_o);
                         if reg_o.estado_obra then
                            begin
                                 gotoxy(60,2);
                                 writeln('Obra: ', aux);
                                 gotoxy(51,3);
                                 writeln('-------------------------------------');
                                 busqueda_dni_artista(arch_a, nom_a, reg_o.dni_artista, pos);
                                 if pos>-1 then
                                    begin
                                         leer_artista(arch_a, nom_a, pos, reg_a);
                                         if reg_a.estado_artista then
                                            begin
                                                 gotoxy(56,4);
                                                 writeln('Artista: ', reg_a.nombre_artista);
                                            end
                                                else
                                                    begin
                                                         textcolor(red);
                                                         gotoxy(56,4);
                                                         writeln('El artista esta dado de baja');
                                                         textcolor(white);
                                                    end;
                                    end;
                            end
                               else
                                   begin
                                        gotoxy(56,1);
                                        textcolor(red);
                                        writeln('La obra esta dada de baja');
                                        textcolor(white);
                                        readkey;
                                        menu_consultar;
                                   end;
                         busqueda_codigo_museo(arch_m, nom_m, reg_o.codigo_museo, pos);
                         if pos>-1 then
                            begin
                                 leer_museo(arch_m, nom_m, pos, reg_m);
                                 if reg_m.estado_museo then
                                    begin
                                         gotoxy(56,6);
                                         writeln('Museo: ', reg_m.nombre_mus);
                                    end
                                       else
                                           begin
                                                gotoxy(56,6);
                                                textcolor(red);
                                                writeln('El museo esta dado de baja.');
                                                textcolor(white);
                                                readkey;
                                                menu_consultar;
                                           end;
                            end
                               else
                                   writeln('El museo donde se encuentra la obra no esta registrado...');
                    end
                       else
                           begin
                                textcolor(red);
                                writeln('Esa obra no esta registrada. Presione cualquier tecla...');
                                textcolor(white);
                                readkey;
                                menu_consultar;
                           end;
            end;

            procedure consulta_museo(var arch_o:t_obras; var arch_m:t_museos;var arch_d:t_directores;nom_d:string ;nom_o:string; nom_m:string);
            var
               reg_m:r_museos;
               reg_d:r_directores;
               aux:string;
               pos:integer;
            begin
                 textcolor(white);
                 writeln('Ingrese el nombre del museo que desea consultar:');
                 gotoxy (50,1);
                 readln(aux);
                 clrscr;
                 busqueda_nombre_museo(arch_m, nom_m, aux, pos);
                 if pos>-1 then
                    begin
                         leer_museo(arch_m, nom_m, pos, reg_m);
                         if reg_m.estado_museo = false then
                            begin
                                 textcolor(red);
                                 writeln('El museo esta dado de baja.');
                                 textcolor(white);
                                 readkey;
                                 menu_consultar;
                            end
                               else
                                   begin
                                        gotoxy(63,2);
                                        writeln('Museo:', aux);
                                        gotoxy(53,3);
                                        writeln('------------------------------------------');
                                   end;
                         pos:=-1;
                         busqueda_dni_director(arch_d, nom_d, reg_m.dni_director, pos);
                         if pos>-1 then
                            begin
                                 leer_director(arch_d, nom_d, pos, reg_d);
                                 if reg_d.estado_director then
                                    begin
                                         gotoxy (61,4);
                                         writeln('El director es: ', reg_d.nombre_director);
                                         gotoxy(58,5);
                                         writeln('- - - - - - - - - - - - - - - ');
                                    end
                                       else
                                           begin
                                                gotoxy (61,4);
                                                textcolor(red);
                                                writeln('El director esta dado de baja.');
                                                textcolor(white);
                                           end;
                            end
                               else
                                   writeln('El director del museo no esta registrado...');
                           busqueda_consulta_museo(arch_o, nom_o, reg_m.codigo_mus, pos);
                           if pos=-1 then
                              begin
                                   gotoxy(55,6);
                                   textcolor (red);
                                   writeln('No hay ninguna obra registrada en este museo.');
                                   textcolor (white);
                              end;
                    end
                       else
                           begin
                                Textcolor (red);
                                gotoxy (55,3);
                                writeln('Este museo no esta registrado. Presione cualquier tecla...');
                                textcolor(white);
                                readkey;
                                menu_consultar;
                           end;
            end;

            procedure consulta_artista(var arch_o:t_obras; var arch_a:t_artistas ;nom_o:string; nom_a:string);
            var
               reg_a:r_artistas;
               aux:integer;
               pos:integer;
               validacion:integer;
            begin
                 textcolor(white);
                 repeat
                       writeln('Ingrese el DNI artista que desea consultar:');
                       {$I-}
                            Gotoxy(45,1);
                            readln(aux);
                       {$I+}
                       clrscr;
                       validacion:=ioresult();
                       if validacion<>0 then
                          begin
                               Textcolor(red);
                               writeln('Debe ingresar solo numeros');
                               textcolor(white);
                          end;
                 until validacion=0;
                 busqueda_dni_artista(arch_a, nom_a, aux, pos);
                 if pos>-1 then
                    begin
                         leer_artista(arch_a, nom_a, pos, reg_a);
                         if reg_a.estado_artista=false then
                            begin
                                 gotoxy(61,1);
                                 textcolor(red);
                                 writeln('El artista esta dado de baja');
                                 textcolor(white);
                                 textcolor(yellow);
                                 writeln('Presione enter para salir.');
                                 textcolor(white);
                                 readkey;
                                 menu_consultar;
                            end;
                         pos:=-1;
                         gotoxy(64,2);
                         writeln('Artista: ', reg_a.nombre_artista);
                         gotoxy(60,3);
                         writeln('------------------------------');
                         busqueda_consulta_artista(arch_o, nom_o, reg_a.dni_artista, pos);
                         if pos=-1 then
                                       Begin
                                            gotoxy(61,4);
                                            textcolor(red);
                                            writeln('No hay ninguna obra registrada con este artista.');
                                            textcolor(white);
                                       End;
                    end
                       else
                           Begin
                                textcolor (red);
                                writeln('Este artista no esta registrado. Presione cualquier tecla...');
                                Textcolor(white);
                                readkey;
                                menu_consultar;
                           End;
            end;

            procedure estadistica(var arch_o:t_obras; var arch_m:t_museos; nom_o:string; nom_m:string);
            var
               reg_m:r_museos;
               aux:integer;
               pos:integer;
            begin
                 textcolor(white);
                 writeln('Ingrese el codigo del museo: ');
                 readln(aux);
                 busqueda_codigo_museo(arch_m, nom_m, aux, pos);
                 if pos>-1 then
                    begin
                         leer_museo(arch_m, nom_m, pos, reg_m);
                         clrscr;
                         gotoxy(61,2);
                         writeln('Museo: ', reg_m.nombre_mus);
                         estadistica_museo(arch_o, nom_o, reg_m.codigo_mus, pos);
                    end
                       else
                           writeln('Este museo no existe.');
            end;

            begin
                nombre_o:='archivo_obra.dat';
                nombre_m:='archivo_museo.dat';
                nombre_d:='archivo_director.dat';
                nombre_a:='archivo_artista.dat';
            End.





