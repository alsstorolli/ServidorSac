unit ControllerCadastros;

interface

uses  ZConnection,seEnvironment,DalClass, sefuncoes,ControllerConfiguracao,
      classeportadores,djson,System.Generics.Collections,System.JSON,System.SysUtils,
      Horse, Horse.Jhonson,Data.DB,classeclientes,classeprodutos,
      classecondicao;

type TControllerCadastros=class(TInterfacedObject)
  private
  fListaPortadores:TObjectList<TPortadores>;
  fListaCondicao:TObjectList<TCondicao>;
  fListaClientes:TObjectList<TClientes>;
  function ConfiguraConexao(oAmbiente:TseEnvironment):Boolean;
  public
  FConfiguracao: TControllerConfiguracao;
  constructor Create(Conf: TControllerConfiguracao);
  destructor Destroy;override;
  function GetPortadores(out Mensagem:String):String;
  function GetClientes(out Mensagem:String):String;
  function GetProdutos(out Mensagem:String):String;
  function GetPrecos(out Mensagem:String):String;
  function GetCondicao(out Mensagem:String):String;
  function IncluiPedido(out Mensagem:String;Body:String):String;
  function Conectar:Boolean;
  procedure  AtivaListeners;
  function GetConfig1AsString(NomeCampo:String):String;
  function PegaSequenciaPostgreSql(NomeSequencia: String; const Incrementar: Boolean): Integer;


end;

implementation

{ TControllerCadastros }

procedure TControllerCadastros.AtivaListeners;
begin
  THorse.Get('/portadores',
    procedure(Req:THorseRequest;Res:THorseResponse;Next:TProc)
    var cMensagem,cRetorno:String;
    begin
      try
//        Log.Add('Request mesasgetmvto empresa: '+Req.Params['empresa']+' ID: '+Req.Params['id']);
        cRetorno:=GetPortadores(cMensagem);
        Res.Send(cRetorno);
//        Log.Add('Retorno mesasgetmvto mensagem '+cMensagem);
//        Log.Add('Retorno mesasgetmvto '+cRetorno);
      except
        on E: Exception do begin
//          Log.Add('Erro mesasgetmvto '+e.Message);
        end;
      end;
    end);

  THorse.Get('/condicao',
    procedure(Req:THorseRequest;Res:THorseResponse;Next:TProc)
    var cMensagem,cRetorno:String;
    begin
      try
        cRetorno:=GetCondicao(cMensagem);
        Res.Send(cRetorno);
      except
        on E: Exception do begin
        end;
      end;
    end);

  THorse.Get('/clientes',
    procedure(Req:THorseRequest;Res:THorseResponse;Next:TProc)
    var cMensagem,cRetorno:String;
    begin
      try
//        Log.Add('Request mesasgetmvto empresa: '+Req.Params['empresa']+' ID: '+Req.Params['id']);
        cRetorno:=GetClientes(cMensagem);
        Res.Send(cRetorno);
//        Log.Add('Retorno mesasgetmvto mensagem '+cMensagem);
//        Log.Add('Retorno mesasgetmvto '+cRetorno);
      except
        on E: Exception do begin
//          Log.Add('Erro mesasgetmvto '+e.Message);
        end;
      end;
    end);
 // 13.12.24
    THorse.Get('/produtos',
    procedure(Req:THorseRequest;Res:THorseResponse;Next:TProc)
    var cMensagem,cRetorno:String;
    begin
      try
//        Log.Add('Request mesasgetmvto empresa: '+Req.Params['empresa']+' ID: '+Req.Params['id']);
        cRetorno:=GetProdutos(cMensagem);
        Res.Send(cRetorno);
//        Log.Add('Retorno mesasgetmvto mensagem '+cMensagem);
//        Log.Add('Retorno mesasgetmvto '+cRetorno);
      except
        on E: Exception do begin
//          Log.Add('Erro mesasgetmvto '+e.Message);
        end;
      end;
    end);

 // 01.10.25
    THorse.Post('/pedido',
    procedure(Req:THorseRequest;Res:THorseResponse;Next:TProc)
    var cMensagem,cRetorno:String;
    begin
      try
//        Log.Add('Request mesasgetmvto empresa: '+Req.Params['empresa']+' ID: '+Req.Params['id']);
        cRetorno:=IncluiPedido(cMensagem,Req.Body);
        Res.Send(cRetorno);
//        Log.Add('Retorno mesasgetmvto mensagem '+cMensagem);
//        Log.Add('Retorno mesasgetmvto '+cRetorno);
      except
        on E: Exception do begin
//          Log.Add('Erro mesasgetmvto '+e.Message);
        end;
      end;
    end);

 end;

function TControllerCadastros.Conectar: Boolean;
var fAmbiente:TseEnvironment;
    bResult:Boolean;
begin
  bResult:=False;
  fAmbiente:=TseEnvironment.Create(Nil);
  fAmbiente.Conexao:=TZConnection.Create(Nil);
  Ambiente.ExecutaProcessaMensagem:=False;
  if ConfiguraConexao(fAmbiente) then begin
    bResult:=True;
  end;
  FreeAndNil(fAmbiente);
  Result:=bResult;
end;


function TControllerCadastros.ConfiguraConexao(oAmbiente: TseEnvironment): Boolean;
begin
  oAmbiente.TipoServidor:=tsPostGreSql;
  Ambiente.TipoServidor:=tsPostGreSql;
  oAmbiente.Endereco:=FConfiguracao.GetConfiguracao('endereco');
  oAmbiente.Porta:=Funcoes.Inteiro(FConfiguracao.GetConfiguracao('porta'));
  oAmbiente.UsuarioMaster:=FConfiguracao.GetConfiguracao('usuario');
  oAmbiente.Usuario:=FConfiguracao.GetConfiguracao('usuario');
  oAmbiente.SenhaMaster:=FConfiguracao.GetConfiguracao('senha');
  oAmbiente.Senha:=FConfiguracao.GetConfiguracao('senha');
  oAmbiente.BaseUsuario:=FConfiguracao.GetConfiguracao('base');
  oAmbiente.Conexao.Database:=oAmbiente.BaseUsuario;
  oAmbiente.Conexao.HostName:=oAmbiente.Endereco;
  oAmbiente.Conexao.Name:='ConexaoThread';
  oAmbiente.Conexao.Protocol:='postgresql';
  oAmbiente.Conexao.Password:=oAmbiente.SenhaMaster;
  oAmbiente.Conexao.Port:=oAmbiente.Porta;
  oAmbiente.Conexao.User:=oAmbiente.UsuarioMaster;
  Result:=oAmbiente.Conectar;

end;

constructor TControllerCadastros.Create(Conf: TControllerConfiguracao);
begin
  FConfiguracao:=Conf;
  fListaPortadores:=TObjectList<TPOrtadores>.Create;

end;

destructor TControllerCadastros.Destroy;
begin
  fListaPortadores.Clear;
  FreeAndNil(fListaPortadores);

  inherited;
end;

function TControllerCadastros.GetClientes(out Mensagem: String): String;
///////////////////////////////////////////////////////////////////////
var Query:TseQuery;
    Json:TJSONObject;
    fAmbiente:TseEnvironment;
    campos:string;
begin
  fAmbiente:=TseEnvironment.Create(Nil);
  fAmbiente.Conexao:=TZConnection.Create(Nil);
  Ambiente.ExecutaProcessaMensagem:=False;
  campos:='clie_codigo,clie_nome,clie_razaosocial,clie_cidade,clie_cnpjcpf';
  if ConfiguraConexao(fAmbiente) then begin
//    Query:=fAmbiente.IniciaQuery('select * from clientes where clie_nome<>'''' order by clie_nome');
    Query:=fAmbiente.IniciaQuery('select '+campos+' from clientes'+
           ' where length(clie_nome)>4'+
           ' group by clie_nome,clie_codigo,clie_razaosocial,clie_cidade,clie_cnpjcpf'+
           ' order by clie_nome');
    if Query.IsEmpty then begin
      Json:=TJSONObject.Create;
      Json.AddPair('error','sem clientes');
      Result:=Json.ToString;
      FreeAndNil(Json);
    end else begin
      Result:=Query.DataSetToJson('clientes');
    end;
    Query.Close;
  end else begin
    Json:=TJSONObject.Create;
    Json.AddPair('error','nao foi possivel conectar ao servidor');
    Result:=Json.ToString;
    FreeAndNil(Json);
  end;
  fAmbiente.Conexao.Disconnect;
  FreeAndNil(fAmbiente);
end;

// 20.12.24
function TControllerCadastros.GetCondicao(out Mensagem: String): String;
//////////////////////////////////////////////////////
var Query:TseQuery;
    Json:TJSONObject;
    fAmbiente:TseEnvironment;
    condicoes:string;
begin
  fAmbiente:=TseEnvironment.Create(Nil);
  fAmbiente.Conexao:=TZConnection.Create(Nil);
  Ambiente.ExecutaProcessaMensagem:=False;
  if ConfiguraConexao(fAmbiente) then begin
    condicoes:=FConfiguracao.GetConfiguracao('condicoes');
    if Trim(condicoes)='' then
      Query:=fAmbiente.IniciaQuery('select * from fpgto order by fpgt_descricao')
    else
      Query:=fAmbiente.IniciaQuery('select * from fpgto where '+Funcoes.GetIN('fpgt_codigo',condicoes,'C')+
                                     ' order by fpgt_descricao');
    if Query.IsEmpty then begin
      Json:=TJSONObject.Create;
      Json.AddPair('error','sem condição');
      Result:=Json.ToString;
      FreeAndNil(Json);
    end else begin
      Result:=Query.DataSetToJson('condicao');
    end;
    Query.Close;
  end else begin
    Json:=TJSONObject.Create;
    Json.AddPair('error','nao foi possivel conectar ao servidor');
    Result:=Json.ToString;
    FreeAndNil(Json);
  end;
  fAmbiente.Conexao.Disconnect;
  FreeAndNil(fAmbiente);
end;

function TControllerCadastros.GetConfig1AsString(NomeCampo: String): String;
var i:integer;
    Q:TseQuery;
    fAmbiente:TseEnvironment;
begin
  Result:='';
  NomeCampo:=Trim(UpperCase(NomeCampo));
  fAmbiente:=TseEnvironment.Create(Nil);
  fAmbiente.Conexao:=TZConnection.Create(Nil);
  Ambiente.ExecutaProcessaMensagem:=False;
  if ConfiguraConexao(fAmbiente) then begin
    Q:=fAmbiente.IniciaQuery('select * from config1');
    while not Q.Eof do begin
        if Q.GetString('cfg1_nome')=NomeCampo then begin
           Result:=Q.GetString('cfg1_conteudo');
           Break;
        end;
        Q.Next;
    end;
    Q.Close;
  end;
  fAmbiente.Conexao.Disconnect;
  FreeAndNil(fAmbiente);
end;

function TControllerCadastros.GetPortadores(out Mensagem: String): String;
var Query:TseQuery;
    Json:TJSONObject;
    fAmbiente:TseEnvironment;
begin
  fAmbiente:=TseEnvironment.Create(Nil);
  fAmbiente.Conexao:=TZConnection.Create(Nil);
  Ambiente.ExecutaProcessaMensagem:=False;
  if ConfiguraConexao(fAmbiente) then begin
    Query:=fAmbiente.IniciaQuery('select * from portadores order by port_descricao');
    if Query.IsEmpty then begin
      Json:=TJSONObject.Create;
      Json.AddPair('error','sem portadores');
      Result:=Json.ToString;
      FreeAndNil(Json);
    end else begin
      Result:=Query.DataSetToJson('portadores');
    end;
    Query.Close;
  end else begin
    Json:=TJSONObject.Create;
    Json.AddPair('error','nao foi possivel conectar ao servidor');
    Result:=Json.ToString;
    FreeAndNil(Json);
  end;
  fAmbiente.Conexao.Disconnect;
  FreeAndNil(fAmbiente);
end;

// 13.12.24
function TControllerCadastros.GetPrecos(out Mensagem: String): String;
////////////////////////////////////////////////////////////////////////////
var Query:TseQuery;
    Json:TJSONObject;
    fAmbiente:TseEnvironment;
    campos:string;
begin
  fAmbiente:=TseEnvironment.Create(Nil);
  fAmbiente.Conexao:=TZConnection.Create(Nil);
  Ambiente.ExecutaProcessaMensagem:=False;
  campos:='esqt_codigo,esqt_vendavis,esqt_qtde,esto_desconto';
  if ConfiguraConexao(fAmbiente) then begin
    Query:=fAmbiente.IniciaQuery('select '+campos+' from estoqueqtde where esqt_esto_codigo<>'''' order by esqt_esto_codigo');
    if Query.IsEmpty then begin
      Json:=TJSONObject.Create;
      Json.AddPair('error','sem preços de produtos');
      Result:=Json.ToString;
      FreeAndNil(Json);
    end else begin
      Result:=Query.DataSetToJson('precos');
    end;
    Query.Close;
  end else begin
    Json:=TJSONObject.Create;
    Json.AddPair('error','nao foi possivel conectar ao servidor');
    Result:=Json.ToString;
    FreeAndNil(Json);
  end;
  fAmbiente.Conexao.Disconnect;
  FreeAndNil(fAmbiente);
end;

function TControllerCadastros.GetProdutos(out Mensagem: String): String;
///////////////////////////////////////////////////////////////////////
var Query:TseQuery;
    Json:TJSONObject;
    fAmbiente:TseEnvironment;
    campos:string;
begin
  fAmbiente:=TseEnvironment.Create(Nil);
  fAmbiente.Conexao:=TZConnection.Create(Nil);
  Ambiente.ExecutaProcessaMensagem:=False;
  campos:='esto_codigo,esto_descricao,esto_unidade,esto_imagem,'+
          'esqt_qtde,esqt_vendavis,esto_desconto';
  if ConfiguraConexao(fAmbiente) then begin
    Query:=fAmbiente.IniciaQuery('select '+campos+' from estoque'+
           ' inner join estoqueqtde on ( esqt_esto_codigo=esto_codigo )'+
           ' where esto_descricao<>'''''+
           ' and esqt_unid_codigo = ''001'''+
           ' order by esto_descricao');
    if Query.IsEmpty then begin
      Json:=TJSONObject.Create;
      Json.AddPair('error','sem produtos');
      Result:=Json.ToString;
      FreeAndNil(Json);
    end else begin
      Result:=Query.DataSetToJson('produtos');
    end;
    Query.Close;
  end else begin
    Json:=TJSONObject.Create;
    Json.AddPair('error','nao foi possivel conectar ao servidor');
    Result:=Json.ToString;
    FreeAndNil(Json);
  end;
  fAmbiente.Conexao.Disconnect;
  FreeAndNil(fAmbiente);
end;

// 01.10.25
function TControllerCadastros.IncluiPedido(out Mensagem: String;Body:String): String;
////////////////////////////////////////////////////////////////
var Query,
    QCliente:TseQuery;
    Json,
    Dados:TJSONObject;
//    DadosPedido:TdJSON;
//    DadosPedido:TJSONObject;
    DadosPedido:TJSONValue;
    ItensPedido:TJSONArray;
    fAmbiente:TseEnvironment;
    campos,
    transacao,
    operacao,
    codigounidade,
    portadorboleto:string;
    pedcliente,
    codcliente,
    numpedido,
    p            :integer;
    data         :TDateTime;
    valorpedido  :Double;

begin
  fAmbiente:=TseEnvironment.Create(Nil);
  fAmbiente.Conexao:=TZConnection.Create(Nil);
  Ambiente.ExecutaProcessaMensagem:=False;
  if ConfiguraConexao(fAmbiente) then begin
//    Dados := Body;
//    DadosPedido := TdJson.Parse(Body);
    DadosPedido := TJSONObject.ParseJSONValue(Body,False,false);
    pedcliente  := DadosPedido.GetValue<integer>('mped_numerodoc');
    data        := DadosPedido.GetValue<TDate>('mped_datamvto');
    codcliente  := DadosPedido.GetValue<integer>('mped_tipo_codigo');
    valorpedido := DadosPedido.GetValue<Double>('mped_vlrtotal');
    campos:='mped_numerodoc,mped_datamvto,mped_pedcliente,mped_tipo_codigo';
    Query:=fAmbiente.IniciaQuery('select '+campos+' from movped where mped_datamvto = '+Funcoes.DateToSql(data)+
                                 ' and mped_pedcliente = '+IntToStr(pedcliente)+
                                 ' and mped_status = ''N'''+
                                 ' and mped_vlrtotal = '+Funcoes.Valortosql( valorpedido )+
                                 ' and mped_tipo_codigo = '+IntToStr(codcliente) );
    Json:=TJSONObject.Create;
    if Query.IsEmpty then begin
      codigounidade := FConfiguracao.GetConfiguracao('unidade');
      numpedido     := PegaSequenciaPostgreSql('pedvenda',true);
      PortadorBoleto:= GetConfig1AsString( 'Portaboletos' );
      campos:='clie_uf,clie_cida_codigo_res,clie_repr_codigo,repr_nome';
      QCliente:=fAmbiente.IniciaQuery('select '+campos+' from clientes'+
                                      ' left join representantes on repr_codigo=clie_repr_codigo'+
                                      ' where clie_codigo='+IntToStr(codcliente));
      if trim(codigounidade)='' then codigounidade:='001';
      transacao:=IntToStr(PegaSequenciaPostgreSql('Transacao'+CodigoUnidade ,true));
      transacao:=codigounidade+transacao;
      transacao:=transacao+funcoes.GetDigito(transacao,'MOD');
      operacao:=transacao+'1';
      fAmbiente.Incluir('movped');
      fAmbiente.SetaCampo('mped_numerodoc',numpedido);
      fAmbiente.SetaCampo('mped_datamvto',data);
      fAmbiente.SetaCampo('mped_datalcto',Date);
      fAmbiente.SetaCampo('mped_tipo_codigo',codcliente);
      fAmbiente.SetaCampo('mped_tipocad','C');
      fAmbiente.SetaCampo('mped_unid_codigo',codigounidade);
      fAmbiente.SetaCampo('mped_vlrtotal',valorpedido);
      fAmbiente.SetaCampo('mped_fpgt_codigo',DadosPedido.GetValue<string>('mped_fpgt_codigo'));
      fAmbiente.SetaCampo('mped_port_codigo',DadosPedido.GetValue<string>('mped_port_codigo'));
      fAmbiente.SetaCampo('mped_fpgt_prazos',DadosPedido.GetValue<string>('mped_fpgt_prazos'));
      fAmbiente.SetaCampo('mped_status','N');
      fAmbiente.SetaCampo('mped_transacao',transacao);
      fAmbiente.SetaCampo('mped_operacao',operacao);
      fAmbiente.SetaCampo('mped_tipomov',DadosPedido.GetValue<string>('mped_tipomov'));
      if AnsiPos( DadosPedido.GetValue<string>('mped_port_codigo'), PortadorBoleto ) > 0 then
         fAmbiente.SetaCampo('mped_datacont',data);
      fAmbiente.SetaCampo('mped_usua_codigo',990);
      fAmbiente.SetaCampo('mped_pedcliente',pedcliente);
      fAmbiente.SetaCampo('mped_estado',QCliente.fieldbyname('clie_uf').asstring);
      fAmbiente.SetaCampo('mped_cida_codigo',QCliente.fieldbyname('clie_cida_codigo_res').asinteger);
      fAmbiente.SetaCampo('mped_repr_codigo',QCliente.fieldbyname('clie_repr_codigo').asinteger);
      fAmbiente.SetaCampo('mped_tipocad','C');
      fAmbiente.SetaCampo('mped_dataemissao',Data);
      fAmbiente.SetaCampo('mped_totprod',valorpedido);
      fAmbiente.SetaCampo('mped_vispra','P');
      fAmbiente.SetaCampo('mped_situacao','P');
      fAmbiente.SetaCampo('mped_envio','R');
      fAmbiente.SetaCampo('mped_obspedido','Vendas Movel '+QCliente.fieldbyname('repr_nome').asstring);
//      fAmbiente.SetaCampo('mped_contatopedido',xxx); // ver uso futuro...
      fAmbiente.Post();
      fAmbiente.CommitParc;
      ItensPedido := DadosPedido.GetValue<TJSONArray>('Itens');
      for p := 0 to Pred(ItensPedido.Count) do begin
         fAmbiente.Incluir('movpeddet');
         fAmbiente.SetaCampo('mpdd_numerodoc',numpedido);
         fAmbiente.SetaCampo('mpdd_datamvto',data);
         fAmbiente.SetaCampo('mpdd_tipo_codigo',codcliente);
         fAmbiente.SetaCampo('mpdd_esto_codigo',ItensPedido.Items[p].GetValue<string>('mpdd_esto_codigo'));
         fAmbiente.SetaCampo('mpdd_qtde',ItensPedido.Items[p].GetValue<Double>('mpdd_qtde'));
         fAmbiente.SetaCampo('mpdd_venda',ItensPedido.Items[p].GetValue<Double>('mpdd_venda'));
         operacao:=transacao+funcoes.strzero(p,2);
         fAmbiente.SetaCampo('mpdd_transacao',transacao);
         fAmbiente.SetaCampo('mpdd_operacao',operacao);
         fAmbiente.SetaCampo('mpdd_status','N');
         fAmbiente.SetaCampo('mpdd_unid_codigo',CodigoUnidade);
         fAmbiente.SetaCampo('mpdd_datalcto',Date);
         fAmbiente.SetaCampo('mpdd_tipomov',DadosPedido.GetValue<string>('mped_tipomov'));
         if AnsiPos( DadosPedido.GetValue<string>('mped_port_codigo'), PortadorBoleto ) > 0 then
            fAmbiente.SetaCampo('mpdd_datacont',data);
         fAmbiente.SetaCampo('mpdd_usua_codigo',990);
         fAmbiente.SetaCampo('mpdd_repr_codigo',QCliente.fieldbyname('clie_repr_codigo').asinteger);
         fAmbiente.SetaCampo('mpdd_tipocad','C');
         fAmbiente.SetaCampo('mpdd_emlinha','S');
         fAmbiente.SetaCampo('mpdd_qtdeenviada',0);
         fAmbiente.SetaCampo('mpdd_vendabru',ItensPedido.Items[p].GetValue<Double>('mpdd_venda'));
//        Sistema.SetField('mpdd_perdesco',Texttovalor(Grid.cells[Grid.getcolumn('perdesconto'),linha]));
         fAmbiente.SetaCampo('mpdd_situacao','P');
         fAmbiente.SetaCampo('mpdd_seq',p+1 );
         fAmbiente.SetaCampo('mpdd_transacaonftrans',pedcliente);
         fAmbiente.Post();
         fAmbiente.CommitParc;
      end;
      try
        fAmbiente.Commit();
        Json.AddPair('OK','pedido incluido');
      except
        Json.AddPair('Erro','pedido não gravado');
      end;
      QCliente.Close;

    end else begin
      Json.AddPair('Atenção','pedido já existente deste cliente nesta data');
    end;
    Result:=Json.ToString;
    Query.Close;
    FreeAndNil(Json);
  end else begin
    Json:=TJSONObject.Create;
    Json.AddPair('error','nao foi possivel conectar ao servidor');
    Result:=Json.ToString;
    FreeAndNil(Json);
  end;
  fAmbiente.Conexao.Disconnect;
  FreeAndNil(fAmbiente);
end;

function TControllerCadastros.PegaSequenciaPostgreSql(NomeSequencia: String; const Incrementar: Boolean): Integer;
var QuerySeq,QueryInc:TseQuery;
    iResult:Integer;
    fAmbienteSeq:TseEnvironment;
begin
  iResult:=0;
  fAmbienteSeq:=TseEnvironment.Create(Nil);
  fAmbienteSeq.Conexao:=TZConnection.Create(Nil);
  Ambiente.ExecutaProcessaMensagem:=False;
  if ConfiguraConexao(fAmbienteSeq) then begin
    try
      QuerySeq:=FAmbienteSeq.IniciaQuery('select * from pg_class where relname='+Funcoes.AddQuote(LowerCase(NomeSequencia))+' and relkind=''S''');
      if not QuerySeq.IsEmpty then begin
        if Incrementar then begin
          QueryInc:=FAmbienteSeq.IniciaQuery('select nextval('''+NomeSequencia+''') as proximo');
          iResult:=QueryInc.GetInteger('proximo');
          QueryInc.Close;
        end else begin
          try
            QueryInc:=FAmbienteSeq.IniciaQuery('select last_value as proximo from '+NomeSequencia);
            iResult:=QueryInc.GetInteger('proximo');
            QueryInc.Close;
          except
          end;
        end;
      end else begin
         FAmbienteSeq.ExecutaComandoSql('create sequence '+NomeSequencia);
         if Incrementar then begin
           QueryInc:=FAmbienteSeq.IniciaQuery('select nextval('''+NomeSequencia+''') as proximo');
           iResult:=QueryInc.GetInteger('proximo');
           QueryInc.Close;
         end;
      end;
      QuerySeq.Close;
    except
      QuerySeq.Close;
      QueryInc:=FAmbienteSeq.IniciaQuery('select nextval('''+NomeSequencia+''') as proximo');
      iResult:=QueryInc.GetInteger('proximo');
      QueryInc.Close;
    end;
  end;
  Result:=iResult;
  fAmbienteSeq.Conexao.Disconnect;
  FreeAndNil(fAmbienteSeq);
end;

end.
