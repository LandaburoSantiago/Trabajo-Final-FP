unit vectores_directores;

interface
         uses crt, archivos_directores;
         const
              N=1000;
         type
             r_ordenar_directores = record
                                   campo:string;
                                   pos_archivo:integer;
                             end;
             v_directores=array[1..N] of r_ordenar_directores;
    procedure ordenar_nombre_director(var arch:t_directores; nom_arch:string; var vec:v_directores);
    procedure listado_director(var arch:t_directores ; nom_arch:string; v:v_directores);
    procedure inicializar_vector_director(var v:v_directores);

implementation
    procedure inicializar_vector_director(var v:v_directores);
    var
       i:integer;
       reg:r_ordenar_directores;
    begin
         reg.campo:='';
         reg.pos_archivo:=0;
         for i:=1 to N do
         begin
              v[i]:=reg;
         end;
    end;
    procedure ordenar_nombre_director(var arch:t_directores; nom_arch:string; var vec:v_directores);
    var
       reg:r_directores;
       aux:r_ordenar_directores;
       pos:integer;
       i,j:integer;
       lim:integer;
    begin
         pos:=0;
         abrir_archivo_director(arch, nom_arch);
         lim:=filesize(arch);
         close(arch);
         for i:=1 to lim do
             begin
                  leer_director(arch, nom_arch, pos, reg);
                  with vec[i] do
                       begin
                            campo:=reg.nombre_director;
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

    procedure listado_director(var arch:t_directores ; nom_arch:string; v:v_directores);
              var
                 i:integer;
                 reg:r_directores;
                 lim,w:integer;
                 control:char;
                 j,y:integer;
              begin
                   w:=3;
                   ordenar_nombre_director(arch, nom_arch, v);
                   abrir_archivo_director(arch, nom_arch);
                   lim:=filesize(arch);
                   close(arch);
                   gotoxy(22,1);
                   writeln ('Listado de los directores ordenado por nombre de director');
                   Gotoxy (1,2);
                   writeln ('| Nombre del Director |      Direccion      |     DNI     |     Telefono     | Periodo en años |');
                   Gotoxy (1,3);
                   Writeln ('________________________________________________________________________________________________');
                   for i:=1 to lim do
                   begin
                        if (i mod 17)<>0 then
                           begin
                                with v[i] do
                                     begin
                                          leer_director(arch, nom_arch, pos_archivo, reg);
                                     end;
                                if (reg.estado_director) then
                                   begin
                                        Inc (w);
                                        Gotoxy (2,w);
                                        writeln (reg.nombre_director);
                                        Gotoxy (24,w);
                                        writeln (reg.direccion_director);
                                        Gotoxy (46,w);
                                        Writeln (reg.dni_director);
                                        Gotoxy (60,w);
                                        Writeln (reg.telefono_director);
                                        Gotoxy (79,w);
                                        writeln (reg.periodo_director);
                                        Inc (w);
                                        Gotoxy (1,w);
                                        Writeln ('________________________________________________________________________________________________');
                                   end;
                           end
                              else
                                  begin
                                       with v[i] do
                                            begin
                                                 leer_director(arch, nom_arch, pos_archivo, reg);
                                            end;
                                       if (reg.estado_director) then
                                          begin
                                               Inc (w);
                                               Gotoxy (2,w);
                                               writeln (reg.nombre_director);
                                               Gotoxy (24,w);
                                               writeln (reg.direccion_director);
                                               Gotoxy (46,w);
                                               Writeln (reg.dni_director);
                                               Gotoxy (60,w);
                                               Writeln (reg.telefono_director);
                                               Gotoxy (79,w);
                                               writeln (reg.periodo_director);
                                               Inc (w);
                                               Gotoxy (1,w);
                                               Writeln ('________________________________________________________________________________________________');
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
                                                                 writeln('                                                                                                                ');
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
                   writeln('Presione ESC para salir.');
                   gotoxy(1,1);

              end;


begin

end.
