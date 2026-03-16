unit classecondicao;

interface

type TCondicao = class
  private
    FFpgt_Codigo: String;
    FFpgt_Descricao: String;
    FFpgt_prazos: String;
    procedure SetFpgt_Codigo(const Value: String);
    procedure SetFpgt_Descricao(const Value: String);
    procedure SetFpgt_prazos(const Value: String);
  public
    [FieldName('Fpgt_Codigo')]
    property Fpgt_Codigo:String read FFpgt_Codigo write SetFpgt_Codigo;
    [FieldName('Fpgt_Descricao')]
    property Fpgt_Descricao:String read FFpgt_Descricao write SetFpgt_Descricao;
    [FieldName('Fpgt_prazos')]
    property Fpgt_prazos:String read FFpgt_prazos write SetFpgt_prazos;

end;

implementation

{ TCondicao }

procedure TCondicao.SetFpgt_Codigo(const Value: String);
begin
  FFpgt_Codigo := Value;
end;

procedure TCondicao.SetFpgt_Descricao(const Value: String);
begin
  FFpgt_Descricao := Value;
end;

procedure TCondicao.SetFpgt_prazos(const Value: String);
begin
   FFpgt_prazos := Value;
end;

end.
