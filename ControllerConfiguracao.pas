unit ControllerConfiguracao;

interface

uses ClasseConfiguracao, System.Generics.Collections;

type TControllerConfiguracao=class
  private
    fListaConfiguracao:TObjectList<TConfiguracao>;
  public
    constructor Create;
    destructor Destroy;override;
    property ListaConfiguracao:TObjectList<TConfiguracao> read fListaConfiguracao write fListaConfiguracao;
    procedure LerConfiguracao(Arquivo:string);
    function GetConfiguracao(Campo:string):String;
end;

implementation

uses
  System.Classes, System.SysUtils, System.JSON;

{ TControllerConfiguracao }

constructor TControllerConfiguracao.Create;
begin
  fListaConfiguracao:=TObjectList<TConfiguracao>.Create;
end;

destructor TControllerConfiguracao.Destroy;
begin
  fListaConfiguracao.Clear;
  FreeAndNil(fListaConfiguracao);
  inherited;
end;

function TControllerConfiguracao.GetConfiguracao(Campo: string): String;
var i:Integer;
    cResult:String;
begin
  cResult:='';
  for i:=0 to ListaConfiguracao.Count-1 do begin
    if Trim(LowerCase(ListaConfiguracao[i].Campo))=Trim(LowerCase(Campo)) then begin
      cResult:=ListaConfiguracao[i].Valor;
      Break;
    end;
  end;
  Result:=cResult;
end;

procedure TControllerConfiguracao.LerConfiguracao(Arquivo: string);
var lConf:TStringList;
    jsonObj:TJSONObject;
    jSubObj:TJSONPair;
    j: Integer;
    Conf:TConfiguracao;
begin
  if FileExists(Arquivo) then begin
    ListaConfiguracao.Clear;
    lConf:=TStringList.Create;
    lConf.LoadFromFile(Arquivo);
    jsonObj:=TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(lConf.Text),0) as TJSONObject;
    for j:=0 to jsonObj.Size-1 do  begin
      jSubObj:=jsonObj.Get(j);  //pega o par no índice j
      Conf:=TConfiguracao.Create;
      Conf.Campo:=jSubObj.JsonString.Value;
      Conf.Valor:=jSubObj.JsonValue.Value;
      ListaConfiguracao.Add(Conf);
    end;
    FreeAndNil(lConf);
  end;
end;

end.
