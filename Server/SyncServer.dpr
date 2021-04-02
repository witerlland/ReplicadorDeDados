program SyncServer;

uses
  Vcl.Forms,
  uFrmMain in 'forms\uFrmMain.pas' {frmMain},
  uDmData in 'forms\uDmData.pas' {dmData: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmData, dmData);
  Application.Run;
end.
