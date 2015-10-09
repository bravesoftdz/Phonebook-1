program Phonebook;
uses crt;
type inf=array[1..100] of string;
var name,phone,email,data:inf;
    save,fun,count:integer;

procedure open; {Use for write out a new phone book}
var outfile:text;
          begin
               assign(outfile,'.\int.txt');
               rewrite(outfile);
               close(outfile);
               writeln('Your phonebook is now ready to use.');
               writeln;
               writeln('Press <ENTER> to start the phone book.');
               readln;
          end;

procedure changeletter(var change:string); {Use for changing the data to capital letter}
var count:integer;
          begin
               for count:=1 to length(change) do
                   begin
                        if (change[count]>='a') and (change[count]<='z') then
                           change[count]:=chr(ord(change[count])-32);
                   end;
          end;

procedure writelist; {Use for write out the list}
var forloop:integer;
          begin
               for forloop:=1 to count do
                   writeln(forloop,': ',name[forloop],' ',phone[forloop],' ',email[forloop]);
          end;

procedure search(var searchname,searchingname:string;var middle:integer;var found:boolean);
{Use for search line of data}
var top,bottom:integer;
          begin
               found:=false;
               top:=1;
               bottom:=count;
               changeletter(searchname);
               repeat
                     middle:=(top+bottom)div 2;
                     searchingname:=name[middle];
                     changeletter(searchingname);
                     if searchname>searchingname then
                        top:=middle+1
                     else
                         if searchname<searchingname then
                            bottom:=middle-1
                         else
                             found:=true;
               until found or (top>bottom);
          end;

procedure arrange; {Use for arrange the data}
var readdata,hold:string;
    time,time2:integer;
          begin
               time:=0;
               time2:=1;
               readdata:=data[count]+' ';
               repeat
                     hold:='';
                     time:=time+1;
                     while readdata[time2]<>' ' do
                           begin
                                hold:=hold+readdata[time2];
                                time2:=time2+1;
                           end;
                     time2:=time2+1;
                     if time=1 then
                        name[count]:=hold;
                     if time=2 then
                        phone[count]:=hold;
                     if time=3 then
                        email[count]:=hold;
               until time=3;
               for time2:=1 to count do
                   for time:=1 to count do
                       begin
                            if name[time2]<name[time] then
                               begin
                                    hold:=name[time2];
                                    name[time2]:=name[time];
                                    name[time]:=hold;
                                    hold:=phone[time2];
                                    phone[time2]:=phone[time];
                                    phone[time]:=hold;
                                    hold:=email[time2];
                                    email[time2]:=email[time];
                                    email[time]:=hold;
                               end;
                       end;
          end;

procedure readRecord; {Use for read the old record}
var outfile:text;
          begin
               assign(outfile,'.\int.txt');
               reset(outfile);
               count:=0;
               while eof(outfile)=false do
                     begin
                          count:=count+1;
                          readln(outfile,data[count]);
                          arrange;
                     end;
               close(outfile);
          end;

procedure edit; {Use for edit the data}
var want:integer;
    want2,want3:string;
    anymore:char;
          begin
               repeat
                     writeln('Here is the contact list:');
                     writeln;
                     writelist;
                     writeln;
                     write('Which record you want to edit? ');
                     readln(want);
                     write('Which one you want to edit? ');
                     readln(want2);
                     write('What is the new data? ');
                     readln(want3);
                     writeln;
                     changeletter(want2);
                     if want2='NAME' then
                        name[want]:=want3;
                     if want2='PHONE' then
                        phone[want]:=want3;
                     if want2='EMAIL' then
                        email[want]:=want3;
                     write('Anymore you want to edit? (Y/N) ');
                     readln(anymore);
                     writeln;
               until (anymore='N') or (anymore='n');
               writeln('Press <ENTER> to go back.');
               readln;
          end;

procedure insert;  {Use for insert the new data}
var anymore:char;
          begin
               repeat
                     count:=count+1;
                     write('Enter the name, phone and email: ');
                     readln(data[count]);
                     arrange;
                     write('Anymore? (Y/N) ');
                     readln(anymore);
                     writeln;
               until (anymore='N') or (anymore='n');
               writeln('Press <ENTER> to go back.');
               readln;
               save:=0;
          end;

procedure list; {Use to list out the phone book}
          begin
               writeln('Here is the contact list:');
               writeln;
               writelist;
               writeln;
               writeln('Press <ENTER> to go back.');
               readln;
          end;

procedure delete; {Use for delete the data}
var want, i:integer;   {i is use for forloop}
    more:char;
          begin
               writeln('Here is the contact list:');
               writeln;
               writelist;
               writeln;
               repeat
                     write('Which record you want to delete? ');
                     readln(want);
                     writeln;
                     for i:=1 to count do
                         if i>=want then
                            begin
                                 name[i]:=name[i+1];
                                 phone[i]:=phone[i+1];
                                 email[i]:=email[i+1];
                            end;
                     count:=count-1;
                     writeln('Here is the updated contact list:');
                     writeln;
                     writelist;
                     writeln;
                     write('Anymore record to be deleted? (Y/N) ');
                     readln(more);
                     writeln;
               until (more='N') or (more='n');
               writeln('Press <ENTER> to go back.');
               readln;
               save:=0;
          end;

procedure searchRecord; {Use for search the data by name}
var searchname,searchingname:string;
    bingo:integer;
    found:boolean;
    anymore:char;
          begin
               repeat
                     write('Enter the name that you want to search: ');
                     readln(searchname);
                     search(searchname,searchingname,bingo,found);
                     writeln;
                     if found then
                        begin
                             writeln('Here is the information you required:');
                             writeln;
                             writeln('Name          Phone          Email');
                             writeln('=============================================');
                             for bingo:=1 to count do
                                 begin
                                      searchingname:=name[bingo];
                                      changeletter(searchingname);
                                      if searchingname=searchname then
                                         writeln(name[bingo],phone[bingo]:19,email[bingo]:23);
                                 end;
                        end
                     else
                         writeln('The record cannot be found!');
                     writeln;
                     write('Any more you want to search? (Y/N) ');
                     readln(anymore);
                     writeln;
               until (anymore='N') or (anymore='n');
               writeln('Press <ENTER> to go back.');
               readln;
          end;

procedure saveRecord; {Use for saving the data}
var outfile:text;
          begin
               assign(outfile,'G:\Pascal\int.txt');
               rewrite(outfile);
               for count:=1 to count do
                     begin
                          write(outfile,name[count],' ');
                          write(outfile,phone[count],' ');
                         writeln(outfile,email[count],' ');
                     end;
               close(outfile);
               writeln('Your data had been saved.');
               writeln;
               writeln('Press <ENTER> to go back.');
               readln;
               save:=1;
          end;

procedure exitProgram; {Use for exit the program}
var finish:char;
          begin
               if save=0 then
                  begin
                       write('Your data had not been saved, do you want to save it now? (Y/N)');
                       readln(finish);
                       if (finish='Y') or (finish='y') then
                          saveRecord;
                  end;
               clrscr;
               writeln('Thank you for using the phonebook!');
               writeln;
               writeln('Press <ENTER> to go back.');
               readln;
          end;
begin
     count:=0;
     save:=0;
     writeln('Welcome to our phone book!');
     writeln;
     writeln('1. Open a new phone book');
     writeln('2. Read the original phone book');
     write('Which function you want to use? ');
     readln(fun);
     clrscr;
     case fun of
          1:open;
          2:readRecord;
     end;
     repeat {Start to use the phonebook}
           clrscr;
           writeln('Welcome to our phonebook!');
           writeln('Number of contact = ',count);
           writeln;
           writeln('1. Add Contact');
           writeln('2. List Contact');
           writeln('3. Delete Contact');
           writeln('4. Search Contact');
           writeln('5. Edit Contact');
           writeln('6. Save Record');
           writeln('7. Exit');
           write('Which function you want to use? ');
           readln(fun);
           clrscr;
           case fun of
                1:insert;
                2:list;
                3:delete;
                4:searchRecord;
                5:edit;
                6:saveRecord;
                7:exitProgram;
           end;
     until fun=7;
end.
