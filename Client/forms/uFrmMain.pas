unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  PngSpeedButton, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmMain = class(TForm)
    tmSync: TTimer;
    header: TPanel;
    btExit: TPngSpeedButton;
    btMinimized: TPngSpeedButton;
    lblTitle: TLabel;
    footer: TPanel;
    mmLog: TMemo;
    btStart: TButton;
    procedure btExitClick(Sender: TObject);
    procedure btStartClick(Sender: TObject);
    procedure tmSyncTimer(Sender: TObject);
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
  uDmData;

{ TForm1 }

procedure TfrmMain.btExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.btStartClick(Sender: TObject);
begin
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
  qrTmp : TFDQuery;
begin
  qrTmp            := TFDQuery.Create(Application);
  qrTmp.Connection := dmData.fdConn;

  qrTmp.Open('select first * from monitor_sync');

  if qrTmp.RecordCount > 0 then
  begin

  end;
  

  frmMain.mmLog.Lines.Add('Iniciando ação....');
end;

procedure TSync.onTerminate;
begin
  frmMain.tmSync.Enabled := True;
  frmMain.mmLog.Lines.Add('Terminado ação....');
end;

end.
