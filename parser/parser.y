%{
  package parser
%}

%union{
  reg         int32
  id          string
}

%token Error
%token OpenParen CloseParen Comma
%token Temporary Identifier Number
%token OpAddressOf
%token OpConstInt

%token OpLabel OpGoto OpGotoIfFalse OpGotoIfTrue
%token OpProcBegin OpProcEnd
%token OpPhi

%token OpLoadWord OpLoadHalfWord OpLoadSignedHalfWord OpLoadByte OpLoadSignedByte
%token OpStoreWord OpStoreHalfWord OpStoreByte

%token OpMultSignedWord OpMultUnsignedWord
%token OpDivSignedWord OpDivUnsignedWord
%token OpRemSignedWord OpRemUnsignedWord
%token OpAddSignedWord OpAddUnsignedWord
%token OpSubSignedWord OpSubUnsignedWord
%token OpLeftShiftWord OpRightShiftSignedWord OpRightShiftUnsignedWord
%token OpLtSignedWord OpLtUnsignedWord
%token OpLeSignedWord OpLeUnsignedWord
%token OpGeSignedWord OpGeUnsignedWord
%token OpGtSignedWord OpGtUnsignedWord
%token OpEqWord OpNeWord
%token OpBitwiseAndWord OpBitwiseXorWord OpBitwiseOrWord
%token OpUnaryMinus OpUnaryLogicalNegation OpUnaryBitwiseNegation

%token OpCastWordToHalfWord OpCastWordToByte OpCastHalfWordToUnsignedWord
%token OpCastHalfWordToSignedWord OpCastByteToUnsignedWord OpCastByteToSignedWord

%%

program
  : procedure_list;

procedure_list
  : procedure
  | procedure_list procedure;

procedure
  : proc_begin statement_list proc_end;

proc_begin
  : OpenParen OpProcBegin Comma Identifier CloseParen;

proc_end
  : OpenParen OpProcEnd CloseParen;

statement_list
  : statement
  | statement_list statement;

statement
  // (addressOf, t0, potato)
  : OpenParen OpAddressOf Comma Temporary Comma Identifier CloseParen
  // (loadWord, t0, t1)
  | OpenParen OpLoadWord Comma Temporary Comma Temporary CloseParen;

%%

//func (l *Lexer) Lex(lval *yySymType) int {
//}
