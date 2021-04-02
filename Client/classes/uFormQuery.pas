unit uFormQuery;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.Classes,
  System.SysUtils,
  System.Variants,
  FireDAC.Comp.Client,
  uRESTDWPoolerDB,
  uDWMassiveBuffer,
  Data.DB,
  Vcl.StdCtrls;

type
  CFormQuery = class
    public
      procedure processQuery(sqlQuery: TRESTDWClientSQL; qrTmp: TFDQuery; table, tableKey: String; isCreate: Boolean); overload;
      procedure processQuery(qrTmp: TFDQuery; sqlQuery: TDataSet; table, tableKey: String; isCreate: Boolean); overload;
  end;

implementation

procedure CFormQuery.processQuery(sqlQuery: TRESTDWClientSQL; qrTmp: TFDQuery; table, tableKey: String; isCreate: Boolean);
var
  vValues : TStringList;
  C, I    : Integer;
begin
  vValues     := TStringList.Create;

  // If tratando o inicio da query para insert ou update
  if(isCreate) then
    sqlQuery.SQL.Add('insert into ' + table + ' (')
  else
    sqlQuery.SQL.Add('update ' + table + ' set ');

  // Variaveis com scopo local para os dois for's
  // C = tamanho da query
  // I = usada dentro dos fors para contagem
  C := qrTmp.FieldCount - 1;
//  var I : Integer;

  // ********************
  // For que trata os parametros da query enviada ao servidor
  // ********************
  for I := 0 to C do
  begin
    if
      (Not qrTmp.Fields[I].IsNull) and
      (qrTmp.Fields[I].AsString <> '')
    then
    begin
      if I = 0 then
      begin

        if(isCreate) then
        begin
          sqlQuery.SQL.Add(qrTmp.Fields[I].DisplayName);
          vValues.Add(':' +qrTmp.Fields[I].DisplayName);
        end
        else
          sqlQuery.SQL.Add(qrTmp.Fields[I].DisplayName + ' = :' +qrTmp.Fields[I].DisplayName);
      end
      else
      begin
        if(isCreate) then
        begin
          sqlQuery.SQL.Add(', ' + qrTmp.Fields[I].DisplayName);
          vValues.Add(', :' +qrTmp.Fields[I].DisplayName);
        end
        else
          sqlQuery.SQL.Add(', ' + qrTmp.Fields[I].DisplayName + ' = :' +qrTmp.Fields[I].DisplayName);
      end; // Fim do if que verifica onde a primeira virgula (,) da query vai ir
    end; // Fim do if que verifica os dados dos campos
  end; // Fim do for que cria os parametros na query enviada para o servidor.

  // ***************************************************************************
  // If que verifica o status de integrado e forma a query entre update e insert
  // ***************************************************************************
  if(isCreate) then
    sqlQuery.SQL.Add(') values (' + vValues.Text + ')')
  else
    sqlQuery.SQL.Add(' where ' + TableKey + ' = ' + qrTmp.FieldByName(TableKey).AsString);

//      sysLogs.save('[SQl text]', qrTmp.SQL.Text);

  // *************************
  // For nos campos da query.
  // Pega apenas os campos com valores validos os tratando e colocando em seus parametros pares
  // *************************
  I := 0;
  for I := 0 to C do
  begin
    if
      (Not qrTmp.Fields[I].IsNull) and
      (qrTmp.Fields[I].AsString <> '')
    then
    begin
      case qrTmp.Fields[I].DataType of
        ftTimeStampOffset : sqlQuery.ParamByName(qrTmp.Fields[I].DisplayName).AsDateTime  := qrTmp.FieldByName(qrTmp.Fields[I].DisplayName).AsDateTime;
        ftOraTimeStamp    : sqlQuery.ParamByName(qrTmp.Fields[I].DisplayName).AsDateTime  := qrTmp.FieldByName(qrTmp.Fields[I].DisplayName).AsDateTime;

        ftTimeStamp : sqlQuery.ParamByName(qrTmp.Fields[I].DisplayName).AsDateTime  := qrTmp.FieldByName(qrTmp.Fields[I].DisplayName).AsDateTime;
        ftDate      : sqlQuery.ParamByName(qrTmp.Fields[I].DisplayName).AsDate      := qrTmp.FieldByName(qrTmp.Fields[I].DisplayName).AsDateTime;
        ftDateTime  : sqlQuery.ParamByName(qrTmp.Fields[I].DisplayName).AsDateTime  := qrTmp.FieldByName(qrTmp.Fields[I].DisplayName).AsDateTime;
        ftTime      : sqlQuery.ParamByName(qrTmp.Fields[I].DisplayName).AsTime      := qrTmp.FieldByName(qrTmp.Fields[I].DisplayName).AsDateTime;

        ftFloat     : sqlQuery.ParamByName(qrTmp.Fields[I].DisplayName).AsFloat     := StrToFloat(qrTmp.FieldByName(qrTmp.Fields[I].DisplayName).AsString);
        ftCurrency  : sqlQuery.ParamByName(qrTmp.Fields[I].DisplayName).AsCurrency  := StrToCurr(qrTmp.FieldByName(qrTmp.Fields[I].DisplayName).AsString);
        ftBCD       : sqlQuery.ParamByName(qrTmp.Fields[I].DisplayName).AsBCD       := StrToCurr(qrTmp.FieldByName(qrTmp.Fields[I].DisplayName).AsString);
        ftFMTBcd    : sqlQuery.ParamByName(qrTmp.Fields[I].DisplayName).AsFMTBCD    := StrToCurr(qrTmp.FieldByName(qrTmp.Fields[I].DisplayName).AsString);
        ftBlob      : sqlQuery.ParamByName(qrTmp.Fields[I].DisplayName).AsString    := '';
        else
        begin
          try
            sqlQuery.ParamByName(qrTmp.Fields[I].DisplayName).AsDate := StrToDate(qrTmp.FieldByName(qrTmp.Fields[I].DisplayName).AsString);
          except
            sqlQuery.ParamByName(qrTmp.Fields[I].DisplayName).AsString := qrTmp.FieldByName(qrTmp.Fields[I].DisplayName).AsString;
          end;
        end;
      end; // Fim do case tratando os tipos de dado
    end; // Fim do if que verifica se os dados sao validos
  end; // Fim do for com o tratamento dos dados da linha da query

  vValues.Free;
end;

procedure CFormQuery.processQuery(qrTmp: TFDQuery; sqlQuery: TDataSet;
  table, tableKey: String; isCreate: Boolean);
  var
    vValues : TStringList;
    C, I    : Integer;
begin
  vValues     := TStringList.Create;

  // If tratando o inicio da query para insert ou update
  if(isCreate) then
    qrTmp.SQL.Add('insert into ' + table + ' (')
  else
    qrTmp.SQL.Add('update ' + table + ' set ');

  // Variaveis com scopo local para os dois for's
  // C = tamanho da query
  // I = usada dentro dos fors para contagem
  C := sqlQuery.FieldCount - 1;

  // ********************
  // For que trata os parametros da query enviada ao servidor
  // ********************
  for I := 0 to C do
  begin
    if
      (Not sqlQuery.Fields[I].IsNull) and
      (sqlQuery.Fields[I].AsString <> '')
    then
    begin
      if I = 0 then
      begin

        if(isCreate) then
        begin
          qrTmp.SQL.Add(sqlQuery.Fields[I].DisplayName);
          vValues.Add(':' +sqlQuery.Fields[I].DisplayName);
        end
        else
          qrTmp.SQL.Add(sqlQuery.Fields[I].DisplayName + ' = :' +sqlQuery.Fields[I].DisplayName);
      end
      else
      begin
        if(isCreate) then
        begin
          qrTmp.SQL.Add(', ' + sqlQuery.Fields[I].DisplayName);
          vValues.Add(', :' +sqlQuery.Fields[I].DisplayName);
        end
        else
          qrTmp.SQL.Add(', ' + sqlQuery.Fields[I].DisplayName + ' = :' +sqlQuery.Fields[I].DisplayName);
      end; // Fim do if que verifica onde a primeira virgula (,) da query vai ir
    end; // Fim do if que verifica os dados dos campos
  end; // Fim do for que cria os parametros na query enviada para o servidor.

  // ***************************************************************************
  // If que verifica o status de integrado e forma a query entre update e insert
  // ***************************************************************************
  if(isCreate) then
    qrTmp.SQL.Add(') values (' + vValues.Text + ')')
  else
    qrTmp.SQL.Add(' where ' + TableKey + ' = ' + sqlQuery.FieldByName(TableKey).AsString);
  // *************************
  // For nos campos da query.
  // Pega apenas os campos com valores validos os tratando e colocando em seus parametros pares
  // *************************
  I := 0;
  for I := 0 to C do
  begin
    if
      (Not sqlQuery.Fields[I].IsNull) and
      (sqlQuery.Fields[I].AsString <> '')
    then
    begin

      case sqlQuery.Fields[I].DataType of
        ftTimeStampOffset : qrTmp.ParamByName(sqlQuery.Fields[I].DisplayName).AsDateTime  := sqlQuery.FieldByName(sqlQuery.Fields[I].DisplayName).AsDateTime;
        ftOraTimeStamp    : qrTmp.ParamByName(sqlQuery.Fields[I].DisplayName).AsDateTime  := sqlQuery.FieldByName(sqlQuery.Fields[I].DisplayName).AsDateTime;

        ftTimeStamp : qrTmp.ParamByName(sqlQuery.Fields[I].DisplayName).AsDateTime  := sqlQuery.FieldByName(sqlQuery.Fields[I].DisplayName).AsDateTime;
        ftDate      : qrTmp.ParamByName(sqlQuery.Fields[I].DisplayName).AsDate      := sqlQuery.FieldByName(sqlQuery.Fields[I].DisplayName).AsDateTime;
        ftDateTime  : qrTmp.ParamByName(sqlQuery.Fields[I].DisplayName).AsDateTime  := sqlQuery.FieldByName(sqlQuery.Fields[I].DisplayName).AsDateTime;
        ftTime      : qrTmp.ParamByName(sqlQuery.Fields[I].DisplayName).AsTime      := sqlQuery.FieldByName(sqlQuery.Fields[I].DisplayName).AsDateTime;

        ftFloat     : qrTmp.ParamByName(sqlQuery.Fields[I].DisplayName).AsFloat     := StrToFloat(sqlQuery.FieldByName(sqlQuery.Fields[I].DisplayName).AsString);
        ftCurrency  : qrTmp.ParamByName(sqlQuery.Fields[I].DisplayName).AsCurrency  := StrToCurr(sqlQuery.FieldByName(sqlQuery.Fields[I].DisplayName).AsString);
        ftBCD       : qrTmp.ParamByName(sqlQuery.Fields[I].DisplayName).AsBCD       := StrToCurr(sqlQuery.FieldByName(sqlQuery.Fields[I].DisplayName).AsString);
        ftFMTBcd    : qrTmp.ParamByName(sqlQuery.Fields[I].DisplayName).AsFMTBCD    := StrToCurr(sqlQuery.FieldByName(sqlQuery.Fields[I].DisplayName).AsString);
        ftBlob      : qrTmp.ParamByName(sqlQuery.Fields[I].DisplayName).AsString    := '';
        else
        begin
          try
            qrTmp.ParamByName(sqlQuery.Fields[I].DisplayName).AsDate := StrToDate(sqlQuery.FieldByName(sqlQuery.Fields[I].DisplayName).AsString);
          except
            qrTmp.ParamByName(sqlQuery.Fields[I].DisplayName).AsString := sqlQuery.FieldByName(sqlQuery.Fields[I].DisplayName).AsString;
          end;
        end;
      end; // Fim do case tratando os tipos de dado
    end; // Fim do if que verifica se os dados sao validos
  end; // Fim do for com o tratamento dos dados da linha da query

  vValues.Free;
end;

end.
