unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  PngSpeedButton, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, JvFormPlacement, JvComponentBase, JvAppStorage,
  JvAppIniStorage;

type
  TfrmMain = class(TForm)
    tmSync: TTimer;
    header: TPanel;
    btExit: TPngSpeedButton;
    btMinimized: TPngSpeedButton;
    lblTitle: TLabel;
    footer: TPanel;
    mmLog: TMemo;
    body: TPanel;
    edtContext: TEdit;
    edtPort: TEdit;
    btSaveConfig: TButton;
    cbDatabaseType: TComboBox;
    edtDBPath: TEdit;
    edtDBName: TEdit;
    edtDBPort: TEdit;
    edtDBUser: TEdit;
    edtDBPass: TEdit;
    btStart: TButton;
    jediINI: TJvAppIniFileStorage;
    jediForm: TJvFormStorage;
    procedure btExitClick(Sender: TObject);
    procedure btStartClick(Sender: TObject);
    procedure tmSyncTimer(Sender: TObject);
    procedure btSaveConfigClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure sync;
  end;

type
  TSync = class(TThread)
    private
      procedure OnSync;
    public
      procedure Execute; Override;
      procedure onTerminate;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uDmData,
  RTTI;

{ TForm1 }

procedure TfrmMain.btExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.btSaveConfigClick(Sender: TObject);
begin
  jediForm.SaveFormPlacement;
  jediINI.Reload;
end;

procedure TfrmMain.btStartClick(Sender: TObject);
begin
  dmData.ConfigDB;
  sync;
end;

procedure TfrmMain.sync;
var
  CSync : TSync;
begin
  try
    tmSync.Enabled        := False;
    CSync                 := TSync.Create(True);
    CSync.FreeOnTerminate := True;

    try
      CSync.Execute;
    Except
      On E: Exception do
      begin
        mmLog.Lines.Add('Error: ' + E.Message)
      end;
    end;
  finally
    CSync.onTerminate;
  end;
end;

procedure TfrmMain.tmSyncTimer(Sender: TObject);
begin
  sync;
end;

{ TSync }

procedure TSync.Execute;
begin
  inherited;
  Self.OnSync;
end;

procedure TSync.OnSync;
var
  qrTmp     : TFDQuery;
  context   : TRttiContext;
  lType     : TRttiType;
  lMethod   : TRttiMethod;
  vClass    : TClass;
  vValue    : TValue;
begin
  qrTmp            := TFDQuery.Create(Application);
  qrTmp.Connection := dmData.fdConn;

  qrTmp.Open('select first 1 * from m_sync');

  if qrTmp.RecordCount > 0 then
  begin
    try
      context := TRttiContext.Create;

      vClass := FindClass(qrTmp.FieldByName('table').AsString);
      lType  := context.GetType(vClass);

      if Assigned(lType) then
      begin
        lMethod := lType.GetMethod(qrTmp.FieldByName('action').AsString);

        if Assigned(lMethod) then
          vValue := lMethod.Invoke(
            vClass, [
            qrTmp.FieldByName('id_action').AsInteger,
            qrTmp.FieldByName('table_primary_key').AsInteger
          ]);

        if vValue.AsBoolean then
        begin
          qrTmp.Delete;
          dmData.fdConn.Commit;
        end;

        dmData.fdConn.Close;
      end;
    except
      On E: Exception do
      begin
        frmMain.mmLog.Lines.Add('Error: ' + E.Message)
      end;
    end;
  end;

  qrTmp.Free;
end;

procedure TSync.onTerminate;
begin
  frmMain.tmSync.Enabled := True;
  frmMain.mmLog.Lines.Add('Terminado ação....');
end;

end.
