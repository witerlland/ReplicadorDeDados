unit uDmData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  uRESTDWPoolerDB, uRestDWDriverFD, uDWAbout, FireDAC.Comp.Client, Data.DB,
  uDwDataModule, JvComponentBase, JvAppStorage, JvAppIniStorage,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef;

type
  TdmData = class(TServerMethodDataModule)
    fdConn: TFDConnection;
    fdTrans: TFDTransaction;
    restDB: TRESTDWPoolerDB;
    restDriver: TRESTDWDriverFD;
    jediINI: TJvAppIniFileStorage;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ConfigDB;
  end;

var
  dmData: TdmData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmData.ConfigDB;
begin
  with fdConn.Params do
  begin
    DriverID := 'FB';
    Database := jediINI.IniFile.ReadString('frmMain', 'edtDBPath_Text', '');
    UserName := jediINI.IniFile.ReadString('frmMain', 'edtDBUser_text', '');
    Password := jediINI.IniFile.ReadString('frmMain', 'edtDBPass_text', '');
  end;

  fdConn.Connected := True;
end;

end.
