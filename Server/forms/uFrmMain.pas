unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons,
  PngSpeedButton, Vcl.Menus, Vcl.StdCtrls, uDWAbout, uRESTDWBase, Vcl.ExtDlgs,
  JvFormPlacement, JvComponentBase, JvAppStorage, JvAppIniStorage;

type
  TfrmMain = class(TForm)
    header: TPanel;
    footer: TPanel;
    body: TPanel;
    btExit: TPngSpeedButton;
    btMinimized: TPngSpeedButton;
    trIcon: TTrayIcon;
    popMenu: TPopupMenu;
    popMax: TMenuItem;
    popExit: TMenuItem;
    lblTitle: TLabel;
    restServer: TRESTServicePooler;
    edtContext: TEdit;
    edtPort: TEdit;
    btnStartServer: TButton;
    btSaveConfig: TButton;
    cbDatabaseType: TComboBox;
    opDialog: TOpenTextFileDialog;
    edtDBPath: TEdit;
    edtDBName: TEdit;
    edtDBPort: TEdit;
    edtDBUser: TEdit;
    edtDBPass: TEdit;
    jediINI: TJvAppIniFileStorage;
    jediForm: TJvFormStorage;
    procedure btExitClick(Sender: TObject);
    procedure btMinimizedClick(Sender: TObject);
    procedure popMaxClick(Sender: TObject);
    procedure btnStartServerClick(Sender: TObject);
    procedure cbDatabaseTypeChange(Sender: TObject);
    procedure btSaveConfigClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  uDmData;

procedure TfrmMain.btExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.btMinimizedClick(Sender: TObject);
begin
  Self.Hide;
  Self.WindowState  := wsMinimized;

  trIcon.Visible     := true;
  trIcon.Animate     := true;
  trIcon.ShowBalloonHint;
end;

procedure TfrmMain.btnStartServerClick(Sender: TObject);
begin
  if restServer.Active then
  begin
    btnStartServer.Caption := '&Ativar';
    restServer.Active      := False;
  end
  else
  begin
    btnStartServer.Caption := '&Parar';
    restServer.Active      := True;

    restServer.ServerMethodClass := TdmData;
    dmData.ConfigDB;
  end;
end;

procedure TfrmMain.btSaveConfigClick(Sender: TObject);
begin
  jediForm.SaveFormPlacement;
  jediINI.Reload;
end;

procedure TfrmMain.cbDatabaseTypeChange(Sender: TObject);
begin
  if cbDatabaseType.ItemIndex in [0] then
  begin
    edtDBPath.Visible := True;
    edtDBName.Visible := False;
  end
  else
  begin
    edtDBPath.Visible := False;
    edtDBName.Visible := True;
  end;
end;

procedure TfrmMain.popMaxClick(Sender: TObject);
begin
  Self.Show;
  Self.WindowState  := wsNormal;

  trIcon.Visible     := False;

  Application.BringToFront();
end;

end.
