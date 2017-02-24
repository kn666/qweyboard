package body Configuration is
   procedure Get_Settings (Config : out Settings) is
   begin
      if CLI.Argument_Count = 0 then
         null;
      elsif CLI.Argument_Count = 2 and (Get_Argument (1, Config.Layout_File_Name) or Get_Argument (1, Config.Timeout)) then
         null;
      elsif CLI.Argument_Count = 4 and Get_Argument (1, Config.Layout_File_Name) and Get_Argument (3, Config.Timeout) then
         null;
      elsif CLI.Argument_Count = 4 and Get_Argument (3, Config.Layout_File_Name) and Get_Argument (1, Config.Timeout) then
         null;
      else
         raise ARGUMENTS_ERROR; 
      end if;
   end Get_Settings;


   procedure Load_Layout (Config : in out Settings) is
      use Qweyboard;
   begin
      --  This is somewhat temporary. We want to load the layout from a file soon...
      Add_Key (Config.Layout, NOKEY, LZ, 'Z');
      Add_Key (Config.Layout, NOKEY, LF, 'F');
      Add_Key (Config.Layout, NOKEY, LS, 'S');
      Add_Key (Config.Layout, NOKEY, LP, 'P');
      Add_Key (Config.Layout, NOKEY, LT, 'T');
      Add_Key (Config.Layout, NOKEY, LC, 'C');
      Add_Key (Config.Layout, NOKEY, LK, 'K');
      Add_Key (Config.Layout, NOKEY, LJ, 'J');
      Add_Key (Config.Layout, NOKEY, LR, 'R');
      Add_Key (Config.Layout, NOKEY, LL, 'L');
      Add_Key (Config.Layout, NOKEY, LI, 'I');
      Add_Key (Config.Layout, NOKEY, LO, 'O');
      Add_Key (Config.Layout, NOKEY, LE, 'E');
      Add_Key (Config.Layout, NOKEY, LN, 'N');
      Add_Key (Config.Layout, NOKEY, MAPO, ''');
      Add_Key (Config.Layout, NOKEY, MU, 'U');
      Add_Key (Config.Layout, NOKEY, MA, 'A');
      Add_Key (Config.Layout, NOKEY, MY, 'Y');
      Add_Key (Config.Layout, NOKEY, RO, 'O');
      Add_Key (Config.Layout, NOKEY, RI, 'I');
      Add_Key (Config.Layout, NOKEY, RE, 'E');
      Add_Key (Config.Layout, NOKEY, RN, 'N');
      Add_Key (Config.Layout, NOKEY, RK, 'K');
      Add_Key (Config.Layout, NOKEY, RJ, 'J');
      Add_Key (Config.Layout, NOKEY, RR, 'R');
      Add_Key (Config.Layout, NOKEY, RL, 'L');
      Add_Key (Config.Layout, NOKEY, RP, 'P');
      Add_Key (Config.Layout, NOKEY, RT, 'T');
      Add_Key (Config.Layout, NOKEY, RC, 'C');
      Add_Key (Config.Layout, NOKEY, RF, 'F');
      Add_Key (Config.Layout, NOKEY, RS, 'S');
      Add_Key (Config.Layout, NOKEY, RZ, 'Z');
      Add_Key (Config.Layout, LJ, LP, 'B');
      Add_Key (Config.Layout, LJ, LT, 'D');
      Add_Key (Config.Layout, LJ, LC, 'G');
      Add_Key (Config.Layout, LJ, LL, 'H');
      Add_Key (Config.Layout, LJ, LN, 'W');
      Add_Key (Config.Layout, RJ, RN, 'W');
      Add_Key (Config.Layout, RJ, RL, 'H');
      Add_Key (Config.Layout, RJ, RP, 'B');
      Add_Key (Config.Layout, RJ, RT, 'D');
      Add_Key (Config.Layout, RJ, RC, 'G');
      Add_Key (Config.Layout, LR, LL, 'V');
      Add_Key (Config.Layout, LR, LN, 'M');
      Add_Key (Config.Layout, RR, RN, 'M');
      Add_Key (Config.Layout, RR, RL, 'V');
      Add_Key (Config.Layout, LC, LF, 'Q');
      Add_Key (Config.Layout, RC, RF, 'Q');
      Add_Key (Config.Layout, LK, LZ, 'X');
      Add_Key (Config.Layout, RK, RZ, 'X');
      Add_Key (Config.Layout, MSHI, LS, '$');
      Add_Key (Config.Layout, MSHI, LP, '%');
      Add_Key (Config.Layout, MSHI, LT, '/');
      Add_Key (Config.Layout, MSHI, LC, '(');
      Add_Key (Config.Layout, MSHI, LK, '&');
      Add_Key (Config.Layout, MSHI, LJ, '*');
      Add_Key (Config.Layout, MSHI, LR, '+');
      Add_Key (Config.Layout, MSHI, LI, '7');
      Add_Key (Config.Layout, MSHI, LO, '4');
      Add_Key (Config.Layout, MSHI, LE, '1');
      Add_Key (Config.Layout, MSHI, MAPO, '8');
      Add_Key (Config.Layout, MSHI, MU, '5');
      Add_Key (Config.Layout, MSHI, MA, '2');
      Add_Key (Config.Layout, MSHI, MY, '0');
      Add_Key (Config.Layout, MSHI, RO, '9');
      Add_Key (Config.Layout, MSHI, RI, '6');
      Add_Key (Config.Layout, MSHI, RE, '3');
      Add_Key (Config.Layout, MSHI, RK, '?');
      Add_Key (Config.Layout, MSHI, RJ, '=');
      Add_Key (Config.Layout, MSHI, RR, '-');
      Add_Key (Config.Layout, MSHI, RP, '!');
      Add_Key (Config.Layout, MSHI, RT, ';');
      Add_Key (Config.Layout, MSHI, RC, ')');
      Add_Key (Config.Layout, MSHI, RF, '"');
      Add_Key (Config.Layout, MSHI, RS, ':');
      
      if To_String (Config.Layout_File_Name) = "swedish.layout" then
         Add_Key (Config.Layout, NOKEY, LI, 'Å', Replace => True);
         Add_Key (Config.Layout, NOKEY, LO, 'Ä', Replace => True);
         Add_Key (Config.Layout, NOKEY, LE, 'Ö', Replace => True);
      end if;
   end;



   function Get_Argument (Count : Natural; Layout_File_Name : out Unbounded_String) return Boolean is
   begin
      if CLI.Argument (Count) /= "-l" then
         return False;
      end if;
      Layout_File_Name := To_Unbounded_String (CLI.Argument (Count + 1));
      return True;
   end Get_Argument;
   
   function Get_Argument (Count : Natural; Timeout : out Duration) return Boolean is
   begin
      if CLI.Argument (Count) /= "-t" then
         return False;
      end if;
      Timeout := Duration'Value (CLI.Argument (Count + 1));
      return True;
   exception
      when CONSTRAINT_ERROR =>
         return False;
   end Get_Argument;
end Configuration;