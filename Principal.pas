unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Menus, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Diverg�ncias,
  Datasnap.DBClient;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    PM_SIGISS: TPopupMenu;
    SelecionarCSV1: TMenuItem;
    ImportarDados1: TMenuItem;
    LimparTabela1: TMenuItem;
    DS_SIGISS: TDataSource;
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    OpenDialog1: TOpenDialog;
    Panel2: TPanel;
    DBGrid2: TDBGrid;
    PM_DAH: TPopupMenu;
    DS_DAH: TDataSource;
    SelecionarCSV2: TMenuItem;
    ImportarDados2: TMenuItem;
    LimparTabela2: TMenuItem;
    Edit2: TEdit;
    StatusBar1: TStatusBar;
    StatusBar2: TStatusBar;
    Label2: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    SIGISS: TClientDataSet;
    DAH: TClientDataSet;
    SIGISSDIA: TIntegerField;
    SIGISSNUMERO: TIntegerField;
    SIGISSSERIE: TIntegerField;
    SIGISSTIPO: TStringField;
    SIGISSSITUACAO: TStringField;
    SIGISSCODIGO: TIntegerField;
    SIGISSVALOR: TCurrencyField;
    SIGISSBASE: TCurrencyField;
    SIGISSISS: TCurrencyField;
    SIGISSTOMADOR: TStringField;
    SIGISSLANCAMENTO: TStringField;
    SIGISSESCRITURACAO: TDateTimeField;
    DAHSERIE: TIntegerField;
    DAHEMISSAO: TDateField;
    DAHRPS: TIntegerField;
    DAHDOCUMENTO: TIntegerField;
    DAHVALOR: TCurrencyField;
    DAHBASE: TCurrencyField;
    DAHVALORISS: TCurrencyField;
    DAHISENTOS: TCurrencyField;
    DAHOUTROS: TCurrencyField;
    DAHOBSERVACAO: TStringField;
    SIGISSCNPJ: TStringField;
    SIGISSALIQUOTA: TIntegerField;
    DAHALIQUOTA: TIntegerField;
    Label1: TLabel;
    EditTotalNotasSIGISS: TEdit;
    Label3: TLabel;
    EditSomaSIGISS: TEdit;
    Label4: TLabel;
    EditTotalNotasDAH: TEdit;
    Label5: TLabel;
    EditSomaDAH: TEdit;
    Button1: TButton;
    procedure SelecionarCSV1Click(Sender: TObject);
    procedure ImportarDados1Click(Sender: TObject);
    procedure SelecionarCSV2Click(Sender: TObject);
    procedure ImportarDados2Click(Sender: TObject);
    procedure BtnCompara1Click(Sender: TObject);
    procedure BtnCompara2Click(Sender: TObject);
    procedure LimparTabela1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LimparTabela2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtnCompara1Click(Sender: TObject);
begin
// executa a compara��o da tabela 1 com a tabela 2
if (SIGISS.RecordCount < 1) OR (DAH.RecordCount < 1) then
  Exit;
SIGISS.First;
with form2 do begin
   if CDS_Retorno.Active then
     CDS_Retorno.EmptyDataSet;
   CDS_Retorno.Close;
   CDS_Retorno.CreateDataSet;
   CDS_Retorno.EnableControls;
end;
while not SIGISS.Eof do begin
  if DAH.Locate('DOCUMENTO',SIGISSNUMERO.Value,[])then begin
     if DAHVALOR.Value = SIGISSVALOR.Value then
      SIGISS.Next
     else begin
        with Form2 do begin
         CDS_Retorno.Append;
         CDS_RetornoEMISSAO.Value := SIGISSESCRITURACAO.Value;
         CDS_RetornoINDICE.Value := SIGISSNUMERO.Value;
         CDS_RetornoSTATUSPREFEITURA.Value := SIGISSSITUACAO.Value;
         if DAHVALORISS.Value > 0 then
            CDS_RetornoSTATUSDESBRAVADOR.Value := 'Tributando'
         else
            CDS_RetornoSTATUSDESBRAVADOR.Value := DAHOBSERVACAO.Value;
         CDS_RetornoVALOR.Value := SIGISSVALOR.Value;
         CDS_Retorno.Post;
        end;
        SIGISS.Next;
     end;
  end
  else begin
    with Form2 do begin
      CDS_Retorno.Append;
      CDS_RetornoEMISSAO.Value := SIGISSESCRITURACAO.Value;
      CDS_RetornoINDICE.Value := SIGISSNUMERO.Value;
      CDS_RetornoSTATUSPREFEITURA.Value := SIGISSSITUACAO.Value;
      CDS_RetornoSTATUSDESBRAVADOR.Value := 'N�o Encontrado';
      CDS_RetornoVALOR.Value := SIGISSVALOR.Value;
      CDS_Retorno.Post;
    end;
    SIGISS.Next;
  end;
end;
if Form2.CDS_Retorno.RecordCount > 0 then
  Form2.Show
else
  Showmessage('Nenhuma diverg�ncia Encontrada!');
end;

procedure TForm1.BtnCompara2Click(Sender: TObject);
begin
{// executa a compara��o da tabela 2 com a tabela 1
RxMemoryData2.First;
while not RxMemoryData2.Eof do begin
  if RxMemoryData1.Locate(CB_Indice1.Text,RxMemoryData2.FieldByName(CB_indice2.Text).Text,[loPartialkey])then begin
     if RxMemoryData1.FieldByName(CB_Compara1.Text).Text = RxMemoryData2.FieldByName(CB_Compara2.Text).Text then
      RxMemoryData2.Next
     else begin
        with Form2 do begin
         TblRetorno.Append;
         TblRetorno.FieldByName('�ndice').Value := RxMemoryData2.FieldByName(CB_indice2.Text).Text;
         TblRetorno.FieldByName('Status Tabela 1').Value := RxMemoryData1.FieldByName(CB_Retorno1.Text).Text;
         TblRetorno.FieldByName('Status Tabela 2').Value := RxMemoryData2.FieldByName(CB_Retorno2.Text).Text;
         TblRetorno.Post;
        end;
        RxMemoryData2.Next;
     end;
  end
  else begin
    with Form2 do begin
      TblRetorno.Append;
      TblRetorno.FieldByName('�ndice').Value := RxMemoryData2.FieldByName(CB_indice2.Text).Text;
      TblRetorno.FieldByName('Status Tabela 1').Value := 'N�o Encontrado';
      TblRetorno.FieldByName('Status Tabela 2').Value := RxMemoryData2.FieldByName(CB_Retorno2.Text).Text;
      TblRetorno.Post;
    end;
    RxMemoryData2.Next;
  end;
end;
if Form2.TblRetorno.RecordCount > 0 then
  Form2.Show
else
  Showmessage('Nenhuma diverg�ncia Encontrada!');
}end;



procedure TForm1.FormShow(Sender: TObject);
begin
   if SIGISS.Active then
     SIGISS.EmptyDataSet;
   SIGISS.Close;
   SIGISS.CreateDataSet;
   SIGISS.EnableControls;

   if DAH.Active then
     DAH.EmptyDataSet;
   DAH.Close;
   DAH.CreateDataSet;
   DAH.EnableControls;
end;

procedure TForm1.ImportarDados1Click(Sender: TObject);
var
   slFile: TStringList;
   i: integer;
   L: integer;
   Valor: Currency;
   conteudo: string;
   nfield:integer;

begin
//importa os dados do .CSV selecionado
   slFile := TStringList.Create;
   if SIGISS.Active then
     SIGISS.EmptyDataSet;
   SIGISS.Close;
   SIGISS.CreateDataSet;
   SIGISS.EnableControls;
   try
      slFile.LoadFromFile(edit1.Text);
      //come�a da primeira linha sempre � �0� (CABE�ALHO)
      for i := 0 to slFile.Count - 1 do begin
         conteudo := '';
          if i=0 then begin
            { for L := 1 to slFile.Strings[i].Length do begin
                if slfile.Strings[i][L] <> ';' then begin
                  conteudo := conteudo+slfile.Strings[i][L]
                end
                else begin
                  //Showmessage(conteudo);
                  with RxMemoryData1.FieldDefs do begin
                    with AddFieldDef do begin
                      Name := conteudo;
                      DataType := ftString;
                      Size := 15;
                    end;
                  end;
                  CB_indice1.Items.Add(conteudo);
                  CB_Compara1.Items.Add(conteudo);
                  CB_Retorno1.Items.Add(conteudo);
                  conteudo:=''
                end;
             end; }
          end
          else begin
            SIGISS.Append;
            conteudo:='';
            L:=0;
            nfield:=0;
            for L := 1 to slFile.Strings[i].Length do begin
                if slfile.Strings[i][L] <> ';' then begin
                  conteudo := conteudo+slfile.Strings[i][L]
                end
                else begin
                  //Showmessage(conteudo);
                  if nfield = 0 then
                    SIGISSDIA.Value := StrToInt(conteudo)
                  else if nfield = 1 then
                    SIGISSNUMERO.Value := StrToInt(conteudo)
                  else if nfield = 2 then
                    SIGISSSERIE.Value := StrToInt(conteudo)
                  else if nfield = 3 then
                    SIGISSTIPO.Value := conteudo
                  else if nfield = 4 then
                    SIGISSSITUACAO.Value := conteudo
                  else if nfield = 5 then
                    SIGISSCODIGO.Value := StrToInt(conteudo)
                  else if nfield = 6 then
                    SIGISSALIQUOTA.Value := StrToInt(conteudo)
                  else if nfield = 7 then
                    SIGISSVALOR.Value := StrToFloat(conteudo)
                  else if nfield = 8 then
                    SIGISSBASE.Value := StrToFloat(conteudo)
                  else if nfield = 9 then
                    SIGISSISS.Value := StrToFloat(conteudo)
                  else if nfield = 10 then
                    SIGISSCNPJ.Value := conteudo
                  else if nfield = 11 then
                    SIGISSTOMADOR.Value := conteudo
                  else if nfield = 12 then
                    SIGISSLANCAMENTO.Value := conteudo
                  else if nfield = 13 then
                    SIGISSESCRITURACAO.Value := StrToDateTime(conteudo);
                  conteudo:='';
                  inc(nfield);
                end
            end    ;
            SIGISS.Post;
          end;
      end ;
   finally
      slFile.Free;
      importardados1.Enabled := false;
      limpartabela1.Enabled := true;
      selecionarcsv1.Enabled := false;
      SIGISS.Active := True;
      EditTotalNotasSIGISS.Text := IntToStr(SIGISS.RecordCount);
      SIGISS.First;
      Valor:=0.00;
      while not SIGISS.Eof do begin
        Valor := Valor+SIGISSVALOR.Value;
        SIGISS.Next;
      end;
      EditSomaSIGISS.Text := FloatToSTrf(Valor,ffCurrency,18,2);
   end;
end;

procedure TForm1.ImportarDados2Click(Sender: TObject);
var
   slFile: TStringList;
   i: integer;
   L: integer;
   Valor: Currency;
   conteudo: string;
   nfield:integer;

begin
//importa os dados do .CSV selecionado
   slFile := TStringList.Create;
   if DAH.Active then
     DAH.EmptyDataSet;
   DAH.Close;
   DAH.CreateDataSet;
   DAH.EnableControls;
   try
      slFile.LoadFromFile(edit2.Text);
      //come�a da primeira linha sempre � �0� (CABE�ALHO)
      for i := 0 to slFile.Count - 1 do begin
         conteudo := '';
          if i=0 then begin
{             for L := 1 to slFile.Strings[i].Length do begin
                if slfile.Strings[i][L] <> ';' then begin
                  conteudo := conteudo+slfile.Strings[i][L]
                end
                else begin
                  //Showmessage(conteudo);
                  with RxMemoryData2.FieldDefs do begin
                    with AddFieldDef do begin
                      Name := conteudo;
                      DataType := ftString;
                      Size := 15;
                    end;
                  end;
                  CB_Indice2.Items.Add(conteudo);
                  CB_Compara2.Items.Add(conteudo);
                  CB_Retorno2.Items.Add(conteudo);
                  conteudo:=''
                end;
             end;
             rxmemorydata2.Active := true; }
          end
          else begin
            DAH.Append;
            conteudo:='';
            L:=0;
            nfield:=0;
            for L := 1 to slFile.Strings[i].Length do begin
                if slfile.Strings[i][L] <> ';' then begin
                  conteudo := conteudo+slfile.Strings[i][L]
                end
                else begin
                  //Showmessage(conteudo);
                  if nfield = 0 then
                    DAHSERIE.Value := StrToInt(conteudo)
                  else if nfield = 1 then
                    DAHEMISSAO.Value := StrToDate(conteudo)
                  else if nfield = 2 then
                    DAHRPS.Value := StrToInt(conteudo)
                  else if nfield = 3 then begin
                   if conteudo = '' then
                      conteudo := '0'  ;
                    DAHDOCUMENTO.Value := StrToInt(conteudo);
                  end
                  else if nfield = 4 then
                    DAHVALOR.Value := StrToFloat(conteudo)
                  else if nfield = 5 then
                    DAHBASE.Value := StrToFloat(conteudo)
                  else if nfield = 6 then
                    DAHALIQUOTA.Value := StrToInt(conteudo)
                  else if nfield = 7 then
                    DAHVALORISS.Value := StrToFloat(conteudo)
                  else if nfield = 8 then
                    DAHISENTOS.Value := StrToFloat(conteudo)
                  else if nfield = 9 then
                    DAHOUTROS.Value := StrToFloat(conteudo)
                  else if nfield = 10 then
                    DAHOBSERVACAO.Value := conteudo;
                  conteudo:='';
                  inc(nfield);
                end
            end    ;
            DAH.Post;
          end;
      end ;
   finally
      slFile.Free;
      importardados2.Enabled := false;
      limpartabela2.Enabled := true;
      selecionarcsv2.Enabled := false;
      DAH.Active := true;
      EditTotalNotasDAH.Text := IntToStr(DAH.RecordCount);
      DAH.First;
      Valor:=0.00;
      while not DAH.Eof do begin
        Valor := Valor+DAHVALOR.Value;
        DAH.Next;
      end;
      EditSomaDAH.Text := FloatToSTrf(Valor,ffCurrency,18,2);
   end;
end;

procedure TForm1.LimparTabela1Click(Sender: TObject);
begin
    if SIGISS.Active then
      SIGISS.EmptyDataSet;
    SIGISS.Close;
    SIGISS.CreateDataSet;
    SIGISS.EnableControls;
    ImportarDados1.Enabled := False;
    LimparTabela1.Enabled := False;
    SelecionarCSV1.Enabled := True;
    Edit1.Text := '';
    EditTotalNotasSIGISS.Text := '0';
    EditSomaSIGISS.Text := 'R$ 0,00'
end;

procedure TForm1.LimparTabela2Click(Sender: TObject);
begin
    if DAH.Active then
      DAH.EmptyDataSet;
    DAH.Close;
    DAH.CreateDataSet;
    DAH.EnableControls;
    ImportarDados2.Enabled := False;
    LimparTabela2.Enabled := False;
    SelecionarCSV2.Enabled := True;
    Edit2.Text := '';
    EditTotalNotasDAH.Text := '0';
    EditSomaDAH.Text := 'R$ 0,00'
end;

procedure TForm1.SelecionarCSV1Click(Sender: TObject);
begin
//pega o nome do arquivo .CSV
    if opendialog1.Execute then
       Edit1.Text := Opendialog1.FileName;
    //Panel5.Caption := '  '+ExtractFileName(Edit1.Text);
    importardados1.Enabled := True;
    if SIGISS.Active then
      SIGISS.EmptyDataSet;
    SIGISS.Close;
    SIGISS.CreateDataSet;
    SIGISS.EnableControls;
end;

procedure TForm1.SelecionarCSV2Click(Sender: TObject);
begin
//pega o nome do arquivo .CSV
    if opendialog1.Execute then
       Edit2.Text := opendialog1.FileName;
    //Panel6.Caption := '  '+ExtractFileName(Edit2.Text);
    importardados2.Enabled := True;
    if DAH.Active then
     DAH.EmptyDataSet;
    DAH.Close;
    DAH.CreateDataSet;
    DAH.EnableControls;
end;

end.
