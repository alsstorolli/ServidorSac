unit classeprecos;

interface

type TPrecos = class
  private
    FEsqt_esto_Codigo: String;
    FEsqt_qtde: Double;
    FEsqt_vendavis: Double;
    FEsqt_desconto: Double;
    procedure SetEsqt_Esto_Codigo(const Value: string);
    procedure SetEsqt_qtde(const Value: Double);
    procedure SetEsqt_vendavis(const Value: Double);
    procedure SetEsqt_desconto(const Value: Double);
  public
    [FieldName('Esqt_Esto_Codigo')]
    property Esqt_Esto_Codigo:string read FEsqt_Esto_Codigo write SetEsqt_Esto_Codigo;
    [FieldName('Esqt_qtde')]
    property Esqt_qtde:Double read FEsqt_qtde write SetEsqt_qtde;
    [FieldName('Esqt_vendavis')]
    property Esqt_vendavis:Double read FEsqt_vendavis write SetEsqt_vendavis;
    [FieldName('Esqt_desconto')]
    property Esqt_desconto:Double read FEsqt_desconto write SetEsqt_desconto;

end;

implementation

{ TPrecos }

procedure TPrecos.SetEsqt_desconto(const Value: Double);
begin
   FEsqt_desconto := Value;
end;

procedure TPrecos.SetEsqt_Esto_Codigo(const Value: string);
begin
   FEsqt_esto_Codigo := Value;
end;

procedure TPrecos.SetEsqt_qtde(const Value: Double);
begin
   FEsqt_qtde := Value;
end;

procedure TPrecos.SetEsqt_vendavis(const Value: Double);
begin
  FEsqt_vendavis := Value;
end;

end.
