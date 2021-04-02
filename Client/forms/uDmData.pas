unit uDmData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  uDWAbout, uRESTDWPoolerDB, FireDAC.Comp.Client, Data.DB;

type
  TdmData = class(TDataModule)
    fdConn: TFDConnection;
    fdTrans: TFDTransaction;
    restDB: TRESTDWDataBase;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmData: TdmData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
