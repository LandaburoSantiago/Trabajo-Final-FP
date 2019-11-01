unit vectores_museos;
interface
         uses crt,archivos_museos;
         const
              N=1000;
         type
             r_ordenar_museos = record
                                   campo:string;
                                   pos_archivo:integer;
                             end;
             v_museos=array[1..N] of r_ordenar_museos;
    procedure ordenar_nombre_museo(var arch:t_museos; nom_arch:string; var vec:v_museos);
    procedure listado_museo(var arch:t_museos ; nom_arch:string; v:v_museos);
    procedure inicializar_vector_museo(var v:v_museos);
    procedure navegacion_museo(lim:integer);

implementation
    procedure inicializar_vector_museo(var v:v_museos);
    var
       i:integer;
       reg:r_ordenar_museos;
    begin
         reg.campo:='';
         reg.pos_archivo:=0;
         for i:=1 to N do
         begin
              v[i]:=reg;
         end;
    end;
    procedure navegacion_museo(lim:integer);
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
                             if (x>5) and (x<112) then
                                begin
                                     x:=x+5;
                                     gotoxy(x,y);
                                end
                                   else
                                       if (x>0) and (x<112) then
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
    procedure ordenar_nombre_museo(var arch:t_museos; nom_arch:string; var vec:v_museos);
    var
       reg:r_museos;
       aux:r_ordenar_museos;
       pos:integer;
       i,j:integer;
       lim:integer;
    begin
         pos:=0;
         abrir_archivo_museo(arch, nom_arch);
         lim:=filesize(arch);
         close(arch);
         for i:=1 to lim do
             begin
                  leer_museo(arch, nom_arch, pos, reg);
                  with vec[i] do
                       begin
                            campo:=reg.nombre_mus;
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

    procedure listado_museo(var arch:t_museos ; nom_arch:string; v:v_museos);
              var
                 i:integer;
                 reg:r_museos;
                 lim,w:integer;
                 control:char;
                 j,y:integer;
              begin
                   w:=3;
                   ordenar_nombre_museo(arch, nom_arch, v);
                   abrir_archivo_museo(arch, nom_arch);
                   lim:=filesize(arch);
                   close(arch);
                   gotoxy(36,1);
                   writeln('Listado de los museos ordenado por nombre de museo');
                   Gotoxy (1,2);
                   Writeln ('|    Nombre del museo    |  Codigo  |       Pais      |         Ciudad         |    Direccion    |  Telefono  | DNI del director |');
                   Gotoxy (1,3);
                   Writeln ('__________________________________________________________________________________________________________________________________');
                   for i:=1 to lim do
                   begin
                        if (i mod 17)<>0 then
                           begin
                                with v[i] do
                                     begin
                                          leer_museo(arch, nom_arch, pos_archivo, reg);
                                     end;
                                if (reg.estado_museo) then
                                   begin
                                        Inc (w);
                                        Gotoxy (2,w);
                                        writeln(reg.nombre_mus);
                                        Gotoxy (27,w);
                                        writeln(reg.codigo_mus);
                                        Gotoxy (38,w);
                                        Writeln (reg.pais);
                                        Gotoxy (58,w);
                                        Writeln (reg.ciudad);
                                        Gotoxy (83,w);
                                        writeln(reg.direccion);
                                        Gotoxy (101,w);
                                        Writeln (reg.telefono);
                                        Gotoxy (114,w);
                                        writeln (reg.dni_director);
                                        Inc (w);
                                        Gotoxy (1,w);
                                        Writeln ('__________________________________________________________________________________________________________________________________');
                                   end;
                              end
                                 else
                                     begin
                                          with v[i] do
                                               begin
                                                    leer_museo(arch, nom_arch, pos_archivo, reg);
                                               end;
                                          if (reg.estado_museo) then
                                             begin
                                                  Inc (w);
                                                  Gotoxy (2,w);
                                                  writeln(reg.nombre_mus);
                                                  Gotoxy (27,w);
                                                  writeln(reg.codigo_mus);
                                                  Gotoxy (38,w);
                                                  Writeln (reg.pais);
                                                  Gotoxy (58,w);
                                                  Writeln (reg.ciudad);
                                                  Gotoxy (83,w);
                                                  writeln(reg.direccion);
                                                  Gotoxy (101,w);
                                                  Writeln (reg.telefono);
                                                  Gotoxy (114,w);
                                                  writeln (reg.dni_director);
                                                  Inc (w);
                                                  Gotoxy (1,w);
                                                  Writeln ('__________________________________________________________________________________________________________________________________');
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
                                                                       writeln('                                                                                                                                                   ');
                                                                       writeln('                                                                                                                                                   ');
                                                                       y:=y+2;
                                                                  end;
                                                              w:=3;
                                                         end;
                                               'a':begin
                                                        y:=4;
                                                        for j:=1 to 18 do
                                                            begin
                                                                 Gotoxy (1,y);
                                                                 writeln('                                                                                                                                                   ');
                                                                 writeln('                                                                                                                                                   ');
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
                                                                 writeln('                                                                                                                                                   ');
                                                                 writeln('                                                                                                                                                   ');
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

              end;


begin

end.
