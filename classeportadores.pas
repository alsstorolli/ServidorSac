unit classeportadores;

interface

type TPortadores = class
  private
    FPort_Codigo: String;
    FPort_Descricao: String;
    FPort_plan_Conta: Integer;
    procedure SetPort_Codigo(const Value: String);
    procedure SetPort_Descricao(const Value: String);
    procedure SetPort_plan_Conta(const Value: Integer);
  public
    [FieldName('Port_Codigo')]
    property Port_Codigo:String read FPort_Codigo write SetPort_Codigo;
    [FieldName('Port_Descricao')]
    property Port_Descricao:String read FPort_Descricao write SetPort_Descricao;
    [FieldName('Port_plan_Conta')]
    property Port_plan_Conta:Integer read FPort_plan_Conta write SetPort_plan_Conta;

end;

implementation

{ TPortadores }


procedure TPortadores.SetPort_Codigo(const Value: String);
begin
   FPort_Codigo := Value;
end;

procedure TPortadores.SetPort_Descricao(const Value: String);
begin
  FPort_Descricao := Value;
end;

procedure TPortadores.SetPort_plan_Conta(const Value: Integer);
begin
  FPort_plan_Conta := Value;
end;


end.
