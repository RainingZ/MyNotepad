unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;

implementation
uses Unit1;

{$R *.lfm}

{ TForm2 }

procedure TForm2.Button1Click(Sender: TObject);
begin
  Form1.Memo1.CaretPos := Point(0, (StrToInt(Edit1.Text)-1));
  Form1.StatusBar1.Panels[0].Text := ('Ln ' + Edit1.Text +
  ', Col 1' + '      ');
  Form2.Visible := False;
  Edit1.Clear;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Form2.Visible:=False;
  Edit1.Clear;
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if not (Key in ['0'..'9']) then
  begin
    ShowMessage('You can only type a number here');
    Key := #0;
  end;
end;

end.

