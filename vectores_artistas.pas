unit vectores_artistas;

interface
         uses crt,archivos_artistas;
         const
              N=1000;
         type
             r_ordenar_artistas = record
                                   campo:string;
                                   pos_archivo:integer;
                             end;
             v_artistas=array[1..N] of r_ordenar_artistas;
    procedure ordenar_nombre_artista(var arch:t_artistas; nom_arch:string; var vec:v_artistas);
    procedure listado_artista(var arch:t_artistas ; nom_arch:string; v:v_artistas);
    procedure inicializar_vector_artista(var v:v_artistas);
    procedure navegacion_artista(lim:integer);
implementation
    procedure inicializar_vector_artista(var v:v_artistas);
    var
       i:integer;
       reg:r_ordenar_artistas;
    begin
         reg.campo:='';
         reg.pos_archivo:=0;
         for i:=1 to N do
         begin
              v[i]:=reg;
         end;
    end;
    procedure navegacion_artista(lim:integer);
    var
       control:char;
       x,y:integer;
    begin
         x:=wherex();//Devuelve el valor actual de la x del cursor;
         y:=wherey();//Devuelve el valor actual de la y del cursor;
        //y:=y+1;
         gotoxy(x,y);
         lim:=lim+2;
         repeat
               control:=readkey;
               keypressed;
               case control of
                    #75:begin   //#37: Flecha hacia la izquierda
                             if x>5 then
                             begin
                                  x:=x-5;
                                  gotoxy(x,y);
                             end
                                else
                                    if x>1 then
                                       begin
                                            x:=x-1;
                                            gotoxy(x,y);
                                       end;
                        end;
                    #72:begin   //#38:Flecha hacia arriba
                             if y>5 then
                                begin
                                     y:=y-5;
                                     gotoxy(x,y);
                                end
                                   else
                                       if y>1 then
                                          begin
                                               y:=y-1;
                                               gotoxy(x,y);
                                          end;
                        end;
                    #77:begin   //#39: Flecha hacia la derecha
                             if (x>5) and (x<95) then
                                begin
                                     x:=x+5;
                                     gotoxy(x,y);
                                end
                                   else
                                       if (x>0) and (x<95)  then
                                          begin
                                               x:=x+1;
                                               gotoxy(x,y);
                                          end;
                        end;
                    #80:begin   //#40: Flecha hacia abajo
                             if (y>5) and (y<lim) then
                                begin
                                     y:=y+5;
                                     gotoxy(x,y);
                                end
                                   else
                                       if (y>0) and (y<lim) then
                                          begin
                                               y:=y+1;
                                               gotoxy(x,y);
                                          end;
                        end;
                end;
         until control=#27;
    end;
    procedure ordenar_nombre_artista(var arch:t_artistas; nom_arch:string; var vec:v_artistas);
    var
       reg:r_artistas;
       aux:r_ordenar_artistas;
       pos:integer;
       i,j:integer;
       lim:integer;
    begin
         pos:=0;
         abrir_archivo_artista(arch, nom_arch);
         lim:=filesize(arch);
         close(arch);
         for i:=1 to lim do
             begin
                  leer_artista(arch, nom_arch, pos, reg);
                  with vec[i] do
                       begin
                            campo:=reg.nombre_artista;
                            pos_archivo:=pos;
                       end;
                  inc(pos);
             end;

         for i:=1 to lim-1 do
             begin
                  for j:=1 to lim-i do
                      begin
                           if vec[j].campo > vec[j+1].campo then
                              begin
                                   aux:=vec[j];
                                   vec[j]:=vec[j+1];
                                   vec[j+1]:=aux;
                              end;
                      end;
             end;
    end;

    procedure listado_artista(var arch:t_artistas ; nom_arch:string; v:v_artistas);
              var
                 i:integer;
                 reg:r_artistas;
                 lim,w:integer;
                 control:char;
                 j,y:integer;
              begin
                   w:=3;
                   ordenar_nombre_artista(arch, nom_arch, v);
                   abrir_archivo_artista(arch, nom_arch);
                   lim:=filesize(arch);
                   close(arch);
                   gotoxy(21,1);
                   writeln('Listado de los artistas ordenado por nombre de artista');
                   Gotoxy (1,2);
                   writeln ('| Nombre del artista |     Direccion     |      Ciudad      |      Pais      |      DNI      ');
                   Gotoxy (1,3);
                   Writeln ('_____________________________________________________________________________________________');
                   for i:=1 to lim do
                   begin
                        if (i mod 17)<>0 then
                        begin
                             with v[i] do
                                  begin
                                       leer_artista(arch, nom_arch, pos_archivo, reg);
                                  end;
                                  if (reg.estado_artista) then;
                                     begin
                                          Inc (w);
                                          Gotoxy (2,w);
                                          writeln(reg.nombre_artista);
                                          Gotoxy (23,w);
                                          writeln(reg.direccion_artista);
                                          Gotoxy (43,w);
                                          writeln(reg.ciudad_artista);
                                          Gotoxy (62,w);
                                          writeln(reg.pais_artista);
                                          Gotoxy (79,w);
                                          writeln(reg.dni_artista);
                                          Inc (w);
                                          Gotoxy (1,w);
                                          Writeln ('_____________________________________________________________________________________________');
                                     end;
                        end
                           else
                               begin
                                    with v[i] do
                                         begin
                                              leer_artista(arch, nom_arch, pos_archivo, reg);
                                         end;
                                         if (reg.estado_artista) then;
                                            begin
                                                 Inc (w);
                                                 Gotoxy (2,w);
                                                 writeln(reg.nombre_artista);
                                                 Gotoxy (23,w);
                                                 writeln(reg.direccion_artista);
                                                 Gotoxy (43,w);
                                                 writeln(reg.ciudad_artista);
                                                 Gotoxy (62,w);
                                                 writeln(reg.pais_artista);
                                                 Gotoxy (79,w);
                                                 writeln(reg.dni_artista);
                                                 Inc (w);
                                                 Gotoxy (1,w);
                                                 Writeln ('_____________________________________________________________________________________________');
                                            end;
                                    writeln('s: Siguiente; a: Volver al principio; ESC: salir');
                                    gotoxy(1,1);
                                    repeat
                                          control:=readkey;
                                          keypressed;
                                          case control of
                                               's':begin
                                                        y:=4;
                                                        for j:=1 to 18 do
                                                            begin
                                                                 Gotoxy (1,y);
                                                                 writeln('                                                                                                               ');
                                                                 writeln('                                                                                                               ');
                                                                 y:=y+2;
                                                            end;
                                                        w:=3;
                                                   end;
                                               'a':begin
                                                        y:=4;
                                                        for j:=1 to 18 do
                                                            begin
                                                                 Gotoxy (1,y);
                                                                 writeln('                                                                                                               ');
                                                                 writeln('                                                                                                               ');
                                                                 y:=y+2;
                                                            end;
                                                        w:=3;
                                                        i:=0;
                                                   end;
                                               #27:begin
                                                        exit;
                                                   end;
                                               end;
                                    until (control='s') or (control='a') or (control=#27);
                               end;
                               if i=lim then
                                  begin
                                       writeln('a: Volver al principio; ESC: salir');
                                       gotoxy(1,1);
                                       repeat
                                             control:=readkey;
                                             keypressed;
                                             case control of
                                               'a':begin
                                                        y:=4;
                                                        for j:=1 to 18 do
                                                            begin
                                                                 Gotoxy (1,y);
                                                                 writeln('                                                                                                               ');
                                                                 writeln('                                                                                                               ');
                                                                 y:=y+2;
                                                            end;
                                                        w:=3;
                                                        i:=0;
                                                   end;
                                               #27:begin
                                                        exit;
                                                   end;
                                               end;
                                    until (control='a') or (control=#27);
                                  end;
                   end;
                      //writeln('Presione ESC para salir.');
                      //navegacion_artista(w);
              end;
begin

end.
