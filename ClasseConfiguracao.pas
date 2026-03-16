unit ClasseConfiguracao;

interface

uses AtributosClasses;

type TConfiguracao=class
  private
    FValor: String;
    FCampo: String;
    procedure SetCampo(const Value: String);
    procedure SetValor(const Value: String);
  public
    [FieldName('campo')]
    property Campo:String read FCampo write SetCampo;
    [FieldName('valor')]
    property Valor:String read FValor write SetValor;
end;

implementation

{ TConfiguracao }

{ TConfiguracao }

procedure TConfiguracao.SetCampo(const Value: String);
begin
  FCampo := Value;
end;

procedure TConfiguracao.SetValor(const Value: String);
begin
  FValor := Value;
end;

end.
