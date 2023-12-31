unit Divergências;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Data.DB, Vcl.DBGrids, Datasnap.DBClient;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Button1: TButton;
    GridRetorno: TDBGrid;
    DSRetorno: TDataSource;
    CDS_Retorno: TClientDataSet;
    CDS_RetornoINDICE: TIntegerField;
    CDS_RetornoSTATUSPREFEITURA: TStringField;
    CDS_RetornoSTATUSDESBRAVADOR: TStringField;
    CDS_RetornoVALOR: TCurrencyField;
    CDS_RetornoEMISSAO: TDateField;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin

   form2.close;
end;

procedure TForm2.FormShow(Sender: TObject);
var
    Valor: currency;

begin
   Valor := 0.00;
   CDS_Retorno.First;
   while not CDS_Retorno.Eof do begin
      Valor := Valor+CDS_RetornoVALor.Value;
      CDS_Retorno.Next;
   end;
   StatusBar1.SimpleText := 'Total de Divergências: '+FloatToSTrf(Valor,ffCurrency,18,2);
end;

end.
