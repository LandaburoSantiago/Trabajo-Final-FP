unit vectores_obras;

interface
         uses crt,archivos_obras;
         const
              N=1000;

         type
             r_ordenar_obras = record
                                   campo:string;
                                   pos_archivo:integer;
                             end;
             v_obras=array[1..N] of r_ordenar_obras;
    procedure ordenar_nombre_obra(var arch:t_obras; nom_arch:string; var vec:v_obras);
    procedure listado_obras(var arch:t_obras ; nom_arch:string; v:v_obras);
    procedure inicializar_vector_obra(var v:v_obras);

implementation
    procedure inicializar_vector_obra(var v:v_obras);
    var
       i:integer;
       reg:r_ordenar_obras;
    begin
         reg.campo:='';
         reg.pos_archivo:=0;
         for i:=1 to N do
         begin
              v[i]:=reg;
         end;
    end;
    procedure ordenar_nombre_obra(var arch:t_obras; nom_arch:string; var vec:v_obras);
    var
       reg:r_obras;
       aux:r_ordenar_obras;
       pos:integer;
       i,j:integer;
       lim:integer;
    begin
         pos:=0;
         abrir_archivo_obra(arch, nom_arch);
         lim:=filesize(arch);
         close(arch);
         for i:=1 to lim do
             begin
                  leer_obra(arch, nom_arch, pos, reg);
                  with vec[i] do
                       begin
                            campo:=reg.nombre_obr;
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

    procedure listado_obras(var arch:t_obras ; nom_arch:string; v:v_obras);
              var
                 i:integer;
                 reg:r_obras;
                 lim,w:integer;
                 control:char;
                 y,j,x:integer;
              begin
                   w:=3; //w: variable para controlar la escritura del listado con gotoxy (valor de la y)
                   ordenar_nombre_obra(arch, nom_arch, v);
                   abrir_archivo_obra(arch, nom_arch);
                   lim:=filesize(arch);
                   close(arch);
                   gotoxy(54,1);
                   writeln('Listado de las obras ordenado por nombre de obra');
                   Gotoxy (1,2);
                   writeln ('|        Nombre        |  Codigo  |    DNI    |  Año  |    Descripcion    |     Material     |    Estilo    |  Tipo  | Altura(E) | Peso(E) | Completo(f) | Partes(f)');
                   Gotoxy (1,3);
                   Writeln ('____________________________________________________________________________________________________________________________________________________________________');
                   for i:=1 to lim do
                   begin
                        if (i mod 17)<> 0 then
                           begin
                                with v[i] do
                                     begin
                                          leer_obra(arch, nom_arch, pos_archivo, reg);
                                     end;
                                     if reg.estado_obra then
                                        begin
                                             Inc (w);
                                             Gotoxy (2,w);
                                             writeln(reg.nombre_obr);
                                             Gotoxy (25,w);
                                             writeln(reg.codigo_obr);
                                             Gotoxy (36,w);
                                             writeln(reg.dni_artista);
                                             Gotoxy (48,w);
                                             Writeln (reg.anio);
                                             Gotoxy (56,w);
                                             Writeln (reg.descr);
                                             Gotoxy (76,w);
                                             Writeln (reg.material);
                                             Gotoxy (95,w);
                                             Writeln (reg.estilo);
                                             Gotoxy (109,w);
                                             Writeln (reg.tipo);
                                             If (reg.tipo = 'Estatua')then
                                                begin
                                                     Gotoxy (119,w);
                                                     Writeln (reg.altura :2:2);
                                                     Gotoxy (131,w);
                                                     writeln (reg.peso:2:2);
                                                End;
                                                    If (reg.tipo='Fosil') then
                                                       Begin
                                                            if (reg.completo='Si') then
                                                            Begin
                                                                 Gotoxy (143,w);
                                                                 Writeln ('Si')
                                                            End
                                                            Else
                                                                Begin
                                                                     Gotoxy (143,w);
                                                                     Writeln ('No');
                                                                End;
                                                                Gotoxy (155,w);
                                                                Writeln (reg.can_partes);
                                                       End;
                                              inc (w);
                                              Gotoxy (1,w);
                                              Writeln ('____________________________________________________________________________________________________________________________________________________________________');
                                        end;
                           end
                              else
                                  begin
                                       with v[i] do
                                       begin
                                          leer_obra(arch, nom_arch, pos_archivo, reg);
                                       end;
                                       if reg.estado_obra then
                                          begin
                                               Inc (w);
                                               Gotoxy (2,w);
                                               writeln(reg.nombre_obr);
                                               Gotoxy (25,w);
                                               writeln(reg.codigo_obr);
                                               Gotoxy (36,w);
                                               writeln(reg.dni_artista);
                                               Gotoxy (48,w);
                                               Writeln (reg.anio);
                                               Gotoxy (56,w);
                                               Writeln (reg.descr);
                                               Gotoxy (76,w);
                                               Writeln (reg.material);
                                               Gotoxy (95,w);
                                               Writeln (reg.estilo);
                                               Gotoxy (109,w);
                                               Writeln (reg.tipo);
                                               If (reg.tipo = 'Estatua')then
                                                  begin
                                                       Gotoxy (119,w);
                                                       Writeln (reg.altura :2:2);
                                                       Gotoxy (131,w);
                                                       writeln (reg.peso:2:2);
                                                  End;
                                               If (reg.tipo='Fosil') then
                                                  Begin
                                                       if (reg.completo='Si') then
                                                          Begin
                                                               Gotoxy (143,w);
                                                               Writeln ('Si')
                                                          End
                                                             Else
                                                                 Begin
                                                                      Gotoxy (143,w);
                                                                      Writeln ('No');
                                                                 End;
                                                       Gotoxy (155,w);
                                                       writeln (reg.can_partes);
                                                  End;
                                              inc (w);
                                              Gotoxy (1,w);
                                              Writeln ('____________________________________________________________________________________________________________________________________________________________________');
                                          end;
                                       writeln('s: Siguiente; a: Volver al principio; ESC: salir');
                                       gotoxy(1,1);
                                       x:=wherex();
                                       repeat
                                             control:=readkey;
                                             keypressed;
                                             case control of
                                                  's':begin
                                                           y:=4; //y: variable utilizada para controlar el borrado de los datos en pantalla con gotoxy (valor de la y)
                                                           for j:=1 to 18 do
                                                               begin
                                                                    Gotoxy (1,y);
                                                                    writeln('                                                                                                                                                                       ');
                                                                    writeln('                                                                                                                                                                       ');
                                                                    y:=y+2;
                                                               end;
                                                           w:=3;
                                                      end;
                                                  'a':begin
                                                           y:=4;
                                                           for j:=1 to 18 do
                                                               begin
                                                                    Gotoxy (1,y);
                                                                    writeln('                                                                                                                                                                       ');
                                                                    writeln('                                                                                                                                                                       ');
                                                                    y:=y+2;
                                                               end;
                                                           w:=3;
                                                           i:=0;
                                                         end;
                                                  #27:begin
                                                           exit;
                                                      end;
                                                  #75:begin   //#37: Flecha hacia la izquierda

                                                           if x>5 then
                                                              begin
                                                                   x:=x-5;
                                                                   gotoxy(x,1);
                                                              end
                                                                 else
                                                                     if x>1 then
                                                                        begin
                                                                             x:=x-1;
                                                                             gotoxy(x,1);
                                                                        end;
                                                      end;
                                                  #77:begin   //#39: Flecha hacia la derecha
                                                           if (x>5) and (x<170) then
                                                              begin
                                                                   x:=x+5;
                                                                   gotoxy(x,1);
                                                              end
                                                                 else
                                                                     if (x>0) and (x<170)  then
                                                                        begin
                                                                             x:=x+1;
                                                                             gotoxy(x,1);
                                                                        end;
                                                      end;
                                             end;
                                    until (control='s') or (control='a') or (control=#27);
                               end;
                               if i=lim then
                                  begin
                                       writeln('a: Volver al principio; ESC: salir');
                                       gotoxy(1,1);
                                       x:=wherex();
                                       repeat
                                             control:=readkey;
                                             keypressed;
                                             case control of
                                               'a':begin
                                                        y:=4;
                                                        for j:=1 to 18 do
                                                            begin
                                                                 Gotoxy (1,y);
                                                                 writeln('                                                                                                                                                                       ');
                                                                 writeln('                                                                                                                                                                       ');
                                                                 y:=y+2;
                                                            end;
                                                        w:=3;
                                                        i:=0;
                                                   end;
                                               #27:begin
                                                        exit;
                                                   end;
                                               #75:begin   //#37: Flecha hacia la izquierda

                                                           if x>5 then
                                                              begin
                                                                   x:=x-5;
                                                                   gotoxy(x,1);
                                                              end
                                                                 else
                                                                     if x>1 then
                                                                        begin
                                                                             x:=x-1;
                                                                             gotoxy(x,1);
                                                                        end;
                                                      end;
                                                  #77:begin   //#39: Flecha hacia la derecha
                                                           if (x>5) and (x<170) then
                                                              begin
                                                                   x:=x+5;
                                                                   gotoxy(x,1);
                                                              end
                                                                 else
                                                                     if (x>0) and (x<170)  then
                                                                        begin
                                                                             x:=x+1;
                                                                             gotoxy(x,1);
                                                                        end;
                                                      end;
                                               end;
                                    until (control='a') or (control=#27);
                                  end;
                   end;
              end;


begin

end.
