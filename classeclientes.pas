unit classeclientes;

interface

type TClientes = class
  private
    FClie_Codigo: Integer;
    FClie_Nome: String;
    FClie_Razaosocial: String;
    FClie_Cnpjcpf: String;
    FClie_Cidade: String;
    procedure SetClie_Codigo(const Value: Integer);
    procedure SetClie_Nome(const Value: String);
    procedure SetClie_Razaosocial(const Value: String);
    procedure SetClie_Cidade(const Value: String);
    procedure SetClie_Cnpjcpf(const Value: String);
  public
    [FieldName('Clie_Codigo')]
    property Clie_Codigo:Integer read FClie_Codigo write SetClie_Codigo;
    [FieldName('Clie_Nome')]
    property Clie_Nome:String read FClie_Nome write SetClie_Nome;
    [FieldName('Clie_Razaosocial')]
    property Clie_Razaosocial:String read FClie_Razaosocial write SetClie_Razaosocial;
    [FieldName('Clie_Cidade')]
    property Clie_Cidade:String read FClie_Cidade write SetClie_Cidade;
    [FieldName('Clie_Cnpjcpf')]
    property Clie_Cnpjcpf:String read FClie_Cnpjcpf write SetClie_Cnpjcpf;

end;

implementation

{ TClientes }

procedure TClientes.SetClie_Cidade(const Value: String);
begin
  FClie_Cidade := Value;
end;

procedure TClientes.SetClie_Cnpjcpf(const Value: String);
begin
  FClie_Cnpjcpf := Value;
end;


procedure TClientes.SetClie_Codigo(const Value: Integer);
begin
  FClie_Codigo := Value;
end;

procedure TClientes.SetClie_Nome(const Value: String);
begin
  FClie_Nome := Value;
end;

procedure TClientes.SetClie_Razaosocial(const Value: String);
begin
   FClie_Razaosocial := Value;
end;

end.
