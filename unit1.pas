unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Windows, Messages, Classes, SysUtils, FileUtil, Forms, Controls, Graphics,
  Dialogs, ComCtrls, Menus, maskedit, StdCtrls, ExtCtrls, types, ActnList,
  Variants, LCLType;

  // this is a test, for svn check-in
  
type

  { TForm1 }

  TForm1 = class(TForm)
    FindDialog1: TFindDialog;
    MainMenu: TMainMenu;
    Memo1: TMemo;
    MenuItem1: TMenuItem;
    SaveAs: TMenuItem;
    OpenDialog1: TOpenDialog;
    Save: TMenuItem;
    Open: TMenuItem;
    Time: TMenuItem;
    SelectAll: TMenuItem;
    GTo: TMenuItem;
    Replace: TMenuItem;
    FindNext: TMenuItem;
    Find: TMenuItem;
    Del: TMenuItem;
    MenuItem2: TMenuItem;
    Paste: TMenuItem;
    Cpy: TMenuItem;
    Cut: TMenuItem;
    ReplaceDialog1: TReplaceDialog;
    SaveDialog1: TSaveDialog;
    StatusBar1: TStatusBar;
    WordWrap: TMenuItem;
    StatusBar: TMenuItem;
    Help: TMenuItem;
    About: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    Nw: TMenuItem;
    Quit: TMenuItem;
    Undo: TMenuItem;
    procedure ApplicationProperties1Activate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Memo1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure QuitClick(Sender: TObject);
    procedure TimeClick(Sender: TObject);
    procedure SelectAllClick(Sender: TObject);
    procedure SaveAsClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure OpenClick(Sender: TObject);
    procedure DelClick(Sender: TObject);
    procedure FindClick(Sender: TObject);
    procedure GToClick(Sender: TObject);
    procedure ReplaceClick(Sender: TObject);
    procedure FindNextClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure CutClick(Sender: TObject);
    procedure CpyClick(Sender: TObject);
    procedure AboutClick(Sender: TObject);
    procedure ReplaceDialog1Replace(Sender: TObject);
    procedure StatusBarClick(Sender: TObject);
    procedure PasteClick(Sender: TObject);
    procedure UndoClick(Sender: TObject);
    procedure WordWrapClick(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure NwClick(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure OpenSave(Sender:TObject);
    procedure NewSave(Sender:TObject);
  private
    { private declarations }
    procedure SetFileName(AValue:String);
  private
    FFileName:String;
    property FileName:String read FFileName write SetFileName;
  public
    { public declarations }
    FSelPos: integer;
    SavedAs: integer;
    Saved: integer;
    myString: String;
    FindText: String;
    index: Integer;


  end;

var
  Form1: TForm1;

implementation
{$R *.lfm}
uses Unit2;

{ TForm1 }
procedure TForm1.SetFileName(AValue:String);
begin
  FFileName := AValue;
  if FFileName = '' then
  begin
    Form1.Caption:= 'Untitled - MyNotepad';
  end
  else
    Form1.Caption:= extractfilename(FFileName) + ' - MyNotepad';
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F4) and (ssAlt in Shift) then
  begin
  Key := 0;
  QuitClick(Self);
  end;
end;

procedure TForm1.OpenSave(Sender:TObject);
begin
  OpenDialog1.FileName:='';
  if OpenDialog1.Execute then
          begin
            Form1.FileName := OpenDialog1.FileName;
            Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
            Memo1.SelStart := 0;
            Memo1.Modified:= False;
          end;
end;

procedure TForm1.NewSave(Sender:TObject);
begin
  Memo1.Clear;
  Form1.FileName := '';
  Memo1.Modified := False;
end;

procedure TForm1.ApplicationProperties1Activate(Sender: TObject);
begin

end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9']) then
  begin
    ShowMessage('You can only type a number here');
    Key := #0;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
if Memo1.Modified = True then
  begin
    CloseAction:=caNone;
    case MessageBox(0,'Do you want to save changes?','Notepad',
    +MB_YESNOCANCEL) of
    IDYES:
      begin
        SaveClick(Self);
        if Memo1.Modified = False then
          Application.Terminate;
      end;
    IDNO:
      begin
        Application.Terminate;
      end;
    end;
  end
else
  begin
    Application.Terminate;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Modified:= False;
 with OpenDialog1 do
 begin
  Options:=Options+[ofPathMustExist,ofFileMustExist];
  InitialDir:=ExtractFilePath(Application.ExeName);
  Filter:='Text files (*.txt)|*.txt';
 end;
 with SaveDialog1 do
 begin
  InitialDir:=ExtractFilePath(Application.ExeName);
  Filter:='Text files (*.txt)|*.txt';
 end;
 Memo1.ScrollBars := ssBoth;
end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Label2Click(Sender: TObject);
begin
  ShellExecute(self.WindowHandle,'open','http://windows.microsoft.com/en-ca/windows/notepad-faq',nil,nil, SW_SHOWNORMAL);
end;

procedure TForm1.Label3Click(Sender: TObject);
begin

end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := ('Ln ' + IntToStr(Memo1.CaretPos.Y + 1) +
  ', Col ' + IntToStr(Memo1.CaretPos.X + 1) + '      ');
end;

procedure TForm1.Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
    StatusBar1.Panels[0].Text := ('Ln ' + IntToStr(Memo1.CaretPos.Y + 1) +
  ', Col ' + IntToStr(Memo1.CaretPos.X + 1) + '      ');       //ARROW KEY BUG
end;

procedure TForm1.Memo1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  StatusBar1.Panels[0].Text := ('Ln ' + IntToStr(Memo1.CaretPos.Y + 1) +
', Col ' + IntToStr(Memo1.CaretPos.X + 1) + '      ');
end;

procedure TForm1.QuitClick(Sender: TObject);
begin
if Memo1.Modified = True then
  begin
    case MessageBox(0,'Do you want to save changes?','Notepad',
    +MB_YESNOCANCEL) of
    IDYES:
      begin
        SaveClick(Self);
        if Memo1.Modified = False then
          Application.Terminate;
      end;
    IDNO:
      begin
        Application.Terminate;
      end;
    end;
  end
else
  begin
    Application.Terminate;
  end;
end;

procedure TForm1.TimeClick(Sender: TObject);
begin
  Memo1.SelText := TimeToStr(Now) + ' ' + DateToStr(Now);
end;

procedure TForm1.SelectAllClick(Sender: TObject);
begin
  Memo1.SelectAll;
end;

procedure TForm1.SaveAsClick(Sender: TObject);
begin
  if Form1.FileName = '' then
    SaveDialog1.FileName:= 'Untitled'
  else
    SaveDialog1.FileName:= extractfilename(Form1.FileName);
  if SaveDialog1.Execute then
  begin
    Memo1.Lines.SaveToFile(SaveDialog1.FileName);
    Form1.FileName:=SaveDialog1.FileName;
    Memo1.Modified:= False;
  end;
end;

procedure TForm1.SaveClick(Sender: TObject);
begin
  if Form1.FileName = '' then
  begin
    SaveAsClick(self);
  end
  else
    begin
      Memo1.Lines.SaveToFile(Form1.FileName);
      Memo1.Modified:=False;
    end;
end;

procedure TForm1.OpenClick(Sender: TObject);
begin
  if Memo1.Modified= True then
    begin
      case MessageBox(0,'Do you want to save changes?','Notepad',
      +MB_YESNOCANCEL) of
      IDYES:
        begin
          SaveClick(Self);
          if Memo1.Modified=False then
            OpenSave(Self);
        end;
      IDNO:
        begin
          OpenSave(Self);
        end;
      end;
    end
  else
    begin
      OpenSave(Self);
    end;
end;

procedure TForm1.DelClick(Sender: TObject);
begin
    Memo1.ClearSelection;
end;

procedure TForm1.FindDialog1Find(Sender : TObject);
var
  S : string;
  startpos : integer;
begin
  FindDialog1.Tag := 1;
  with TFindDialog(Sender) do
  begin
    if FSelPos = 0 then
      Options := Options - [frFindNext];
    if frfindNext in Options then
    begin
      StartPos := FSelPos + Length(Findtext);
      S := Copy(Memo1.Lines.Text, StartPos, MaxInt);
    end
    else
    begin
      S := Memo1.Lines.Text;
      StartPos := 1;
    end;
    FSelPos := Pos(FindText, S);
    if FSelPos > 0 then
    begin
      FSelPos := FSelPos + StartPos - 1;
      Memo1.SelStart := FSelPos - 1;
      Memo1.SelLength := Length(FindText);
      Memo1.SetFocus;
    end
    else
    begin
      if frfindNext in Options then
        S := Concat('There are no further occurences of "', FindText,
          '"')
      else
        S := Concat('Could not find "', FindText, '"');
      MessageDlg(S, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TForm1.FindClick(Sender: TObject);
begin
    FSelPos := 0;
    FindDialog1.Execute;
end;

procedure TForm1.GToClick(Sender: TObject);
begin
    Form2.Visible:=True;
end;

procedure TForm1.ReplaceDialog1Replace(Sender : TObject);
var
  S : string;
  startpos : integer;
begin
  with TReplaceDialog(Sender) do
  begin
    if FSelPos = 0 then
      Options := Options - [frFindNext];
    if frfindNext in Options then
    begin
      StartPos := FSelPos + Length(Findtext);
      S := Copy(Memo1.Lines.Text, StartPos, MaxInt);
    end
    else
    begin
      S := Memo1.Lines.Text;
      StartPos := 1;
    end;
    FSelPos := Pos(FindText, S);
    if FSelPos > 0 then
    begin
      FSelPos := FSelPos + StartPos - 1;
      Memo1.SelStart := FSelPos - 1;
      Memo1.SelLength := Length(FindText);
      Memo1.SetFocus;
      Memo1.SelText := ReplaceText
    end
    else
    begin
      if frfindNext in Options then
        S := Concat('There are no further occurences of "', FindText,
          '"')
      else
        S := Concat('Could not find "', FindText, '"');
      MessageDlg(S, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TForm1.ReplaceClick(Sender: TObject);
begin
    FSelPos := 0;
    ReplaceDialog1.Execute;
end;

procedure TForm1.FindNextClick(Sender: TObject);
var
  S : string;
  startpos : integer;
begin
  if FindDialog1.Tag = 0 then
  FindDialog1.Execute
  else
  begin
  StartPos := FSelPos + Length(FindDialog1.Findtext);
  S := Copy(Memo1.Lines.Text, StartPos, MaxInt);
  FSelPos := Pos(FindDialog1.FindText, S);
  if FSelPos > 0 then
    begin
      FSelPos := FSelPos + StartPos - 1;
      Memo1.SelStart := FSelPos - 1;
      Memo1.SelLength := Length(FindDialog1.FindText);
      Memo1.SetFocus;
    end
    else
    begin
        S := Concat('There are no further occurences of "', FindDialog1.FindText,
          '"');
      MessageDlg(S, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

procedure TForm1.CutClick(Sender: TObject);
begin
   Memo1.CuttoClipBoard;
end;

procedure TForm1.CpyClick(Sender: TObject);
begin
    Memo1.CopytoClipBoard;
end;

procedure TForm1.AboutClick(Sender: TObject);
begin
  MessageBox(0, 'Notepad Version 1.3'+#13#10+'by Alex Zhang', 'About Notepad', MB_OK);
end;

procedure TForm1.StatusBarClick(Sender: TObject);
begin
    StatusBar1.Visible:= not(StatusBar1.Visible);
end;

procedure TForm1.PasteClick(Sender: TObject);
begin
    Memo1.PasteFromClipboard;
end;

procedure TForm1.UndoClick(Sender: TObject);
begin
    Memo1.Undo;
end;

procedure TForm1.WordWrapClick(Sender: TObject);
begin
    Memo1.WordWrap:= not(Memo1.WordWrap);
end;

procedure TForm1.HelpClick(Sender: TObject);
begin
  case MessageBox(0, 'http://windows.microsoft.com/en-ca/windows/notepad-faq',
  'Please Visit', +MB_OKCANCEL) of
  IDOK:
    begin
      ShellExecute(self.WindowHandle,'open',
      'http://windows.microsoft.com/en-ca/windows/notepad-faq'
      ,nil,nil, SW_SHOWNORMAL);
    end;
  end;
end;

procedure TForm1.NwClick(Sender: TObject);
begin
  if Memo1.Modified = True then
    begin
      case MessageBox(0,'Do you want to save changes?','Notepad',
      +MB_YESNOCANCEL) of
      IDYES:
        begin
          SaveClick(Self);
          if Memo1.Modified= False then
          NewSave(Self);
        end;
      IDNO:
        begin
          NewSave(Self);
        end;
      end;
    end
  else
  begin
      NewSave(Self);
  end;
end;

end.

