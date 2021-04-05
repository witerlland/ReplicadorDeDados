program SyncClient;

uses
  Vcl.Forms,
  uFrmMain in 'forms\uFrmMain.pas' {frmMain},
  uDmData in 'forms\uDmData.pas' {dmData: TDataModule},
  uFormQuery in 'classes\uFormQuery.pas',
  uGrupoPref in 'classes\Sync\uGrupoPref.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmData, dmData);
  Application.Run;
end.
