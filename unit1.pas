unit Unit1;

{$mode objfpc}{$H+}

{.$define NO_SMARTPTR}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, Menus, ExtCtrls, Spin, MaskEdit, SynEdit,
  IniFiles, Types, WinInet, MMSystem,  DateUtils, md5, Math;

type
  TEstadoBot = (stCaminhando, stLutando, stColetando, stEsc, stWait, stUMob);

  { Definição das Threads }       //procedure comobopvpThread.Execute;
  TcomobopvpThread = class(TThread)
  protected procedure Execute; override; end;

  TAtkThread = class(TThread)
  protected procedure Execute; override; end;

  THealThreadPot = class(TThread)
  protected procedure Execute; override; end;

  THealThreadFruit = class(TThread)
  protected procedure Execute; override; end;

  TComboThread = class(TThread)
  protected procedure Execute; override; end;

  TFishingThread = class(TThread)
  protected procedure Execute; override; end;

  TCaveThread = class(TThread)
  private
  WptBitmaps: array[1..18] of TBitmap;
  protected procedure Execute; override; end;

  TBuffThread = class(TThread)
    private
      { Variavel movida para private para durar o tempo de vida da thread }
      vBuffBitmaps: array[1..3, 1..2] of TBitmap;
    protected
      procedure Execute; override;
    public
      { Opcional: procedimento para destruir os bitmaps ao fechar o bot }
      destructor Destroy; override;
    end;

  { TForm1 }
  TForm1 = class(TForm)
    Button3: TButton;
    btmid: TButton;
    editStop: TEdit;
    editstart: TEdit;
    editkeycombo: TEdit;
    editkeydrop: TEdit;
    edithotkeyget: TEdit;
    btPickUp: TButton;
    btThrow: TButton;
    Buff2Name1: TEdit;
    Buff2Name2: TEdit;
    Buff3Name1: TEdit;
    Buff3Name2: TEdit;
    Button1: TButton;
    Button2: TButton;
    btcrdBL: TButton;
    cbbuff1: TComboBox;
    cbbuff2: TComboBox;
    cbbuff3: TComboBox;
    CheckAtk: TCheckBox;
    ckActCombo: TCheckBox;
    CkHwhd: TCheckBox;
    ckfishing: TCheckBox;
    CkBuff1: TCheckBox;
    CkBuff2: TCheckBox;
    CkBuff3: TCheckBox;
    CkBuffs: TCheckBox;
    ckcavebot: TCheckBox;
    ckcombo: TCheckBox;
    ckheal: TCheckBox;
    CkMouse: TCheckBox;
    ckpickup: TCheckBox;
    CkStopMob: TCheckBox;
    Buff1Name1: TEdit;
    Buff1Name2: TEdit;
    ckthrow: TCheckBox;
    Label1: TLabel;
    Label10: TLabel;
    lbmid: TLabel;
    lbcrdBu: TLabel;
    lbcrdBL: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbPick1: TLabel;
    lbThrow: TLabel;
    MEtimeBuff1: TMaskEdit;
    MEtimeBuff2: TMaskEdit;
    MEtimeBuff3: TMaskEdit;
    NameBuff: TEdit;
    { Painéis e Layout }
    PageControl1: TPageControl;
    Atk, Healing, Combo, Fishing, CaveBot: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    PnLateral: TPanel;
    Buffs: TTabSheet;
    PrdMana: TRadioButton;
    PrdLifePot: TRadioButton;
    Main: TTabSheet;
    Hotkey: TTabSheet;
    TP_wayp: TPanel;

    { Botões de Comando }
    BtStart, BtStop, BtHide: TButton;
    btcor, btinf, btsup: TButton;
    btml, btmana, btlp, btfruit: TButton;
    btsupF, btinfF, btsupF1, btinfF1: TButton;
    btmapl, btmapr: TButton;
    bt_l1, bt_l2, bt_l3, bt_l4, bt_l5, bt_l6, bt_l7, bt_l8: TButton;

    { CheckBoxes - Sistema e Cura }
    ckml, ckft, cklp, ckmp: TCheckBox;
    ckfishing2: TCheckBox;
    ckcoleta, ckCLoot, ckEsc, ckumb, ckNTp: TCheckBox;

    { CheckBoxes - Combo (Magias) }
    ckmg1, ckmg2, ckmg3, ckmg4, ckmg5, ckmg6: TCheckBox;

    { CheckBoxes - Waypoints (1-18) }
    ckwpt1, ckwpt2, ckwpt3, ckwpt4, ckwpt5, ckwpt6, ckwpt7, ckwpt8, ckwpt9,
    ckwpt10, ckwpt11, ckwpt12, ckwpt13, ckwpt14, ckwpt15, ckwpt16, ckwpt17, ckwpt18: TCheckBox;
    TsMsAtk: TSpinEdit;

    { SpinEdits (Tempos e Delays) }
    TsMsHeal, TsCombo, stimeloot, sUtime: TSpinEdit;
    MinFishing, MaxFishing: TSpinEdit;
    SWpt1, SWpt2, SWpt3, SWpt4, SWpt5, SWpt6, SWpt7, SWpt8, SWpt9,
    SWpt10, SWpt11, SWpt12, SWpt13, SWpt14, SWpt15, SWpt16, SWpt17, SWpt18: TSpinEdit;

    { ComboBoxes (Hotkeys) }
    cbml, cbmp, cblp, cbfta: TComboBox;
    Mg1, Mg2, Mg3, Mg4, Mg5, Mg6: TComboBox;

    { Labels de Status e Coordenadas }
    lbStatus, lbcor, lbcrds, lbcrdi: TLabel;
    lbml, lbft, lblp, lbmp: TLabel;
    lbfishingsup, lbfishinginf, lbfishingsup1, lbfishinginf1: TLabel;
    lbLmap, lbRmap, lblExpand: TLabel;
    lblCoordenadas, lblCor, lblJanela: TLabel;
    Label2, Label3, Label4, Label5, Label6, Label7: TLabel;
    UpdateAtk: TButton;
    UpdateBuff: TButton;
    UpdateCave: TButton;
    UpdateCombo: TButton;
    Updatefishing: TButton;
    UpdateHeal: TButton;

    { Procedimentos do Form }
    procedure btcrdBLClick(Sender: TObject);
    procedure btmidClick(Sender: TObject);
    procedure btPickUpClick(Sender: TObject);
    procedure btThrowClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure edithotkeygetClick(Sender: TObject);
    procedure edithotkeygetKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edithotkeygetMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
     procedure comboativo;
    procedure editkeycomboClick(Sender: TObject);
    procedure editkeycomboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editkeycomboMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure editkeydropClick(Sender: TObject);
    procedure editkeydropKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editkeydropMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure editstartClick(Sender: TObject);
    procedure editstartKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editstartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure editStopClick(Sender: TObject);
    procedure editStopKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure editStopMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure CarregarConfig;
    procedure FormDestroy(Sender: TObject);
    procedure SalvarConfig;
    procedure BotStart;
    procedure BotStop;
    procedure hotkeys;
    procedure unregister;
    function  ObterHashLicencaFinal: string;
    function  OfuscarSerial(SerialOriginal: string): string;
    procedure BtStartClick(Sender: TObject);
    procedure BtStopClick(Sender: TObject);
    procedure BtHideClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblExpandClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btcorClick(Sender: TObject);
    procedure btsupClick(Sender: TObject);
    procedure btinfClick(Sender: TObject);
    procedure btmlClick(Sender: TObject);
    procedure btmanaClick(Sender: TObject);
    procedure btlpClick(Sender: TObject);
    procedure btfruitClick(Sender: TObject);
    procedure btsupFClick(Sender: TObject);
    procedure btinfFClick(Sender: TObject);
    procedure btsupF1Click(Sender: TObject);
    procedure btinfF1Click(Sender: TObject);
    procedure btmaplClick(Sender: TObject);
    procedure btmaprClick(Sender: TObject);
    procedure bt_l1Click(Sender: TObject); procedure bt_l2Click(Sender: TObject);
    procedure bt_l3Click(Sender: TObject); procedure bt_l4Click(Sender: TObject);
    procedure bt_l5Click(Sender: TObject); procedure bt_l6Click(Sender: TObject);
    procedure bt_l7Click(Sender: TObject); procedure bt_l8Click(Sender: TObject);
    procedure UpdateAtkClick(Sender: TObject);
    procedure UpdateBuffClick(Sender: TObject);
    procedure UpdateCaveClick(Sender: TObject);
    procedure UpdateComboClick(Sender: TObject);
    procedure UpdatefishingClick(Sender: TObject);
    procedure UpdateHealClick(Sender: TObject);
    procedure ProcessarHotkey(Codigo: Word; Tipo: Byte; NomeMouse: string);
    procedure EnviarHotkeyAtiva(Tecla: Word);

  private

    procedure WMHotKey(var Msg: TMessage); message WM_HOTKEY;
    {-----------------------------------------------------------------------}

    const
         VERSAO_LOCAL = '1.2.0'; // Mude aqui a cada atualização

    {------------------------------------------------------------------------}
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
  public
  end;

  { Declaração de Funções e Procedures Globais }
  function GetHWID: string;
  function AutenticarHardware: Boolean;
  function CheckPixelRel(X, Y: Integer; Cor: TColor; Tol: Integer): Boolean;
  function FindColorRel(H: HWND; X1, Y1, X2, Y2: Integer; CorAlvo: TColor; out FoundX, FoundY: Integer): Boolean;
  function FindImage(StartX, StartY, EndX, EndY: Integer; Target: TBitmap; Accuracy, Deviation: Integer): Boolean;
  procedure EnviarHotkey(Tecla: Byte);
  function TextoParaTecla(Texto: String): Byte;
  procedure MoverEClicar(H: HWND; X, Y: Integer);
  procedure MoverEClicarDireito(H: HWND; X, Y: Integer);
var
  Form1: TForm1;

  { Instâncias das Threads }
  MinhaThreadFruit: THealThreadFruit;
  MinhaThreadPot: THealThreadPot;
  MeuAtkThread: TAtkThread;
  MeuComboThread: TComboThread;
  MeuFishingThread: TFishingThread;
  MeuCaveThread: TCaveThread;
  MeuBuffThread: TBuffThread;
  ComobopvpThread: TComobopvpThread;

  { Controle de Estados e Loops }
  BotRodando: Boolean;
  EstadoBot: TEstadoBot;
  WptIndex: Integer = 1;
  SlotAtual: Integer = 1;
  PassoCombo, PassoFish: Integer;

  { Timers e Ticks (QWord para GetTickCount64) }
  UltimoTick, UltimoAtaque, UltimaPot, UFruit, UCombo, AlarmeFish, ProximoClique: QWord;
  TempoTotalEspera: Integer;

  { Coordenadas e Janela }
  H_Jogo: HWND;
  X_ft, Y_ft, X_lp, Y_lp, X_Mp, Y_Mp, X_Ml, Y_Ml, xget, yget, xdrop, ydrop, x_obj, y_obj: Integer;
  X_SupAtk, Y_SupAtk, X_InfAtk, Y_InfAtk, X_MidAtk, Y_MidAtk: Integer;
  X_F1, Y_F1, X_F2, Y_F2, X_F1b, Y_F1b, X_F2b, Y_F2b: Integer;
  lxm, lym, rxm, rym, X_C, Y_C, X_Temp, Y_Temp, lxb, lyb, rxb, ryb: Integer;
  LX, LY: array[1..8] of Integer;
  timebuff: array[1..3] of Qword;

    // Canto superior esquerdo da captura (relativo à janela H_Jogo)
  X_Gath_A, Y_Gath_A: Integer;
  // Centro (personagem) relativo à janela H_Jogo
  X_Gath_B, Y_Gath_B: Integer;
  // Zona prioritária (acima/esquerda do personagem) relativo à janela H_Jogo
  X_Gath_C, Y_Gath_C: Integer;

  { Cores e Tempos }
  CorAtk, Corft, Corlp, CorMp, CorMl, CorBox: TColor;
  MsAtk, MsHeal, MsCombo, MsBot, MsUtime, vstimeloot, vsUtime: Integer;
  vMinFish, vMaxFish, Level, midx, midy: Integer;

  { Configurações Espelhadas (Booleanas e Strings) }
  vckatk, vckheal, vckml, vckmp, vcklp, vckft, vckcombo, vckmg1, vckmg2, vckmg3,
  vckmg4, vckmg5, vckmg6, vckfishing, vckfishing2, vckcoleta, vckcloot, vcknxtp,
  vckcavebot, vckesc, vckumb, vckNTp, vCkStopMob, vCkMouse, vPrdMana,
  vPrdLifePot, vCkHwhd, vckcomboPVP, vckpickup, vckthrow: Boolean;

  vchkwpt: array[1..18] of Boolean;
  vTimeWpt: array[1..18] of Integer;

  vckBuff: array[1..3] of Boolean;
  vBuffName: array[1..6] of String;
  vBuffhk: array[1..3] of string;
  vbuffTime, vbuffTimea: array[1..3] of integer;
  vCkBuffs: Boolean;
  MinhaHotkeyCodigo, hotkeyget, hotkeystart, hotkeydrop, hotkeycombo,
  codmouseget, codmousecombo, codmousedrop,
  codmousestart, hotkeystop, codmousestop: Word;
  namehotkey: string;
  ativo: integer;

  HotHeal, HotMana, HotFruit, HotCombo: String;
  HotMg1, HotMg2, HotMg3, HotMg4, HotMg5, HotMg6: String;
  CaminhoImagens: string;
  comboa: integer;

implementation

{$R *.lfm}
{ --- FUNÇÕES DE SUPORTE E SISTEMA --- }

procedure TForm1.EnviarHotkeyAtiva(Tecla: Word);
var
  H_Ativo: HWND;
  Scan: UINT;
begin
  if Tecla = 0 then Exit;

  // Pega a janela que está em primeiro plano exatamente AGORA
  H_Ativo := GetForegroundWindow;
  if H_Ativo = 0 then Exit;

  Scan := MapVirtualKey(Tecla, 0);
  Sleep(20);
  // Envia os comandos direto para a janela ativa
  PostMessage(H_Ativo, WM_KEYDOWN, Tecla, (Scan shl 16));
  PostMessage(H_Ativo, WM_KEYUP, Tecla, (Scan shl 16) or $C0000000);
end;

procedure getitem(X, Y: Integer);
var
  Pm: TPoint;
  Xm, Ym: integer;
begin
    if H_Jogo = 0 then Exit;

    GetCursorPos(Pm);
    H_Jogo := GetAncestor(WindowFromPoint(Pm), GA_ROOT);
    Windows.ScreenToClient(H_Jogo, Pm); Xm := Pm.X; Ym := Pm.Y;

    PostMessage(H_Jogo, WM_LBUTTONDOWN, MK_LBUTTON, MakeLParam(Xm, Ym));
    PostMessage(H_Jogo, WM_MOUSEMOVE, 0, MakeLParam(X, Y));
    PostMessage(H_Jogo, WM_LBUTTONUP, 0, MakeLParam(X, Y));
end;

procedure droptitem(X, Y:Integer);
var
   Pm: TPoint;
   Xm, Ym: integer;
begin
    if H_Jogo = 0 then Exit;

    GetCursorPos(Pm);
    H_Jogo := GetAncestor(WindowFromPoint(Pm), GA_ROOT);
    Windows.ScreenToClient(H_Jogo, Pm); Xm := Pm.X; Ym := Pm.Y;
    sleep(5);
    PostMessage(H_Jogo, WM_MOUSEMOVE, 0, MakeLParam(X, Y));
    PostMessage(H_Jogo, WM_LBUTTONDOWN, MK_LBUTTON, MakeLParam(X, Y));
    sleep(15);
    PostMessage(H_Jogo, WM_MOUSEMOVE, 0, MakeLParam(Xm, Ym));
    PostMessage(H_Jogo, WM_LBUTTONUP, 0, MakeLParam(Xm, Ym));
end;

procedure TForm1.ProcessarHotkey(Codigo: Word; Tipo: Byte; NomeMouse: string);
var
  ScanCode: LongInt;
  Buffer: array[0..255] of Char;
begin
  MinhaHotkeyCodigo := Codigo;

  // SE FOR TECLADO (Tipo = 0)
  if Tipo = 0 then
  begin
    ScanCode := MapVirtualKey(Codigo, 0) shl 16;

    if Codigo in [VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN, VK_PRIOR, VK_NEXT, VK_END, VK_HOME, VK_INSERT, VK_DELETE, VK_DIVIDE, VK_CANCEL] then
      ScanCode := ScanCode or $1000000;

    if GetKeyNameText(ScanCode, Buffer, SizeOf(Buffer)) > 0 then
      namehotkey := string(Buffer)
    else
      namehotkey := IntToStr(Codigo); // Convertido número para texto!
  end
  // SE FOR MOUSE (Tipo = 1)
  else if Tipo = 1 then
  begin
    // Recebe o texto pronto do evento do mouse, sem tentar adivinhar número
    namehotkey := NomeMouse;
  end;
end;

function MakeLParam(Lo, Hi: Word): LPARAM;
begin
  Result := LPARAM(LongWord(Lo) or (LongWord(Hi) shl 16));
end;

// 1. Sua função original para pegar o Serial do HD C:
function GetHWID: string;
var
  VolumeSerialNumber: DWORD;
  MaximumComponentLength, FileSystemFlags: DWORD;
begin
  Result := '';
  if GetVolumeInformation('C:\', nil, 0, @VolumeSerialNumber, MaximumComponentLength, FileSystemFlags, nil, 0) then
    Result := IntToHex(VolumeSerialNumber, 8);
end;

// 2. A criptografia intermediária personalizada (Embaralha o Serial)
function TForm1.OfuscarSerial(SerialOriginal: string): string;
var
  i: Integer;
  ChaveSecreta: string;
  LetraAtual: Char;
begin
  Result := '';
  // Esta é a sua chave secreta. Mude para o que quiser, mas nunca mude após lançar o bot!
  ChaveSecreta := 'B0t@2026_X';

  for i := 1 to Length(SerialOriginal) do
  begin
    // Passo A: Faz um XOR entre o caractere do serial e o caractere da sua chave
    // Passo B: Desloca o valor do caractere (+5 posições na tabela ASCII) para distorcer ainda mais
    LetraAtual := Chr((Ord(SerialOriginal[i]) xor Ord(ChaveSecreta[((i - 1) mod Length(ChaveSecreta)) + 1])) + 5);

    // Acumula o resultado transformando em Hexadecimal para manter o texto limpo
    Result := Result + IntToHex(Ord(LetraAtual), 2);
  end;
end;

// 3. A função principal que junta tudo e entrega o MD5 Final
function TForm1.ObterHashLicencaFinal: string;
var
  SerialHD: string;
  SerialEmbaralhado: string;
begin
  // Busca o HWID (Ex de retorno: "A1B2C3D4")
  SerialHD := GetHWID;

  if SerialHD <> '' then
  begin
    // Passa pela criptografia intermediária (Transforma "A1B2C3D4" em algo como "4F7A1B...")
    SerialEmbaralhado := OfuscarSerial(SerialHD);

    // Passa o resultado criptografado pelo MD5
    Result := MD5Print(MD5String(SerialEmbaralhado));
  end
  else
  begin
    Result := 'ERRO_HARDWARE'; // Caso não consiga ler o HD
  end;
end;

function MascaraParaMS(Texto: string): Integer;
var
  Hora: TDateTime;
begin
  try
    // Converte "00:00:10" para TDateTime e depois para total de milissegundos
    Hora := StrToTime(Texto);
    Result := SecondsBetween(Hora, 0) * 1000;
  except
    Result := 0;
  end;
end;

function BaixarTextoWeb(URL: string): string;
var
  NetHandle, UrlHandle: HINTERNET;
  Buffer: array[0..1024] of Char;
  BytesRead: DWORD;
begin
  Result := '';
  // INTERNET_OPEN_TYPE_DIRECT força a conexão sem passar por proxies locais que podem ter cache
  NetHandle := InternetOpen('MacroBot', INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
  if Assigned(NetHandle) then begin
    // Adicionamos flags que obrigam o Windows a baixar o arquivo do zero
    UrlHandle := InternetOpenUrl(NetHandle, PChar(URL), nil, 0,
        INTERNET_FLAG_RELOAD or           // Força download do servidor
        INTERNET_FLAG_PRAGMA_NOCACHE or    // Impede cache de proxy
        INTERNET_FLAG_NO_CACHE_WRITE, 0);  // Não salva no cache local

    if Assigned(UrlHandle) then begin
      repeat
        InternetReadFile(UrlHandle, @Buffer, SizeOf(Buffer)-1, BytesRead);
        if BytesRead > 0 then begin
          Buffer[BytesRead] := #0;
          Result := Result + StrPas(Buffer);
        end;
      until BytesRead = 0;
      InternetCloseHandle(UrlHandle);
    end;
    InternetCloseHandle(NetHandle);
  end;
end;

function BaixarComData(URL: string; out DataServer: TDateTime): string;
var
  NetHandle, UrlHandle: HINTERNET;
  Buffer: array[0..1024] of Char;
  BytesRead: DWORD;
  Header: array[0..255] of Char;
  HeaderLen, Index: DWORD;
  st: TSystemTime; // Variável temporária para o formato do Windows
begin
  Result := '';
  DataServer := 0;
  NetHandle := InternetOpen('MacroBot', INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
  if Assigned(NetHandle) then begin
    UrlHandle := InternetOpenUrl(NetHandle, PChar(URL), nil, 0,
      INTERNET_FLAG_RELOAD or INTERNET_FLAG_PRAGMA_NOCACHE or INTERNET_FLAG_NO_CACHE_WRITE, 0);

    if Assigned(UrlHandle) then begin
      HeaderLen := SizeOf(Header);
      Index := 0;
      // 1. Pega a string do Header
      if HttpQueryInfo(UrlHandle, HTTP_QUERY_DATE, @Header, HeaderLen, Index) then
      begin
        // 2. Converte a string do Header para TSystemTime
        if InternetTimeToSystemTime(PChar(StrPas(Header)), @st, 0) then
          // 3. Converte TSystemTime para o TDateTime do Lazarus
          DataServer := SystemTimeToDateTime(st);
      end;

      repeat
        InternetReadFile(UrlHandle, @Buffer, SizeOf(Buffer)-1, BytesRead);
        if BytesRead > 0 then begin
          Buffer[BytesRead] := #0;
          Result := Result + StrPas(Buffer);
        end;
      until BytesRead = 0;
      InternetCloseHandle(UrlHandle);
    end;
    InternetCloseHandle(NetHandle);
  end;
end;

function AutenticarHardware: Boolean;
var
  Conteudo, RespostaData, MeuHWID, Linha, VersaoGist: string;
  Dados, ListaLinhas: TStringList;
  DataLimite, DataInternet: TDateTime;
  UrlGist, Nome, DataStr, Nivel: string;
  Dias: Integer;
begin
  Result := False;
  MeuHWID := Form1.ObterHashLicencaFinal;
  DataInternet := 0;

  UrlGist := 'https://gist.githubusercontent.com/Duendenoiado/bad687d593f78c1f85e389ecbb0ac23c/raw/acesso.txt?t=' + FormatDateTime('hhnnss', Now);

  Conteudo := BaixarComData(UrlGist, DataInternet);

  if (DataInternet = 0) then
  begin
    RespostaData := BaixarTextoWeb('https://time.now/developer/api/ip');
    if Pos('202', RespostaData) > 0 then
    begin
      DataStr := Copy(RespostaData, Pos('202', RespostaData), 10);
      try
        DataInternet := EncodeDate(StrToInt(Copy(DataStr, 1, 4)), StrToInt(Copy(DataStr, 6, 2)), StrToInt(Copy(DataStr, 9, 2)));
      except
        DataInternet := Now;
      end;
    end else DataInternet := Now;
  end;
  if (Conteudo = '') then
  begin
    Application.MessageBox('Fail to sync with server. Check internet.', 'Error', MB_ICONERROR);
    Exit;
  end;

  ListaLinhas := TStringList.Create;
  Dados := TStringList.Create;
  try
    ListaLinhas.Text := Conteudo;

    VersaoGist := Form1.VERSAO_LOCAL;
    for Linha in ListaLinhas do
    begin
      if Pos('SERVER_VER=', UpperCase(Linha)) > 0 then
      begin
        VersaoGist := Trim(Copy(Linha, Pos('=', Linha) + 1, 10));
        Break;
      end;
    end;

    for Linha in ListaLinhas do
    begin
      if Pos(MeuHWID, Linha) > 0 then
      begin
        Dados.Delimiter := '=';
        Dados.StrictDelimiter := True;
        Dados.DelimitedText := Linha;

        if Dados.Count >= 4 then
        begin
          try
            Nome    := Dados[0];
            DataStr := Trim(Dados[2]); // Trim para limpar espaços invisíveis
            Nivel   := Dados[3];
            Level := StrToInt(Nivel);

            DataLimite := EncodeDate(StrToInt(Copy(DataStr, 1, 4)), StrToInt(Copy(DataStr, 6, 2)), StrToInt(Copy(DataStr, 9, 2)));

            // COMPARAÇÃO USANDO SAMEDATE (Mais robusta que o "=" simples)
            if (DataInternet < DataLimite) or SameDate(DataInternet, DataLimite) then
            begin
              Dias := DaysBetween(DataLimite, DataInternet);

              if Form1.VERSAO_LOCAL <> VersaoGist then
                 Form1.lbStatus.Caption := 'UPDATE AVAILABLE'
              else
                 Form1.lbStatus.Caption := 'ACTIVE';

              // Se for o mesmo dia, garante o texto de expiração
              if SameDate(DataInternet, DataLimite) then
                 Form1.lbStatus.Caption := 'EXPIRES TODAY';

              Form1.lbStatus.ShowHint := True;
              Form1.lbStatus.Hint := Format(
                              '--- LICENSE INFO ---' + sLineBreak +
                              'Owner: %s' + sLineBreak +
                              'HWID: %s' + sLineBreak +
                              'Level: %s' + sLineBreak +
                              'Expires in: %d days' + sLineBreak +
                              '--- SYNC INFO ---' + sLineBreak +
                              'Server Date: %s' + sLineBreak +
                              'Local Version: %s' + sLineBreak +
                              'Latest Version: %s',
                              [Nome, MeuHWID, Nivel, Dias, FormatDateTime('yyyy-mm-dd', DataInternet), Form1.VERSAO_LOCAL, VersaoGist]
                            );

              Result := True;
            end
            else
              Application.MessageBox('Licença Expirada!', 'Segurança', MB_ICONERROR);
          except
            Application.MessageBox('Erro ao processar dados da licença.', 'Erro', MB_ICONERROR);
          end;
        end;
        Break;
      end;
    end;

    if not Result and (Pos(MeuHWID, Conteudo) = 0) then
       InputQuery('Acesso Negado', 'HWID não autorizado:', MeuHWID);
    if Level >= 1 then
  begin
   form1.atk.enabled := True;
   form1.atk.TabVisible := True;
   form1.fishing.enabled := True;
   form1.fishing.TabVisible := True;
  end;
    if Level >= 2 then
  begin
   form1.Healing.enabled := True;
   form1.Healing.TabVisible := True;
  end;
  if Level >= 3 then
  begin
   form1.Combo.enabled := True;
   form1.combo.TabVisible := True;
  end;
      if Level >= 4 then
  begin
   form1.Buffs.enabled := True;
   form1.Buffs.TabVisible := True;
  end;
  if Level >= 5 then
  begin
     form1.CaveBot.enabled := True;
     form1.CaveBot.TabVisible := True;
  end;

  finally
    ListaLinhas.Free;
    Dados.Free;
  end;
end;

procedure EnviarHotkey(Tecla: Byte);
var
  Scan: UINT;
begin
  if (Tecla = 0) or (H_Jogo = 0) then Exit;

  Scan := MapVirtualKey(Tecla, 0);

  // 1. Envia o DOWN
  PostMessage(H_Jogo, WM_KEYDOWN, Tecla, (Scan shl 16));

  // 2. Aguarda um tempo mínimo "humano" para o jogo registrar o aperto
  // Isso é o que o UOPilot faz internamente.
  Sleep(20);

  // 3. Envia o UP
  PostMessage(H_Jogo, WM_KEYUP, Tecla, (Scan shl 16) or $C0000000);

  // 4. Pequeno fôlego para o Windows processar a fila de mensagens
  Sleep(10);
end;

procedure MoverEClicar(H: HWND; X, Y: Integer);
begin
  if H = 0 then Exit;
  PostMessage(H_Jogo, WM_LBUTTONUP, 0, MakeLParam(X, Y));
  PostMessage(H_Jogo, WM_MOUSEMOVE, 0, MakeLParam(X, Y));
  PostMessage(H_Jogo, WM_LBUTTONDOWN, MK_LBUTTON, MakeLParam(X, Y));
  PostMessage(H_Jogo, WM_LBUTTONUP, 0, MakeLParam(X, Y));
end;


procedure MoverEClicarDireito(H: HWND; X, Y: Integer);
begin
  if H = 0 then Exit;
  // Envia as mensagens diretamente para a fila da janela do jogo
  PostMessage(H, WM_RBUTTONUP, 0, MakeLParam(X, Y));
  PostMessage(H, WM_MOUSEMOVE, 0, MakeLParam(X, Y));
  PostMessage(H, WM_RBUTTONDOWN, MK_RBUTTON, MakeLParam(X, Y));
  PostMessage(H, WM_RBUTTONUP, 0, MakeLParam(X, Y));
end;

function CheckPixelRel(X, Y: Integer; Cor: TColor; Tol: Integer): Boolean;
var DC: HDC; CorLida: TColor; P: TPoint;
begin
  Result := False; if H_Jogo = 0 then Exit;
  P := Point(X, Y); Windows.ClientToScreen(H_Jogo, P);
  DC := GetDC(0);
  try
    CorLida := GetPixel(DC, P.X, P.Y);
    Result := (Abs(Red(Cor)-Red(CorLida))<=Tol) and (Abs(Green(Cor)-Green(CorLida))<=Tol) and (Abs(Blue(Cor)-Blue(CorLida))<=Tol);
  finally ReleaseDC(0, DC); end;
end;

function FindColorRel(H: HWND; X1, Y1, X2, Y2: Integer; CorAlvo: TColor; out FoundX, FoundY: Integer): Boolean;
 var
   Bitmap: TBitmap;
   x, y: Integer;
   W, H_Area: Integer;
   DC: HDC;
   P1: TPoint;
   ScanLinha: PDWORD;
   AlvoRGB: DWORD;
 begin
   Result := False;
   if H = 0 then Exit;

   W := X2 - X1;
   H_Area := Y2 - Y1;
   if (W <= 0) or (H_Area <= 0) then Exit;

   P1 := Point(X1, Y1);
   Windows.ClientToScreen(H, P1);

   // Conversão de bits universal para o ponteiro
   AlvoRGB := ((CorAlvo and $FF) shl 16) or (CorAlvo and $FF00) or ((CorAlvo and $FF0000) shr 16);

   DC := GetDC(0);
   if DC = 0 then Exit;

   Bitmap := TBitmap.Create;
   try
     Bitmap.PixelFormat := pf32bit;
     Bitmap.SetSize(W, H_Area);

     // O TRUQUE MESTRE: Preenche a memória do bitmap com Rosa antes do print.
     // Isso elimina o "falso positivo do zero inicial" na memória RAM.
     Bitmap.Canvas.Brush.Color := $FF00FF;
     Bitmap.Canvas.FillRect(Rect(0, 0, W, H_Area));

     // BitBlt puro e ultra leve
     BitBlt(Bitmap.Canvas.Handle, 0, 0, W, H_Area, DC, P1.X, P1.Y, SRCCOPY);

     // Sincroniza os ponteiros do ScanLine com o que o BitBlt acabou de desenhar
     Bitmap.Modified := True;

     for y := 0 to H_Area - 1 do
     begin
       ScanLinha := PDWORD(Bitmap.ScanLine[y]);
       for x := 0 to W - 1 do
       begin
         // Comparação direta e bruta. Se for 0, vai achar o seu 0 exato da tela.
         if (ScanLinha^ and $FFFFFF) = AlvoRGB then
         begin
           FoundX := X1 + x;
           FoundY := Y1 + y;
           Result := True;
           Exit;
         end;
         Inc(ScanLinha);
       end;
     end;
   finally
     Bitmap.Free;
     ReleaseDC(0, DC);
   end;
 end;

function TextoParaTecla(Texto: String): Byte;
begin
  Result := 0;
  if Pos('F', Texto) = 1 then Result := VK_F1 + StrToIntDef(Copy(Texto, 2, 2), 1) - 1
  else if (Length(Texto) = 1) and (Texto[1] in ['0'..'9']) then Result := VK_0 + StrToInt(Texto[1]);
end;

function FindImage(StartX, StartY, EndX, EndY: Integer; Target: TBitmap; Accuracy, Deviation: Integer): Boolean;
type
  TRGB24 = record B, G, R: Byte; end;
  PRGB24 = ^TRGB24;
var
  ScreenBmp: TBitmap;
  x, y, ix, iy: Integer;
  Matches, TotalPixels, MaxDiff, W, H: Integer;
  PScanLine, PTargetLine: PRGB24;
  DC: HDC;
  P1: TPoint;

  // --- O SEGREDO DO DESEMPENHO ---
  // Guardamos os ponteiros na memória antes dos loops começarem
  ScreenLines: array of PRGB24;
  TargetLines: array of PRGB24;
begin
  Result := False;
  if (Target = nil) or (Target.Empty) or (H_Jogo = 0) then Exit;

  Target.PixelFormat := pf24bit;
  TotalPixels := Target.Width * Target.Height;
  MaxDiff := Round(255 * (Deviation / 100));
  W := EndX - StartX;
  H := EndY - StartY;

  if (W <= 0) or (H <= 0) then Exit;

  P1 := Point(StartX, StartY);
  Windows.ClientToScreen(H_Jogo, P1);

  DC := GetDC(0);
  if DC = 0 then Exit;

  ScreenBmp := TBitmap.Create;
  try
    ScreenBmp.PixelFormat := pf24bit;
    ScreenBmp.SetSize(W, H);

    ScreenBmp.Canvas.Brush.Color := $FF00FF;
    ScreenBmp.Canvas.FillRect(Rect(0, 0, W, H));

    if ScreenBmp.Handle = 0 then Exit;

    // Captura instantânea da tela
    BitBlt(ScreenBmp.Canvas.Handle, 0, 0, W, H, DC, P1.X, P1.Y, SRCCOPY);
    ScreenBmp.Modified := True;

    // --- PASSO 1: CACHE DOS PONTEIROS (Roda apenas uma vez) ---
    SetLength(ScreenLines, ScreenBmp.Height);
    for y := 0 to ScreenBmp.Height - 1 do
      ScreenLines[y] := PRGB24(ScreenBmp.ScanLine[y]);

    SetLength(TargetLines, Target.Height);
    for iy := 0 to Target.Height - 1 do
      TargetLines[iy] := PRGB24(Target.ScanLine[iy]);

    // --- PASSO 2: SUPER LOOP (Agora lendo direto da memória RAM) ---
    for y := 0 to ScreenBmp.Height - Target.Height do
    begin
      for x := 0 to ScreenBmp.Width - Target.Width do
      begin
        Matches := 0;

        for iy := 0 to Target.Height - 1 do
        begin
          // Pegamos o ponteiro pré-calculado direto do Array (Sem chamar o .ScanLine pesado!)
          PScanLine := ScreenLines[y + iy];
          Inc(PScanLine, x);

          PTargetLine := TargetLines[iy];

          for ix := 0 to Target.Width - 1 do
          begin
            if (Abs(Int64(PTargetLine^.R) - PScanLine^.R) <= MaxDiff) and
               (Abs(Int64(PTargetLine^.G) - PScanLine^.G) <= MaxDiff) and
               (Abs(Int64(PTargetLine^.B) - PScanLine^.B) <= MaxDiff) then
              Inc(Matches);

            Inc(PTargetLine);
            Inc(PScanLine);
          end;
        end;

        // Validação de acerto
        if (Matches * 100 div TotalPixels) >= Accuracy then
        begin
          X_C := StartX + x + (Target.Width div 2);
          Y_C := StartY + y + (Target.Height div 2);
          Result := True;
          Exit;
        end;
      end;
    end;
  finally
    // Limpa a memória dos Arrays dinâmicos
    SetLength(ScreenLines, 0);
    SetLength(TargetLines, 0);

    ScreenBmp.Free;
    ReleaseDC(0, DC);
  end;
end;

//----------- threads aqui --------------//

procedure TComobopvpThread.Execute;
var
  Ex, Ey: Integer;
  TimerCba: QWord;
  EncontrouMagia: Boolean;
  Tentativas: Integer;
begin
  // Usamos "not Terminated" para a thread ficar viva em segundo plano para sempre
  while not Terminated do
  begin
    // Enquanto o combo estiver ativo (1) ela processa o bot
    if comboa = 1 then
    begin
      TimerCba := GetTickCount64;

      if vckcomboPVP and ((TimerCba - UCombo) >= Cardinal(MsCombo)) then
      begin
        if vckheal and vckml then
        begin
          if not CheckPixelRel(X_Ml, Y_Ml, CorMl, 10) then
          begin
            EnviarHotKey(TextoParaTecla(HotCombo));
            UCombo := TimerCba;
            Sleep(2);
            Continue;
          end;
        end;

        // Verifica se há alvo na área da Battle
        if not FindColorRel(H_Jogo, X_SupAtk, Y_SupAtk, X_InfAtk, Y_InfAtk, 0, Ex, Ey) then
        begin
          EncontrouMagia := False;
          Tentativas := 0;

          while (not EncontrouMagia) and (Tentativas < 6) and (not Terminated) do
          begin
            case PassoCombo of
              1: if vckmg1 then begin EnviarHotkey(TextoParaTecla(HotMg1)); EncontrouMagia := True; end;
              2: if vckmg2 then begin EnviarHotkey(TextoParaTecla(HotMg2)); EncontrouMagia := True; end; // Ajustado tipo
              3: if vckmg3 then begin EnviarHotkey(TextoParaTecla(HotMg3)); EncontrouMagia := True; end;
              4: if vckmg4 then begin EnviarHotkey(TextoParaTecla(HotMg4)); EncontrouMagia := True; end;
              5: if vckmg5 then begin EnviarHotkey(TextoParaTecla(HotMg5)); EncontrouMagia := True; end;
              6: if vckmg6 then begin EnviarHotkey(TextoParaTecla(HotMg6)); EncontrouMagia := True; end;
            end;

            Inc(PassoCombo);
            if PassoCombo > 6 then PassoCombo := 1;
            Inc(Tentativas);
          end;

          if EncontrouMagia then
            UCombo := GetTickCount64;
        end
        else
          PassoCombo := 1;
      end;
    end;
    Sleep(5); // Pausa milimétrica crucial para não travar o processador em 100%
  end;
end;

procedure TComboThread.Execute;
var
  Ex, Ey: Integer;
  TimerCb: QWord;
  EncontrouMagia: Boolean;
  Tentativas: Integer;
begin
  FreeOnTerminate := False;
  // Prioridade alta para garantir que a cura mágica não atrase
  Priority := tpTimeCritical;

  while not Terminated do
  begin
    // Parada Instantânea: Se o bot for desligado, interrompe o ciclo na hora
    if (not BotRodando) or (not vckcombo) then
    begin
      Sleep(5);
      Continue;
    end;
    if vCkHwhd then // checkbox pra saber se o usuario que usar essa função
    begin
      if GetForegroundWindow() <> H_Jogo then
    begin
      // Se não estiver no jogo, espera 200 milissegundos e tenta de novo.
      // Isso evita que a thread consuma 100% da sua CPU enquanto o jogo está em background.
      Sleep(20);
      continue; // Volta para o início do 'while', ignorando as ações abaixo
    end;
    end;

    TimerCb := GetTickCount64;
    sleep(2);

    if vckcombo and ((TimerCb - UCombo) >= Cardinal(MsCombo)) then
    begin
      if vckheal and vckml then
    begin
      // Se a vida NÃO estiver cheia (não encontrou a cor segura)
      if not CheckPixelRel(X_Ml, Y_Ml, CorMl, 10) then
      begin
          EnviarHotKey(TextoParaTecla(HotCombo));
          UCombo := TimerCb;
          sleep(2);
          Continue; // Volta ao topo para priorizar a cura até a vida estabilizar
      end;
    end;
      // 3. Verifica se há alvo na área da Battle
      if FindColorRel(H_Jogo, X_SupAtk, Y_SupAtk, X_InfAtk, Y_InfAtk, 0, Ex, Ey) then
      begin
        EncontrouMagia := False;
        Tentativas := 0;

        // Tenta encontrar a próxima magia ativa no seu combo de 1 a 6
        while (not EncontrouMagia) and (Tentativas < 6) and (not Terminated) do
        begin
          case PassoCombo of
            1: if vckmg1 then begin EnviarHotkey(TextoParaTecla(HotMg1)); EncontrouMagia := True; end;
            2: if vckmg2 then begin EnviarHotkey(TextoParaTecla(HotMg2)); EncontrouMagia := True; end;
            3: if vckmg3 then begin EnviarHotkey(TextoParaTecla(HotMg3)); EncontrouMagia := True; end;
            4: if vckmg4 then begin EnviarHotkey(TextoParaTecla(HotMg4)); EncontrouMagia := True; end;
            5: if vckmg5 then begin EnviarHotkey(TextoParaTecla(HotMg5)); EncontrouMagia := True; end;
            6: if vckmg6 then begin EnviarHotkey(TextoParaTecla(HotMg6)); EncontrouMagia := True; end;
          end;

          Inc(PassoCombo);
          if PassoCombo > 6 then PassoCombo := 1;
          Inc(Tentativas);
        end;

        if EncontrouMagia then
          UCombo := GetTickCount64; // Atualiza o timer após o ataque
      end
      else
      begin
        // Se não há alvo, reseta o combo para a primeira magia

      if comboa = 0 then
         begin
              PassoCombo := 1;
         end;
       end;
      Sleep(5);
    end;
    Sleep(5); // Mantém a responsividade do sistema
  end;
end;

procedure THealThreadPot.Execute;
var
  Ag: QWord;
  TimerMl: QWord;
begin
  // Mantemos a prioridade alta para garantir a leitura rápida do pixel
  Priority := tpTimeCritical;

  while not Terminated do
  begin
    // Se o bot for desligado, para a execução imediatamente
    if (not BotRodando) or (not vckheal) then
    begin
      Sleep(5);
      Continue;
    end;

        if vCkHwhd then // checkbox pra saber se o usuario que usar essa função
    begin
      if GetForegroundWindow() <> H_Jogo then
    begin
      // Se não estiver no jogo, espera 200 milissegundos e tenta de novo.
      // Isso evita que a thread consuma 100% da sua CPU enquanto o jogo está em background.
      Sleep(20);
      continue; // Volta para o início do 'while', ignorando as ações abaixo
    end;
    end;

     sleep(2);
     Ag := GetTickCount64;
     TimerMl := GetTickCount64;
     if not vckcombo then
    begin
      if vckheal and vckml then
    begin
      // Se a vida NÃO estiver cheia (não encontrou a cor segura)
      if not CheckPixelRel(X_Ml, Y_Ml, CorMl, 10) then
      begin
        // Verifica se o delay global de magia (MsCombo) já passou
        if (TimerMl - UCombo) >= Cardinal(MsHeal) then
        begin
          EnviarHotKey(TextoParaTecla(HotCombo));
          UCombo := TimerMl;
        end;
        Continue; // Volta ao topo para priorizar a cura até a vida estabilizar
      end;
    end;
    end;

    // Verifica se o delay de grupo das poções (MsHeal) já passou
    if (Ag - UltimaPot) >= Cardinal(MsHeal) then
    begin
      // 1. PRIORIDADE MÁXIMA: LIFE POT
      // Se não encontrar a cor da vida no ponto X/Y..
      if vckheal and vPrdLifePot then
      begin
      if vcklp and (not CheckPixelRel(X_lp, Y_lp, Corlp, 10)) then
      begin
        EnviarHotkey(TextoParaTecla(HotHeal));
        UltimaPot := Ag;
        sleep(2);
        // O "Continue" faz o bot voltar ao topo do loop imediatamente.
        // Isso garante que ele re-cheque a vida antes de tentar usar mana.
        Continue;
      end;

      // 2. SEGUNDA PRIORIDADE: MANA POT[cite: 1, 2]
      // Só tenta usar mana se o check de vida passou (está com vida cheia)
      if vckmp and (not CheckPixelRel(X_Mp, Y_Mp, CorMp, 10)) then
      begin
          EnviarHotkey(TextoParaTecla(HotMana));
          UltimaPot := Ag;
          sleep(2);
          Continue;
      end;
      end;

      if vckheal and vPrdMana then
      begin

      if vckmp and (not CheckPixelRel(X_Mp, Y_Mp, CorMp, 10)) then
      begin
          EnviarHotkey(TextoParaTecla(HotMana));
          UltimaPot := Ag;
          sleep(2);
          Continue;
      end;

      if vcklp and (not CheckPixelRel(X_lp, Y_lp, Corlp, 10)) then
      begin
        EnviarHotkey(TextoParaTecla(HotHeal));
        UltimaPot := Ag;
        sleep(2);
        Continue;
      end;
      end;

    end;

    // Sleep baixo para manter a CPU fria sem perder a resposta rápida do UOPilot
    Sleep(3);
  end;
end;

procedure THealThreadFruit.Execute;
var
  Ag: QWord;
begin
  Priority := tpTimeCritical;
  while not Terminated do
  begin
       if (not BotRodando) or (not vckheal) then
    begin
      Sleep(5);
      Continue;
    end;

    Ag := GetTickCount64;
    // Fruit Check

        if vCkHwhd then // checkbox pra saber se o usuario que usar essa função
    begin
      if GetForegroundWindow() <> H_Jogo then
    begin
      // Se não estiver no jogo, espera 200 milissegundos e tenta de novo.
      // Isso evita que a thread consuma 100% da sua CPU enquanto o jogo está em background.
      Sleep(20);
      continue; // Volta para o início do 'while', ignorando as ações abaixo
    end;
    end;

    if vckheal and vckft and ((Ag - UFruit) >= Cardinal(MsHeal)) then
      if not CheckPixelRel(X_ft, Y_ft, Corft, 10) then begin
        EnviarHotkey(TextoParaTecla(HotFruit));
        UFruit := Ag;
      end;
    Sleep(1);
  end;
end;

procedure TAtkThread.Execute;
var
  Ex, Ey: Integer;
  Agora: QWord;
  AchouMob, JaEstaAtacando: Boolean;
begin
  FreeOnTerminate := False; // Controle manual no Botão Stop
  while not Terminated do
  begin
    // Verifica se o bot e o CheckBox de ataque estão ativos
    if (not BotRodando) or (not vckAtk) then
    begin
      Sleep(100);
      Continue;
    end;
    Sleep(1);
    Agora := GetTickCount64;

    if vCkHwhd then // checkbox pra saber se o usuario que usar essa função
    begin
      if GetForegroundWindow() <> H_Jogo then
    begin
      continue; // Volta para o início do 'while', ignorando as ações abaixo
    end;
    end;

    // Controle de Delay (MsAtk)
    if (Agora - UltimoAtaque) >= Cardinal(MsAtk) then
    begin
      // Se você usa o FindColorRel Global que definimos antes:
      AchouMob := FindColorRel(H_Jogo, X_SupAtk, Y_SupAtk, X_InfAtk, Y_InfAtk, 0, Ex, Ey);

      if AchouMob then
      begin
        // 2. Verifica se já está atacando (evita spam desnecessário da hotkey)
        JaEstaAtacando := FindColorRel(H_Jogo, X_SupAtk, Y_SupAtk, X_InfAtk, Y_InfAtk, CorAtk, Ex, Ey);

        if not JaEstaAtacando then
        begin
          if vCkMouse then
          begin
               MoverEclicarDireito(H_Jogo, X_SupAtk, Y_SupAtk);
          end
          else
          begin
               EnviarHotkey(VK_SPACE); // Envia o ataque
          end;
              UltimoAtaque := Agora;
        end;
    end;
  end;
  end;
end;

procedure TFishingThread.Execute;
var
  X, Y: Integer;
  Agora: QWord;
begin
  FreeOnTerminate := False;
  while not Terminated do
  begin
    // Verifica se o bot e o fishing estão ativos
    if (not BotRodando) or (not vckfishing) then
    begin
      Sleep(5);
      Continue;
    end;

    Agora := GetTickCount64;

        if vCkHwhd then // checkbox pra saber se o usuario que usar essa função
    begin
      if GetForegroundWindow() <> H_Jogo then
    begin
      // Se não estiver no jogo, espera 200 milissegundos e tenta de novo.
      // Isso evita que a thread consuma 100% da sua CPU enquanto o jogo está em background.
      Sleep(20);
      continue; // Volta para o início do 'while', ignorando as ações abaixo
    end;
    end;

    // Só age se o tempo do "Alarm" já passou
    if Agora >= AlarmeFish then
    begin
      case PassoFish of
        0: begin
          // Calcula coordenada aleatória na primeira área
          X := X_F1 + Random(X_F2 - X_F1 + 1);
          Y := Y_F1 + Random(Y_F2 - Y_F1 + 1);

          MoverEClicarDireito(H_Jogo, X, Y);

          if vckfishing2 then
          begin
            PassoFish := 1;
            // Delay curto para o segundo clique (simulando humano)
            AlarmeFish := Agora + 250 + Random(300);
          end
          else
          begin
            PassoFish := 0;
            // Delay longo configurado no painel
            AlarmeFish := Agora + vMinFish + Random(vMaxFish - vMinFish + 1);
          end;
        end;

        1: begin
          // Calcula coordenada aleatória na segunda área (isca/container)
          X := X_F1b + Random(X_F2b - X_F1b + 1);
          Y := Y_F1b + Random(Y_F2b - Y_F1b + 1);

          MoverEClicarDireito(H_Jogo, X, Y);

          PassoFish := 0;
          // Delay longo configurado no painel
          AlarmeFish := Agora + vMinFish + Random(vMaxFish - vMinFish + 1);
        end;
      end;
    end;

    Sleep(200); // Delay de repouso da thread (Fishing não precisa de 1ms)
  end;
end;

procedure TCaveThread.Execute;
var
  Ex, Ey, i: Integer;
begin

FreeOnTerminate := False;
CaminhoImagens := ExtractFilePath(ParamStr(0)) + 'Imagens' + PathDelim;

for i := 1 to 18 do
begin
  WptBitmaps[i] := TBitmap.Create;
  WptBitmaps[i].PixelFormat := pf24bit;
  if FileExists(CaminhoImagens + 'ponto' + IntToStr(i) + '.bmp') then
    WptBitmaps[i].LoadFromFile(CaminhoImagens + 'ponto' + IntToStr(i) + '.bmp');
end;

  while not Terminated do
  begin
    // 1. Verificação de Pausa Instantânea
    if (not BotRodando) or (not vckcavebot) then
    begin
      Sleep(5);
      Continue;
    end;

        if vCkHwhd then // checkbox pra saber se o usuario que usar essa função
    begin
      if GetForegroundWindow() <> H_Jogo then
    begin
      // Se não estiver no jogo, espera 200 milissegundos e tenta de novo.
      // Isso evita que a thread consuma 100% da sua CPU enquanto o jogo está em background.
      Sleep(20);
      continue; // Volta para o início do 'while', ignorando as ações abaixo
    end;
    end;
     sleep(50);
    // Checagem constante de monstro na Battle

    case EstadoBot of

      // --- ESTADO: CAMINHANDO ---
      stCaminhando:
      begin
        // 1. Verifica se o Waypoint atual está habilitado (Checkboxes ckwpt1..18)
        if not vchkwpt[WptIndex] then
        begin
          Inc(WptIndex); if WptIndex > 18 then WptIndex := 1;
          Continue;
        end;

        // 2. Procura a imagem do waypoint
        if FindImage(lxm, lym, rxm, rym, WptBitmaps[WptIndex], 80, 0) then
        begin
          MoverEClicar(H_Jogo, X_C, Y_C);
          // Soma o delay base + o delay específico do waypoint (SpinEdits SWpt1..18)
          TempoTotalEspera := vsUtime + vTimeWpt[WptIndex];
          UltimoTick := GetTickCount64;
          EstadoBot := stWait;
          continue;
        end
        else
        begin
          // Se não achou a imagem, pula para o próximo para não travar o bot
          Inc(WptIndex); if WptIndex > 18 then WptIndex := 1;
           sleep(10);
          continue;
        end;
      end;

      // --- ESTADO: WAIT (ESPERA NO PONTO) ---
      stWait:
      begin
      if vCkStopMob and FindColorRel(H_Jogo, midx, midy, X_InfAtk, Y_InfAtk, 0, Ex, Ey) then
        begin
          Dec(WptIndex);
          EstadoBot := stUMob;
          EnviarHotkey(VK_ESCAPE);
          Continue;
        end;
                // 2. Lógica de Tempo da Procedure: Se ckNTp estiver marcado, espera o tempo acabar
        if vcknxtp then
        begin
          if (GetTickCount64 - UltimoTick) >= Cardinal(TempoTotalEspera) then
            EstadoBot := stEsc;
          sleep(200);
            continue;
        end;
        // 1. Interrupção por Mob (Regra do Dec solicitada anteriormente)

      end;

      // --- ESTADO: ESC (LIMPEZA DE TARGET / DECISÃO DE COMBATE) ---
      stEsc:
      begin
      if not FindColorRel(H_Jogo, X_SupAtk, Y_SupAtk, X_InfAtk, Y_InfAtk, 0, Ex, Ey) then
        begin
          // Se não tem mob, ciclo concluído: Avança Waypoint e volta a andar
          Inc(WptIndex); if WptIndex > 18 then WptIndex := 1;
          EstadoBot := stCaminhando;
          continue;
        end;
        if vckEsc then // vckEsc é a variável da checkbox ckEsc
        begin
           EnviarHotkey(VK_ESCAPE);
           EstadoBot := stUmob;
        end;
      end;

      // --- ESTADO: UMOB (MONITORANDO O COMBATE) ---
      stUMob:
      begin
        // Se tem mob e ckumb (esperar matar) está ativo, continua aqui
        if FindColorRel(H_Jogo, X_SupAtk, Y_SupAtk, X_InfAtk, Y_InfAtk, 0, Ex, Ey) and vckumb then
           begin
           sleep(10);
           Continue;
           end
        else
          EstadoBot := stColetando;
      end;

      // --- ESTADO: COLETANDO (LOOT) ---
      stColetando:
      begin
        // 1. Delay entre cliques de loot
        if GetTickCount64 < ProximoClique then Continue;

        // 2. Se a coleta estiver desativada
        if not vckcoleta then
        begin
          SlotAtual := 1;
          Inc(WptIndex); if WptIndex > 18 then WptIndex := 1;
          EstadoBot := stCaminhando;
          Continue;
        end;

        // 3. Checagem de monstro durante o loot (ckCLoot)
        if vckCLoot and FindColorRel(H_Jogo, X_SupAtk, Y_SupAtk, X_InfAtk, Y_InfAtk, 0, Ex, Ey) then
        begin
          EstadoBot := stUMob;
          SlotAtual := 1;
          Continue;
        end;

        // 4. Executa o clique de loot (Shift + Click Direito)
         keybd_event(VK_SHIFT, MapVirtualKey(VK_SHIFT, 0), 0, 0);
        sleep(15);
        try
          MoverEClicarDireito(H_Jogo, LX[SlotAtual], LY[SlotAtual]);
          // vstimeloot é o valor do SpinEdit de delay do loot
          ProximoClique := GetTickCount64 + QWord(vstimeloot);
          Inc(SlotAtual);
        finally
        end;
         sleep(15);
         keybd_event(VK_SHIFT, MapVirtualKey(VK_SHIFT, 0), KEYEVENTF_KEYUP, 0);


        // 5. Finalizou os 8 slots?
        if SlotAtual > 8 then
        begin
          SlotAtual := 1;
          Inc(WptIndex); if WptIndex > 18 then WptIndex := 1;
          EstadoBot := stCaminhando;
        end;
      end;

    end; // End Case

    Sleep(10); // Ciclo de CPU para não travar o Windows
  end;
end;

procedure TBuffThread.Execute;
var
  Ag: QWord;
  i: Integer;
  CaminhoBase: string;
begin
  Priority := tpNormal;
  FreeOnTerminate := False;
  CaminhoBase := ExtractFilePath(ParamStr(0)) + 'Imagens' + PathDelim;

  // 1. CARREGAMENTO DOS BITMAPS NA MEMÓRIA
  for i := 1 to 3 do
  begin
    vBuffBitmaps[i, 1] := TBitmap.Create;
    vBuffBitmaps[i, 1].PixelFormat := pf24bit;
    vBuffBitmaps[i, 2] := TBitmap.Create;
    vBuffBitmaps[i, 2].PixelFormat := pf24bit;
    vbuffTimea[i] := 0;

    if FileExists(CaminhoBase + vBuffName[(i-1)*2 + 1] + '.bmp') then
      vBuffBitmaps[i, 1].LoadFromFile(CaminhoBase + vBuffName[(i-1)*2 + 1] + '.bmp');

    if FileExists(CaminhoBase + vBuffName[(i-1)*2 + 2] + '.bmp') then
      vBuffBitmaps[i, 2].LoadFromFile(CaminhoBase + vBuffName[(i-1)*2 + 2] + '.bmp');
  end;

  while not Terminated do
  begin
    if (not BotRodando) or (not vCkBuffs) then
    begin
      Sleep(5);
      Continue;
    end;

    Ag := GetTickCount64;
        if vCkHwhd then // checkbox pra saber se o usuario que usar essa função
    begin
      if GetForegroundWindow() <> H_Jogo then
    begin
      // Se não estiver no jogo, espera 200 milissegundos e tenta de novo.
      // Isso evita que a thread consuma 100% da sua CPU enquanto o jogo está em background.
      Sleep(20);
      continue; // Volta para o início do 'while', ignorando as ações abaixo
    end;
    end;
    for i := 1 to 3 do
    begin
      sleep(150);
      if vckBuff[i] then
      begin
        if (Ag - TimeBuff[i]) >= Cardinal(vbuffTimea[i]) then
        begin
          // Tenta encontrar qualquer uma das duas variações do ícone
           if FindImage(lxb, lyb, rxb, ryb, vBuffBitmaps[i, 1], 80, 10) or FindImage(lxb, lyb, rxb, ryb, vBuffBitmaps[i, 2], 80, 10)  then
          begin
            vbuffTimea[i] := 0; //achou, reseta a verificação até sumir
            sleep(10);
            continue;
          end;

          if not FindImage(lxb, lyb, rxb, ryb, vBuffBitmaps[i, 1], 80, 10) and not FindImage(lxb, lyb, rxb, ryb, vBuffBitmaps[i, 2], 80, 10)  then
          begin
            // Se não achou o ícone, verifica se pode usar a hotkey (ex: mana/battle)
            if CheckPixelRel(X_Ml, Y_Ml, CorMl, 10) then
            begin
              EnviarHotkey(TextoParaTecla(vBuffhk[i]));
              // Não atualizamos o TimeBuff aqui com 'Ag' para que ele tente
              // verificar novamente no próximo ciclo se o ícone apareceu.
              Sleep(10);
            end;
          end;
          if FindImage(lxb, lyb, rxb, ryb, vBuffBitmaps[i, 1], 80, 10) then
          begin
            // Se achou o ícone (está buffado), reseta o timer para o tempo atual
            TimeBuff[i] := Ag;
            vbuffTimea[i] := vbuffTime[i];
            sleep(10);
            continue;
          end;
           if FindImage(lxb, lyb, rxb, ryb, vBuffBitmaps[i, 2], 80, 10)  then
          begin
            // Se achou o ícone (está buffado), reseta o timer para o tempo atual
            TimeBuff[i] := Ag;
            vbuffTimea[i] := vbuffTime[i];
            sleep(10);
            continue;
          end;
        end;
       end;
    end;
  end;
end;

{ Importante: Limpar a memória ao destruir a thread }

destructor TBuffThread.Destroy;
var i: Integer;
begin
  for i := 1 to 3 do
  begin
    vBuffBitmaps[i, 1].Free;
    vBuffBitmaps[i, 2].Free;
  end;
  inherited Destroy;
end;

{ --- CONFIGURAÇÃO (INI) --- }

procedure TForm1.SalvarConfig;
  var
    ArquivoINI: TIniFile;
    i: Integer;
  begin
    ArquivoINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
    try
       //---------------vCkHwhd------------//

        ArquivoINI.WriteBool('Checks', 'OnlyInGame', CkHwhd.Checked);

       //---------------------------//
     ArquivoINI.WriteString('Hotkeys', 'HotkeyGetText', edithotkeyget.Text);
     ArquivoINI.WriteString('Hotkeys', 'HotkeyStartText', editstart.Text);
     ArquivoINI.WriteString('Hotkeys', 'hotkeydropText', editkeydrop.Text);
     ArquivoINI.WriteString('Hotkeys', 'hotkeycomboText', editkeycombo.Text);
     ArquivoINI.WriteString('Hotkeys', 'hotkeystopText', editStop.Text);


    ArquivoINI.WriteInteger('Coordenadas', 'XGet', xget);
    ArquivoINI.WriteInteger('Coordenadas', 'YGet', yget);
    ArquivoINI.WriteInteger('Coordenadas', 'XDrop', xdrop);
    ArquivoINI.WriteInteger('Coordenadas', 'YDrop', ydrop);

    // --- SALVANDO AS HOTKEYS E TEXTOS (Strings) ---
        ArquivoINI.WriteInteger('Hotkeys', 'HotkeyGet', hotkeyget);
        ArquivoINI.WriteInteger('Hotkeys', 'HotkeyStart', hotkeystart);
        ArquivoINI.WriteInteger('Hotkeys', 'HotkeyDrop', hotkeydrop);
        ArquivoINI.WriteInteger('Hotkeys', 'HotkeyCombo', hotkeycombo);
        ArquivoINI.WriteInteger('Hotkeys', 'HotkeyStop', hotkeystop);

        // --- SALVANDO OS CÓDIGOS DE MOUSE (Agora como Inteiros) ---
        ArquivoINI.WriteInteger('Mouse', 'HotkeyGet', codmouseget);
        ArquivoINI.WriteInteger('Mouse', 'HotkeyCombo', codmousecombo);
        ArquivoINI.WriteInteger('Mouse', 'HotkeyDrop', codmousedrop);
        ArquivoINI.WriteInteger('Mouse', 'HotkeyStart', codmousestart);
        ArquivoINI.WriteInteger('Mouse', 'HotkeyStop', codmousestop);

    // --- SALVANDO OS CORES/CHECKBOXES (Booleanos) ---
    ArquivoINI.WriteBool('Config', 'ActCombo', ckActCombo.Checked);
    ArquivoINI.WriteBool('Config', 'PickUp', ckpickup.Checked);
    ArquivoINI.WriteBool('Config', 'Throw', ckthrow.Checked);

      // --- HEALING (Fruta, Life, Mana) ---
      ArquivoINI.WriteInteger('Healing', 'X_ft', X_ft);
      ArquivoINI.WriteInteger('Healing', 'Y_ft', Y_ft);
      ArquivoINI.WriteInteger('Cores', 'Corft', Corft);
      ArquivoINI.WriteBool('Checks', 'UsarFruta', ckft.Checked);
      ArquivoINI.WriteString('Hotkeys', 'HK_Fruit', cbfta.Text);

      ArquivoINI.WriteInteger('Healing', 'X_lp', X_lp);
      ArquivoINI.WriteInteger('Healing', 'Y_lp', Y_lp);
      ArquivoINI.WriteInteger('Cores', 'Corlp', Corlp);
      ArquivoINI.WriteBool('Checks', 'UsarLife', cklp.Checked);
      ArquivoINI.WriteString('Hotkeys', 'HK_Life', cblp.Text);

      ArquivoINI.WriteInteger('Healing', 'X_Mp', X_Mp);
      ArquivoINI.WriteInteger('Healing', 'Y_Mp', Y_Mp);
      ArquivoINI.WriteInteger('Cores', 'CorMp', CorMp);
      ArquivoINI.WriteBool('Checks', 'UsarMana', ckmp.Checked);
      ArquivoINI.WriteString('Hotkeys', 'HK_Mana', cbmp.Text);

      ArquivoINI.WriteInteger('Configuracoes', 'DelayHeal', TsMsHeal.Value);
      ArquivoINI.WriteBool('Checks', 'AtivarHeal', ckheal.Checked);

      ArquivoINI.WriteBool('Checks', 'PrioridadePotMana', PrdMana.Checked);
      ArquivoINI.WriteBool('Checks', 'PrioridadePotLife', PrdLifePot.Checked);

      // --- MAGIC LEVEL (ML) ---
      ArquivoINI.WriteInteger('ML', 'X_Ml', X_Ml);
      ArquivoINI.WriteInteger('ML', 'Y_Ml', Y_Ml);
      ArquivoINI.WriteInteger('Cores', 'CorMl', CorMl);
      ArquivoINI.WriteBool('Checks', 'UsarML', ckml.Checked);
      ArquivoINI.WriteString('Hotkeys', 'HK_ML', cbml.Text);

      // --- ATAQUE (ATK) ---
      ArquivoINI.WriteInteger('Configuracoes', 'DelayAtk', TsMsAtk.Value);
      ArquivoINI.WriteInteger('Coordenadas', 'X_Sup', X_SupAtk);
      ArquivoINI.WriteInteger('Coordenadas', 'Y_Sup', Y_SupAtk);
      ArquivoINI.WriteInteger('Coordenadas', 'X_Inf', X_InfAtk);
      ArquivoINI.WriteInteger('Coordenadas', 'Y_Inf', Y_InfAtk);
      ArquivoINI.WriteInteger('Cores', 'CorAtk', CorAtk);
      ArquivoINI.WriteBool('Checks', 'AtivarAtk', CheckAtk.Checked);
      ArquivoINI.WriteBool('Checks', 'AtivarMouse', CkMouse.Checked);


      ArquivoINI.WriteInteger('Coordenadas', 'X_Mid', midx);
      ArquivoINI.WriteInteger('Coordenadas', 'Y_Mid', midy);

      // --- COMBO ---
      ArquivoINI.WriteInteger('Configuracoes', 'DelayCombo', TsCombo.Value);
      ArquivoINI.WriteBool('Combo', 'AtivarCombo', ckcombo.Checked);
      ArquivoINI.WriteBool('Combo', 'UsarMg1', ckmg1.Checked);
      ArquivoINI.WriteBool('Combo', 'UsarMg2', ckmg2.Checked);
      ArquivoINI.WriteBool('Combo', 'UsarMg3', ckmg3.Checked);
      ArquivoINI.WriteBool('Combo', 'UsarMg4', ckmg4.Checked);
      ArquivoINI.WriteBool('Combo', 'UsarMg5', ckmg5.Checked);
      ArquivoINI.WriteBool('Combo', 'UsarMg6', ckmg6.Checked);
      ArquivoINI.WriteString('Combo', 'HK_Mg1', Mg1.Text);
      ArquivoINI.WriteString('Combo', 'HK_Mg2', Mg2.Text);
      ArquivoINI.WriteString('Combo', 'HK_Mg3', Mg3.Text);
      ArquivoINI.WriteString('Combo', 'HK_Mg4', Mg4.Text);
      ArquivoINI.WriteString('Combo', 'HK_Mg5', Mg5.Text);
      ArquivoINI.WriteString('Combo', 'HK_Mg6', Mg6.Text);

      // --- FISHING (Área A e B) ---
      ArquivoINI.WriteInteger('Fishing', 'AreaA_X1', X_F1);
      ArquivoINI.WriteInteger('Fishing', 'AreaA_Y1', Y_F1);
      ArquivoINI.WriteInteger('Fishing', 'AreaA_X2', X_F2);
      ArquivoINI.WriteInteger('Fishing', 'AreaA_Y2', Y_F2);
      ArquivoINI.WriteInteger('Fishing', 'AreaB_X1', X_F1b);
      ArquivoINI.WriteInteger('Fishing', 'AreaB_Y1', Y_F1b);
      ArquivoINI.WriteInteger('Fishing', 'AreaB_X2', X_F2b);
      ArquivoINI.WriteInteger('Fishing', 'AreaB_Y2', Y_F2b);
      ArquivoINI.WriteInteger('Fishing', 'MinWait', MinFishing.Value);
      ArquivoINI.WriteInteger('Fishing', 'MaxWait', MaxFishing.Value);
      ArquivoINI.WriteBool('Fishing', 'UsarAreaB', ckfishing2.Checked);

      // --- CAVEBOT GERAL ---
      ArquivoINI.WriteBool('Cavebot', 'AtivarColeta', ckcoleta.Checked);
      ArquivoINI.WriteBool('Cavebot', 'InterromperPorMob', ckCLoot.Checked);
      ArquivoINI.WriteBool('Cavebot', 'UsarEsc', ckEsc.Checked);
      ArquivoINI.WriteBool('Cavebot', 'NaoTravarPausa', ckNTp.Checked);
      ArquivoINI.WriteBool('Cavebot', 'UltimoMobBox', ckumb.Checked);
      ArquivoINI.WriteInteger('Times', 'TimeLoot', stimeloot.Value);
      ArquivoINI.WriteInteger('Times', 'sUtime', sUtime.Value);
      ArquivoINI.WriteBool('Cavebot', 'CkStopMob', CkStopMob.Checked);

      //----buffs---
      ArquivoINI.WriteInteger('Buff', 'X1', lxb);
      ArquivoINI.WriteInteger('Buff', 'Y1', lyb);
      ArquivoINI.WriteInteger('Buff', 'X2', rxb);
      ArquivoINI.WriteInteger('Buff', 'Y2', ryb);
          //vCkBuffs := ArquivoINI.ReadBool('buff', 'Principal', False);
      ArquivoINI.WriteBool('Buff', 'Principal', CkBuffs.Checked);
     for i := 1 to 3 do
    begin
      // Salva o estado do Checkbox (CkBuff1, CkBuff2...)
      ArquivoINI.WriteBool('Buff' + IntToStr(i), 'Ativo',
        TCheckBox(FindComponent('CkBuff' + IntToStr(i))).Checked);

      // Salva os Edit Names (Buff1Name1, Buff1Name2, Buff2Name1...)
      ArquivoINI.WriteString('Buff' + IntToStr(i), 'Name1',
        TEdit(FindComponent('Buff' + IntToStr(i) + 'Name1')).Text);
      ArquivoINI.WriteString('Buff' + IntToStr(i), 'Name2',
        TEdit(FindComponent('Buff' + IntToStr(i) + 'Name2')).Text);

      // Salva a ComboBox (cbbuff1, cbbuff2...)
      ArquivoINI.WriteString('Buff' + IntToStr(i), 'Hotkey',
        TComboBox(FindComponent('cbbuff' + IntToStr(i))).Text);

      // Salva o valor do MaskEdit (MEtimeBuff1, MEtimeBuff2...)
      // Nota: Usei .Text, mas se for o valor numérico puro, pode usar .Value se o componente suportar
      ArquivoINI.WriteString('Buff' + IntToStr(i), 'Time',
        TMaskEdit(FindComponent('MEtimeBuff' + IntToStr(i))).Text);
    end;
      // --- WAYPOINTS ---
      for i := 1 to 18 do
      begin
        if Assigned(FindComponent('ckwpt' + IntToStr(i))) then
          ArquivoINI.WriteBool('Waypoints', 'ck' + IntToStr(i), TCheckBox(FindComponent('ckwpt' + IntToStr(i))).Checked);
        if Assigned(FindComponent('SWpt' + IntToStr(i))) then
          ArquivoINI.WriteInteger('Waypoints', 'tm' + IntToStr(i), TSpinEdit(FindComponent('SWpt' + IntToStr(i))).Value);
      end;

      // --- LOOT BOX ---
      for i := 1 to 8 do
      begin
        ArquivoINI.WriteInteger('Loot', 'LX' + IntToStr(i), LX[i]);
        ArquivoINI.WriteInteger('Loot', 'LY' + IntToStr(i), LY[i]);
      end;

      // --- MAPA ---
      ArquivoINI.WriteInteger('Coordenadas', 'MapaUpperX', lxm);
      ArquivoINI.WriteInteger('Coordenadas', 'MapaUpperY', lym);
      ArquivoINI.WriteInteger('Coordenadas', 'MapaLowerX', rxm);
      ArquivoINI.WriteInteger('Coordenadas', 'MapaLowerY', rym);
      ArquivoINI.WriteInteger('Coordenadas', 'MapaCenterX', X_C);
      ArquivoINI.WriteInteger('Coordenadas', 'MapaCenterY', Y_C);

    finally
      ArquivoINI.Free;
    end;
  end;

procedure TForm1.WMHotKey(var Msg: TMessage);
begin
  case Msg.WParam of
    1: BotStart; // Se apertou o ID 1 (HOME)
    2: BotStop;  // Se apertou o ID 2 (END)

    3:
    if (ativo = 1) and vckpickup then
       begin
            if  H_jogo = GetForegroundWindow() then
              begin
              getitem(xget, yget);
              end
            else
              begin
                   EnviarHotkeyAtiva(hotkeyget);
              end;
       end
       else
         begin
           EnviarHotkeyAtiva(hotkeyget);
         end;

    4:
    if (ativo = 1) and vckthrow then
       begin
            if H_Jogo = GetForegroundWindow() then
             begin
                  droptitem(xdrop, ydrop);
             end
            else
            begin
                 EnviarHotkeyAtiva(hotkeydrop);
            end;
       end
       else
         begin
           EnviarHotkeyAtiva(hotkeydrop);
         end;

    5: if (ativo = 1) and vckcombo then
     begin
      if H_Jogo = GetForegroundWindow() then
       begin
            comboativo;
       end
      else
      begin
           EnviarHotkeyAtiva(hotkeycombo);
      end;
      end
       else
         begin
         EnviarHotkeyAtiva(hotkeycombo);
         end;

    6:
    if ativo = 0 then
      begin
           ativo := 1;
           EnviarHotkeyAtiva(VK_RETURN);
           hotkeys;
           exit;
      end
      else
        begin
             ativo := 0;
             EnviarHotkeyAtiva(VK_RETURN);
             unregister;
        end;

  end;
end;

procedure TForm1.hotkeys;
begin
    RegisterHotKey(Handle, 1, 0, hotkeystart);
    RegisterHotKey(Handle, 2, 0, hotkeystop);
    RegisterHotKey(Handle, 3, 0, hotkeyget);
    RegisterHotKey(Handle, 4, 0, hotkeydrop);
    RegisterHotKey(Handle, 5, 0, hotkeycombo);
end;

procedure Tform1.unregister;
begin
  UnregisterHotKey(Handle, 3);
  UnregisterHotKey(Handle, 4);
  UnregisterHotKey(Handle, 5);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  unregister;
  UnregisterHotKey(Handle, 1);
  UnregisterHotKey(Handle, 2);
  UnregisterHotKey(Handle, 6);
end;

procedure TForm1.CarregarConfig;
var
  ArquivoINI: TIniFile;
  i: Integer;
  Comp: TComponent;
  Seccao: string;
begin
  ArquivoINI := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  try
             //--------------------------------//
     CkHwhd.Checked  := ArquivoINI.ReadBool('Checks', 'OnlyInGame', False);
             //-------------------------------//

    edithotkeyget.Text := ArquivoINI.ReadString('Hotkeys', 'HotkeyGetText', '');
    editstart.Text     := ArquivoINI.ReadString('Hotkeys', 'HotkeyStartText', '');
    editkeydrop.Text   := ArquivoINI.ReadString('Hotkeys', 'hotkeydropText', '');
    editkeycombo.Text  := ArquivoINI.ReadString('Hotkeys', 'hotkeycomboText', '');
    editStop.Text      := ArquivoINI.ReadString('Hotkeys', 'hotkeystopText', '');

    xget  := ArquivoINI.ReadInteger('Coordenadas', 'XGet', 0);
    yget  := ArquivoINI.ReadInteger('Coordenadas', 'YGet', 0);
    xdrop := ArquivoINI.ReadInteger('Coordenadas', 'XDrop', 0);
    ydrop := ArquivoINI.ReadInteger('Coordenadas', 'YDrop', 0);

    lbPick1.caption := format('%d, %d', [xget, yget]);
    lbThrow.caption := format('%d, %d', [xdrop, ydrop]);

    ckActCombo.Checked := ArquivoINI.ReadBool('Config', 'ActCombo', False);
    ckpickup.Checked   := ArquivoINI.ReadBool('Config', 'PickUp', False);
    ckthrow.Checked    := ArquivoINI.ReadBool('Config', 'Throw', False);

    hotkeyget   := Word(ArquivoINI.ReadInteger('Hotkeys', 'HotkeyGet', 0));
    hotkeystart := Word(ArquivoINI.ReadInteger('Hotkeys', 'HotkeyStart', 0));
    hotkeydrop  := Word(ArquivoINI.ReadInteger('Hotkeys', 'HotkeyDrop', 0));
    hotkeycombo := Word(ArquivoINI.ReadInteger('Hotkeys', 'HotkeyCombo', 0));
    hotkeystop  := Word(ArquivoINI.ReadInteger('Hotkeys', 'HotkeyStop', 0));

    // --- CARREGANDO OS CÓDIGOS DE MOUSE ---
    codmouseget   := Word(ArquivoINI.ReadInteger('Mouse', 'HotkeyGet', 0));
    codmousecombo := Word(ArquivoINI.ReadInteger('Mouse', 'HotkeyCombo', 0));
    codmousedrop  := Word(ArquivoINI.ReadInteger('Mouse', 'HotkeyDrop', 0));
    codmousestart := Word(ArquivoINI.ReadInteger('Mouse', 'HotkeyStart', 0));
    codmousestop  := Word(ArquivoINI.ReadInteger('Mouse', 'HotkeyStop', 0));

    // --- ATUALIZA AS VARIÁVEIS GLOBAIS COM O QUE FOI CARREGADO ---
    vckcomboPVP := ckActCombo.Checked;
    vckpickup   := ckpickup.Checked;
    vckthrow    := ckthrow.Checked;

    // --- 1. ATAQUE (ATK) ---
    TsMsAtk.Value    := ArquivoINI.ReadInteger('Configuracoes', 'DelayAtk', 200);
    X_SupAtk         := ArquivoINI.ReadInteger('Coordenadas', 'X_Sup', 0);
    Y_SupAtk         := ArquivoINI.ReadInteger('Coordenadas', 'Y_Sup', 0);
    midx             := ArquivoINI.ReadInteger('Coordenadas', 'X_mid', 0);
    midy             := ArquivoINI.ReadInteger('Coordenadas', 'Y_mid', 0);
    X_InfAtk         := ArquivoINI.ReadInteger('Coordenadas', 'X_Inf', 0);
    Y_InfAtk         := ArquivoINI.ReadInteger('Coordenadas', 'Y_Inf', 0);
    CorAtk           := ArquivoINI.ReadInteger('Cores', 'CorAtk', 0);
    CheckAtk.Checked := ArquivoINI.ReadBool('Checks', 'AtivarAtk', False);
    CkMouse.Checked  := ArquivoINI.ReadBool('Checks', 'AtivarMouse', False);

    lbmid.Caption := Format('%d, %d', [midx, midy]);
    lbcrds.Caption := Format('%d, %d', [X_SupAtk, Y_SupAtk]);
    lbcrdi.Caption := Format('%d, %d', [X_InfAtk, Y_InfAtk]);
    lbcor.Color := CorAtk; lbcor.Transparent := False;

    // --- 2. HEALING (Fruta, Life, Mana) ---
    TsMsHeal.Value := ArquivoINI.ReadInteger('Configuracoes', 'DelayHeal', 1050);
    ckheal.Checked := ArquivoINI.ReadBool('Checks', 'AtivarHeal', False);

    // Fruta
    X_ft  := ArquivoINI.ReadInteger('Healing', 'X_ft', 0);
    Y_ft  := ArquivoINI.ReadInteger('Healing', 'Y_ft', 0);
    Corft := ArquivoINI.ReadInteger('Cores', 'Corft', clWhite);
    ckft.Checked := ArquivoINI.ReadBool('Checks', 'UsarFruta', False);
    cbfta.Text   := ArquivoINI.ReadString('Hotkeys', 'HK_Fruit', 'F1'); // Faltava esta linha
    lbft.Color := Corft; lbft.Transparent := False;
    ckft.Caption := Format('%d, %d', [X_ft, Y_ft]);

    // Life
    X_lp  := ArquivoINI.ReadInteger('Healing', 'X_lp', 0);
    Y_lp  := ArquivoINI.ReadInteger('Healing', 'Y_lp', 0);
    Corlp := ArquivoINI.ReadInteger('Cores', 'Corlp', clWhite);
    cklp.Checked := ArquivoINI.ReadBool('Checks', 'UsarLife', False);
    cblp.Text    := ArquivoINI.ReadString('Hotkeys', 'HK_Life', 'F1'); // Faltava esta linha
    lblp.Color := Corlp; lblp.Transparent := False;
    cklp.Caption := Format('%d, %d', [X_lp, Y_lp]);
    PrdLifePot.Checked := ArquivoINI.ReadBool('Checks', 'PrioridadePotLife', False);
          //ArquivoINI.WriteBool('Checks', 'PrioridadePotLife', PrdLifePot.Checked);
    // Mana
    X_Mp  := ArquivoINI.ReadInteger('Healing', 'X_Mp', 0);
    Y_Mp  := ArquivoINI.ReadInteger('Healing', 'Y_Mp', 0);
    CorMp := ArquivoINI.ReadInteger('Cores', 'CorMp', clWhite);
    ckmp.Checked := ArquivoINI.ReadBool('Checks', 'UsarMana', False);
    cbmp.Text    := ArquivoINI.ReadString('Hotkeys', 'HK_Mana', 'F1'); // Faltava esta linha
    lbmp.Color := CorMp; lbmp.Transparent := False;
    ckmp.Caption := Format('%d, %d', [X_Mp, Y_Mp]);
    PrdMana.Checked := ArquivoINI.ReadBool('Checks', 'PrioridadePotMana', true);
    // --- 3. MAGIC LEVEL & COMBO ---
    X_Ml  := ArquivoINI.ReadInteger('ML', 'X_Ml', 0);
    Y_Ml  := ArquivoINI.ReadInteger('ML', 'Y_Ml', 0);
    CorMl := ArquivoINI.ReadInteger('Cores', 'CorMl', clWhite);
    ckml.Checked := ArquivoINI.ReadBool('Checks', 'UsarML', False);
    cbml.Text    := ArquivoINI.ReadString('Hotkeys', 'HK_ML', 'F1'); // Adicionado para ML também
    lbml.Color := CorMl; lbml.Transparent := False;
    ckml.Caption := Format('%d, %d', [X_Ml, Y_Ml]);

    TsCombo.Value   := ArquivoINI.ReadInteger('Configuracoes', 'DelayCombo', 1050);
    ckcombo.Checked := ArquivoINI.ReadBool('Combo', 'AtivarCombo', False);
    for i := 1 to 6 do
    begin
      TComboBox(FindComponent('Mg' + IntToStr(i))).Text := ArquivoINI.ReadString('Combo', 'HK_Mg' + IntToStr(i), 'F1');
      TCheckBox(FindComponent('ckmg' + IntToStr(i))).Checked := ArquivoINI.ReadBool('Combo', 'UsarMg' + IntToStr(i), False);
    end;

    // --- 4. FISHING ---
    X_F1  := ArquivoINI.ReadInteger('Fishing', 'AreaA_X1', 0);
    Y_F1  := ArquivoINI.ReadInteger('Fishing', 'AreaA_Y1', 0);
    X_F2  := ArquivoINI.ReadInteger('Fishing', 'AreaA_X2', 0);
    Y_F2  := ArquivoINI.ReadInteger('Fishing', 'AreaA_Y2', 0);
    X_F1b := ArquivoINI.ReadInteger('Fishing', 'AreaB_X1', 0);
    Y_F1b := ArquivoINI.ReadInteger('Fishing', 'AreaB_Y1', 0);
    X_F2b := ArquivoINI.ReadInteger('Fishing', 'AreaB_X2', 0);
    Y_F2b := ArquivoINI.ReadInteger('Fishing', 'AreaB_Y2', 0);
    MinFishing.Value   := ArquivoINI.ReadInteger('Fishing', 'MinWait', 1000);
    MaxFishing.Value   := ArquivoINI.ReadInteger('Fishing', 'MaxWait', 3000);
    ckfishing2.Checked := ArquivoINI.ReadBool('Fishing', 'UsarAreaB', False);

    lbfishingsup.Caption  := Format('%d,%d', [X_F1, Y_F1]);
    lbfishinginf.Caption  := Format('%d,%d', [X_F2, Y_F2]);
    lbfishingsup1.Caption := Format('%d,%d', [X_F1b, Y_F1b]);
    lbfishinginf1.Caption := Format('%d,%d', [X_F2b, Y_F2b]);

    // --- 5. CAVEBOT GERAL (Faltavam os checks específicos) ---
    ckcoleta.Checked  := ArquivoINI.ReadBool('Cavebot', 'AtivarColeta', False);
    ckCLoot.Checked   := ArquivoINI.ReadBool('Cavebot', 'InterromperPorMob', False);
    ckEsc.Checked     := ArquivoINI.ReadBool('Cavebot', 'UsarEsc', False);
    ckNTp.Checked     := ArquivoINI.ReadBool('Cavebot', 'NaoTravarPausa', False);
    ckumb.Checked     := ArquivoINI.ReadBool('Cavebot', 'UltimoMobBox', False);
    sUtime.Value      := ArquivoINI.ReadInteger('Times', 'sUtime', 1000);
    stimeloot.Value   := ArquivoINI.ReadInteger('Times', 'TimeLoot', 450);
    CkStopMob.Checked := ArquivoINI.ReadBool('Cavebot', 'CkStopMob', False);
    // Waypoints Loop
    for i := 1 to 18 do
    begin
      Comp := FindComponent('ckwpt' + IntToStr(i));
      if Assigned(Comp) then TCheckBox(Comp).Checked := ArquivoINI.ReadBool('Waypoints', 'ck' + IntToStr(i), False);

      Comp := FindComponent('SWpt' + IntToStr(i));
      if Assigned(Comp) then TSpinEdit(Comp).Value := ArquivoINI.ReadInteger('Waypoints', 'tm' + IntToStr(i), 0);
    end;

    // --- 6. LOOT BOX ---
    for i := 1 to 8 do
    begin
      LX[i] := ArquivoINI.ReadInteger('Loot', 'LX' + IntToStr(i), 0);
      LY[i] := ArquivoINI.ReadInteger('Loot', 'LY' + IntToStr(i), 0);
      Comp := FindComponent('bt_l' + IntToStr(i));
      if Assigned(Comp) then TButton(Comp).Caption := Format('%d,%d', [LX[i], LY[i]]);
    end;

    // --- 7. MAPA ---
    lxm := ArquivoINI.ReadInteger('Coordenadas', 'MapaUpperX', 0);
    lym := ArquivoINI.ReadInteger('Coordenadas', 'MapaUpperY', 0);
    rxm := ArquivoINI.ReadInteger('Coordenadas', 'MapaLowerX', 0);
    rym := ArquivoINI.ReadInteger('Coordenadas', 'MapaLowerY', 0);
    X_C := ArquivoINI.ReadInteger('Coordenadas', 'MapaCenterX', 0);
    Y_C := ArquivoINI.ReadInteger('Coordenadas', 'MapaCenterY', 0);
    lbLmap.Caption := Format('%d, %d', [lxm, lym]);
    lbRmap.Caption := Format('%d, %d', [rxm, rym]);

    // ----- buffs -------
    lxb := ArquivoINI.ReadInteger('Buff', 'X1', 0);
    lyb := ArquivoINI.ReadInteger('Buff', 'Y1', 0);
    rxb := ArquivoINI.ReadInteger('Buff', 'X2', 0);
    ryb := ArquivoINI.ReadInteger('Buff', 'Y2', 0);
    lbcrdBu.Caption := Format('%d, %d', [lxb, lyb]);
    lbcrdBL.Caption := Format('%d, %d', [rxb, ryb]);
    //vCkBuffs
    CkBuffs.Checked := ArquivoINI.ReadBool('Buff', 'Principal', False);

    for i := 1 to 3 do
    begin
      Seccao := 'Buff' + IntToStr(i);

      // Carrega Checkbox
      TCheckBox(FindComponent('CkBuff' + IntToStr(i))).Checked :=
        ArquivoINI.ReadBool(Seccao, 'Ativo', False);

      // Carrega Edits
      TEdit(FindComponent('Buff' + IntToStr(i) + 'Name1')).Text :=
        ArquivoINI.ReadString(Seccao, 'Name1', '');
      TEdit(FindComponent('Buff' + IntToStr(i) + 'Name2')).Text :=
        ArquivoINI.ReadString(Seccao, 'Name2', '');

      // Carrega ComboBox
      TComboBox(FindComponent('cbbuff' + IntToStr(i))).Text :=
        ArquivoINI.ReadString(Seccao, 'Hotkey', 'F1');

      // Carrega MaskEdit
      TMaskEdit(FindComponent('MEtimeBuff' + IntToStr(i))).Text :=
        ArquivoINI.ReadString(Seccao, 'Time', '00:00:00');
    end;

    // --- 8. SINCRONIZAÇÃO FINAL ---
    MsAtk := TsMsAtk.Value;
    MsHeal := TsMsHeal.Value;
    MsCombo := TsCombo.Value;
    WptIndex := 1;


  finally
    ArquivoINI.Free;
  end;
end;

procedure TForm1.BotStart;
var
    i: Integer;
  Ckb: TCheckBox;
  Spn: TSpinEdit;
begin
  hotkeys;
  SalvarConfig;
  Randomize;
  EstadoBot := stCaminhando;
  vckcomboPVP := ckActCombo.Checked;
  vckpickup := ckpickup.Checked;
  vckthrow := ckthrow.Checked;
  // 1. Captura de Configurações Gerais
  BotRodando   := True;
  WptIndex     := 1;
  SlotAtual    := 1;
  EstadoBot    := stCaminhando;

  // 2. Captura de Hotkeys (ComboBoxes)
  HotCombo := cbml.Text;
  HotFruit := cbfta.Text;
  HotHeal  := cblp.Text;
  HotMana  := cbmp.Text;
  HotMg1   := Mg1.Text;
  HotMg2   := Mg2.Text;
  HotMg3   := Mg3.Text;
  HotMg4   := Mg4.Text;
  HotMg5   := Mg5.Text;
  HotMg6   := Mg6.Text;

  // 3. Captura de Estados (CheckBoxes)
  vckatk       := checkatk.Checked;
  vckheal      := ckheal.Checked;
  vckml        := ckml.Checked;
  vckmp        := ckmp.Checked;
  vcklp        := cklp.Checked;
  vckft        := ckft.Checked;
  vckcombo     := ckcombo.Checked;
  vckmg1       := ckmg1.Checked;
  vckmg2       := ckmg2.Checked;
  vckmg3       := ckmg3.Checked;
  vckmg4       := ckmg4.Checked;
  vckmg5       := ckmg5.Checked;
  vckmg6       := ckmg6.Checked;
  vckfishing   := ckfishing.Checked;
  vckfishing2  := ckfishing2.Checked;
  vckcoleta    := ckcoleta.Checked;
  vckcloot     := ckcloot.Checked;
  vcknxtp      := ckNTp.Checked;
  vckcavebot   := ckcavebot.Checked;
  vckesc       := ckesc.Checked;
  vckumb       := ckumb.Checked;
  vCkStopMob   := CkStopMob.Checked;
  vCkMouse     := CkMouse.Checked;
  vCkBuffs     := CkBuffs.Checked;
  vCkHwhd      := CkHwhd.Checked;

  // 4. Captura de Valores Numéricos (SpinEdits)
  MsAtk      := TsMsAtk.Value;
  MsHeal     := TsMsHeal.Value;
  MsCombo    := TsCombo.Value;
  vstimeloot := stimeloot.Value;
  vsUtime    := sUtime.Value * 1000;
  vMinFish   := MinFishing.Value;
  vMaxFish   := MaxFishing.Value;
  vPrdMana   := PrdMana.Checked;
  vPrdLifePot := PrdLifePot.Checked;


  // 2. Loop para carregar os 3 Buffs
  for i := 1 to 3 do
  begin
    // Checkbox (vckBuff)
    vckBuff[i] := TCheckBox(FindComponent('CkBuff' + IntToStr(i))).Checked;

    // Nomes dos arquivos de imagem (vBuffName)
    vBuffName[(i-1)*2 + 1] := TEdit(FindComponent('Buff' + IntToStr(i) + 'Name1')).Text;
      vBuffName[(i-1)*2 + 2] := TEdit(FindComponent('Buff' + IntToStr(i) + 'Name2')).Text;
    // vBuffName[(i-1)*3 + 3] := TEdit(FindComponent('Buff' + IntToStr(i) + 'Name3')).Text; // Se houver um terceiro Name

    // Hotkeys (vBuffhk)
    vBuffhk[i] := TComboBox(FindComponent('cbbuff' + IntToStr(i))).Text;

    // Tempo convertido para Milissegundos (vbuffTime)
    vbuffTime[i] := MascaraParaMS(TMaskEdit(FindComponent('MEtimeBuff' + IntToStr(i))).Text);
  end;
  // 5. Preenchimento de Arrays (Waypoints) - Importante para evitar FindComponent na Thread
  for i := 1 to 18 do
  begin
    Ckb := TCheckBox(FindComponent('ckwpt' + IntToStr(i)));
    if Assigned(Ckb) then vchkwpt[i] := Ckb.Checked else vchkwpt[i] := False;

    Spn := TSpinEdit(FindComponent('SWpt' + IntToStr(i)));
    if Assigned(Spn) then vTimeWpt[i] := Spn.Value * 1000 else vTimeWpt[i] := 0;
  end;

  // 6. INICIALIZAÇÃO DAS THREADS (Se não estiverem rodando)
  if level >= 1 then
  begin
  if not Assigned(MeuAtkThread)      then MeuAtkThread      := TAtkThread.Create(False);
  if not Assigned(MeuFishingThread)  then MeuFishingThread  := TFishingThread.Create(False);
  if not Assigned(comobopvpThread)  then comobopvpThread  := TcomobopvpThread.Create(False);
  end;

  if level >= 2 then
  begin
  if not Assigned(MinhaThreadFruit)  then MinhaThreadFruit  := THealThreadFruit.Create(False);
  if not Assigned(MinhaThreadPot)    then MinhaThreadPot    := THealThreadPot.Create(False);
  end;

  if level >= 3 then
  begin
  if not Assigned(MeuComboThread)    then MeuComboThread    := TComboThread.Create(False);
  end;

  if level >= 4 then
  begin
  if not Assigned(MeuBuffThread)     then MeuBuffThread     := TBuffThread.Create(False);
  end;

  if level >= 5 then
  begin
  if not Assigned(MeuCaveThread)     then MeuCaveThread     := TCaveThread.Create(False);
  end;

  // 7. Feedback Visual   comobopvpThread
  lbStatus.Caption := 'Running';
  lbStatus.Font.Color := clGreen;
end;

procedure TForm1.BotStop;
begin
  BotRodando := False; // Sinaliza parada imediata para os loops das threads

  // PARA A THREAD DE HEALING   comobopvpThread
  if Assigned(MinhaThreadFruit) then begin MinhaThreadFruit.Terminate; MinhaThreadFruit.WaitFor; FreeAndNil(MinhaThreadFruit); end;
  if Assigned(MinhaThreadPot) then begin MinhaThreadPot.Terminate; MinhaThreadPot.WaitFor; FreeAndNil(MinhaThreadPot); end;
  if Assigned(comobopvpThread) then begin comobopvpThread.Terminate; comobopvpThread.WaitFor; FreeAndNil(comobopvpThread); end;
  // PARA A THREAD DE ATAQUE
  if Assigned(MeuAtkThread) then
  begin
    MeuAtkThread.Terminate;
    MeuAtkThread.WaitFor;
    FreeAndNil(MeuAtkThread);
  end;

  // PARA A THREAD DE COMBO
  if Assigned(MeuComboThread) then
  begin
    MeuComboThread.Terminate;
    MeuComboThread.WaitFor;
    FreeAndNil(MeuComboThread);
  end;

  // PARA A THREAD DE FISHING
  if Assigned(MeuFishingThread) then
  begin
    MeuFishingThread.Terminate;
    MeuFishingThread.WaitFor;
    FreeAndNil(MeuFishingThread);
  end;

  // PARA A THREAD DE CAVEBOT
  if Assigned(MeuCaveThread) then
  begin
    MeuCaveThread.Terminate;
    MeuCaveThread.WaitFor;
    FreeAndNil(MeuCaveThread);
  end;

    if Assigned(MeuBuffThread) then
  begin
    MeuBuffThread.Terminate;
    MeuBuffThread.WaitFor;
    FreeAndNil(MeuBuffThread);
  end;

  // Feedback Visual
  lbStatus.Caption := 'Stopped';
  lbStatus.Font.Color := clRed;
end;

procedure TForm1.comboativo;
begin
  if comboa = 1 then
  begin
     comboa := 0;
     exit;
  end
  else
  begin
    comboa := 1;
  end;

end;

procedure TForm1.edithotkeygetClick(Sender: TObject);
begin
  UnregisterHotKey(Handle, 3);
  edithotkeyget.text := '';

end;

{ --- INTERFACE E CLIQUES --- }

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var P: TPoint; Titulo: array[0..255] of Char; DC: HDC;
begin
  if (ssCtrl in Shift) and (Key = VK_A) then begin

    GetCursorPos(P);
    H_Jogo := GetAncestor(WindowFromPoint(P), GA_ROOT);

    DC := GetDC(0); CorBox := GetPixel(DC, P.X, P.Y); ReleaseDC(0, DC);

    Windows.ScreenToClient(H_Jogo, P); X_Temp := P.X; Y_Temp := P.Y;

    GetWindowText(H_Jogo, Titulo, 255); lblJanela.Caption := StrPas(Titulo);

    lblCoordenadas.Caption := Format('Rel X: %d | Y: %d', [X_Temp, Y_Temp]);

    lblCor.Color := CorBox; lblCor.Transparent := False;
  end;


end;

procedure TForm1.BtStartClick(Sender: TObject);
begin
SalvarConfig;
BotStart;
hotkeys;
end;

procedure TForm1.BtStopClick(Sender: TObject);
begin
BotStop;
unregister;
UnregisterHotKey(Handle, 6);
end;

procedure TForm1.lblExpandClick(Sender: TObject);
begin Form1.Height := 310; PageControl1.Height := 310; TP_Wayp.Height := 193; end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin TP_Wayp.Height := 59; PageControl1.Height := 256; Form1.Height := 310; end;

procedure TForm1.BtHideClick(Sender: TObject);
begin PageControl1Change(Sender); end;

procedure TForm1.btcorClick(Sender: TObject); begin CorAtk := CorBox; lbcor.Color := CorAtk; lbcor.Transparent := False; end;
procedure TForm1.btsupClick(Sender: TObject); begin X_SupAtk := X_Temp; Y_SupAtk := Y_Temp; lbcrds.Caption := Format('%d, %d', [X_SupAtk, Y_SupAtk]); end;
procedure TForm1.btinfClick(Sender: TObject); begin X_InfAtk := X_Temp; Y_InfAtk := Y_Temp; lbcrdi.Caption := Format('%d, %d', [X_InfAtk, Y_InfAtk]); end;

procedure TForm1.btmlClick(Sender: TObject); begin CorMl := CorBox; X_Ml := X_Temp; Y_Ml := Y_Temp; lbml.Color := CorMl; ckml.Caption := Format('%d, %d', [X_Ml, Y_Ml]); end;
procedure TForm1.btlpClick(Sender: TObject); begin Corlp := CorBox; X_lp := X_Temp; Y_lp := Y_Temp; lblp.Color := Corlp; cklp.Caption := Format('%d, %d', [X_lp, Y_lp]); end;
procedure TForm1.btmanaClick(Sender: TObject); begin CorMp := CorBox; X_Mp := X_Temp; Y_Mp := Y_Temp; lbmp.Color := CorMp; ckmp.Caption := Format('%d, %d', [X_Mp, Y_Mp]); end;
procedure TForm1.btfruitClick(Sender: TObject); begin Corft := CorBox; X_ft := X_Temp; Y_ft := Y_Temp; lbft.Color := Corft; ckft.Caption := Format('%d, %d', [X_ft, Y_ft]); end;
procedure TForm1.bt_l1Click(Sender: TObject); begin LX[1] := X_Temp; LY[1] := Y_Temp; bt_l1.Caption := Format('%d, %d', [LX[1], LY[1]]); end;
procedure TForm1.bt_l2Click(Sender: TObject); begin LX[2] := X_Temp; LY[2] := Y_Temp; bt_l2.Caption := Format('%d, %d', [LX[2], LY[2]]); end;
procedure TForm1.bt_l3Click(Sender: TObject); begin LX[3] := X_Temp; LY[3] := Y_Temp; bt_l3.Caption := Format('%d, %d', [LX[3], LY[3]]); end;
procedure TForm1.bt_l4Click(Sender: TObject); begin LX[4] := X_Temp; LY[4] := Y_Temp; bt_l4.Caption := Format('%d, %d', [LX[4], LY[4]]); end;
procedure TForm1.bt_l5Click(Sender: TObject); begin LX[5] := X_Temp; LY[5] := Y_Temp; bt_l5.Caption := Format('%d, %d', [LX[5], LY[5]]); end;
procedure TForm1.bt_l6Click(Sender: TObject); begin LX[6] := X_Temp; LY[6] := Y_Temp; bt_l6.Caption := Format('%d, %d', [LX[6], LY[6]]); end;
procedure TForm1.bt_l7Click(Sender: TObject); begin LX[7] := X_Temp; LY[7] := Y_Temp; bt_l7.Caption := Format('%d, %d', [LX[7], LY[7]]); end;
procedure TForm1.bt_l8Click(Sender: TObject); begin LX[8] := X_Temp; LY[8] := Y_Temp; bt_l8.Caption := Format('%d, %d', [LX[8], LY[8]]); end;

procedure TForm1.UpdateAtkClick(Sender: TObject);
begin
     SalvarConfig;
     vckatk  := checkatk.Checked;
     vCkMouse     := CkMouse.Checked;
     MsAtk := TsMsAtk.Value;

end;

procedure TForm1.UpdateBuffClick(Sender: TObject);
var
  i: integer;
begin
  SalvarConfig;
  vCkBuffs     := CkBuffs.Checked;
  for i := 1 to 3 do
  begin
    // Checkbox (vckBuff)
    vckBuff[i] := TCheckBox(FindComponent('CkBuff' + IntToStr(i))).Checked;

    // Nomes dos arquivos de imagem (vBuffName)
    vBuffName[(i-1)*2 + 1] := TEdit(FindComponent('Buff' + IntToStr(i) + 'Name1')).Text;
      vBuffName[(i-1)*2 + 2] := TEdit(FindComponent('Buff' + IntToStr(i) + 'Name2')).Text;
    // vBuffName[(i-1)*3 + 3] := TEdit(FindComponent('Buff' + IntToStr(i) + 'Name3')).Text; // Se houver um terceiro Name

    // Hotkeys (vBuffhk)
    vBuffhk[i] := TComboBox(FindComponent('cbbuff' + IntToStr(i))).Text;

    // Tempo convertido para Milissegundos (vbuffTime)
    vbuffTime[i] := MascaraParaMS(TMaskEdit(FindComponent('MEtimeBuff' + IntToStr(i))).Text);
  end;

end;

procedure TForm1.UpdateCaveClick(Sender: TObject);
var
  Ckb: TCheckBox;
  Spn: TSpinEdit;
  i: integer;
begin
    SalvarConfig;
  vckcoleta    := ckcoleta.Checked;
  vckcloot     := ckcloot.Checked;
  vcknxtp      := ckNTp.Checked;
  vckcavebot   := ckcavebot.Checked;
  vckesc       := ckesc.Checked;
  vckumb       := ckumb.Checked;
  vCkStopMob   := CkStopMob.Checked;
  vstimeloot := stimeloot.Value;
  vsUtime    := sUtime.Value;

    for i := 1 to 18 do
  begin
    Ckb := TCheckBox(FindComponent('ckwpt' + IntToStr(i)));
    if Assigned(Ckb) then vchkwpt[i] := Ckb.Checked else vchkwpt[i] := False;

    Spn := TSpinEdit(FindComponent('SWpt' + IntToStr(i)));
    if Assigned(Spn) then vTimeWpt[i] := Spn.Value else vTimeWpt[i] := 0;
  end;


end;

procedure TForm1.UpdateComboClick(Sender: TObject);
begin
    SalvarConfig;
  HotMg1   := Mg1.Text;
  HotMg2   := Mg2.Text;
  HotMg3   := Mg3.Text;
  HotMg4   := Mg4.Text;
  HotMg5   := Mg5.Text;
  HotMg6   := Mg6.Text;

  vckcombo     := ckcombo.Checked;
  vckmg1       := ckmg1.Checked;
  vckmg2       := ckmg2.Checked;
  vckmg3       := ckmg3.Checked;
  vckmg4       := ckmg4.Checked;
  vckmg5       := ckmg5.Checked;
  vckmg6       := ckmg6.Checked;
  MsCombo      := TsCombo.Value;

end;

procedure TForm1.UpdatefishingClick(Sender: TObject);
begin
  SalvarConfig;
  vMinFish   := MinFishing.Value;
  vMaxFish   := MaxFishing.Value;
  vckfishing   := ckfishing.Checked;
  vckfishing2  := ckfishing2.Checked;

end;

procedure TForm1.UpdateHealClick(Sender: TObject);
begin
    SalvarConfig;
  HotCombo := cbml.Text;
  HotFruit := cbfta.Text;
  HotHeal  := cblp.Text;
  HotMana  := cbmp.Text;

  vckheal      := ckheal.Checked;
  vckml        := ckml.Checked;
  vckmp        := ckmp.Checked;
  vcklp        := cklp.Checked;
  vckft        := ckft.Checked;

  MsHeal     := TsMsHeal.Value;
  vPrdMana   := PrdMana.Checked;
  vPrdLifePot := PrdLifePot.Checked;
end;

procedure TForm1.btsupFClick(Sender: TObject);
begin X_F1 := X_Temp; Y_F1 := Y_Temp; lbfishingsup.Caption := Format('%d,%d', [X_F1, Y_F1]); end;

procedure TForm1.btinfFClick(Sender: TObject);
begin X_F2 := X_Temp; Y_F2 := Y_Temp; lbfishinginf.Caption := Format('%d,%d', [X_F2, Y_F2]); end;

procedure TForm1.btsupF1Click(Sender: TObject);
begin X_F1b := X_Temp; Y_F1b := Y_Temp; lbfishingsup1.Caption := Format('%d, %d', [X_F1b, Y_F1b]); end;

procedure TForm1.btinfF1Click(Sender: TObject);
begin X_F2b := X_Temp; Y_F2b := Y_Temp; lbfishinginf1.Caption := Format('%d,%d', [X_F2b, Y_F2b]); end;

procedure TForm1.btmaplClick(Sender: TObject);
begin lxm := X_Temp; lym := Y_Temp; lbLmap.Caption := Format('%d,%d', [lxm, lym]); end;

procedure TForm1.btmaprClick(Sender: TObject);
begin rxm := X_Temp; rym := Y_Temp; lbRmap.Caption := Format('%d, %d', [rxm, rym]); end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Bmp: TBitmap;
  ScreenCanvas: TCanvas;
  P1: TPoint;
  W, H: Integer;
  CaminhoPasta, NomeArquivo: string;
begin
  if H_Jogo = 0 then begin ShowMessage('Select the game (Ctrl+A)!'); Exit; end;

  W := rxb - lxb; H := ryb - lyb;
  if (W <= 0) or (H <= 0) then Exit;

  // Define o caminho da pasta: Pasta do Executável + Imagens
  CaminhoPasta := ExtractFilePath(ParamStr(0)) + 'Imagens' + PathDelim;
  NomeArquivo := CaminhoPasta + NameBuff.text +'.bmp';

  // Garante que a pasta existe (se não existir, ele cria)
  if not DirectoryExists(CaminhoPasta) then
    ForceDirectories(CaminhoPasta);

  P1 := Point(lxb, lyb);
  Windows.ClientToScreen(H_Jogo, P1);

  Bmp := TBitmap.Create;
  ScreenCanvas := TCanvas.Create;
  try
    Bmp.PixelFormat := pf24bit;
    Bmp.SetSize(W, H);
    ScreenCanvas.Handle := GetDC(0);

    try
      Bmp.Canvas.CopyRect(Rect(0, 0, W, H), ScreenCanvas, Rect(P1.X, P1.Y, P1.X+W, P1.Y+H));
    finally
      ReleaseDC(0, ScreenCanvas.Handle);
    end;

    // Salva no caminho completo definido
    Bmp.SaveToFile(NomeArquivo);

  finally
    ScreenCanvas.Free;
    Bmp.Free;
  end;
end;

procedure TForm1.btcrdBLClick(Sender: TObject);
begin
  rxb := X_Temp;
  ryb := Y_Temp;
  lbcrdBL.caption := Format('%d, %d', [rxb, ryb]);
end;

procedure TForm1.btmidClick(Sender: TObject);
begin
  midx := X_Temp; midy := Y_Temp; lbmid.Caption:= Format('%d, %d', [midx, midy]);
end;

procedure TForm1.btPickUpClick(Sender: TObject);
begin
  xget := X_Temp;
  yget := Y_Temp;
  lbPick1.Caption := Format('%d, %d', [xget, yget]);
end;

procedure TForm1.btThrowClick(Sender: TObject);
begin

    xdrop := X_Temp;
    ydrop := Y_Temp;
    lbThrow.Caption := Format('%d, %d', [xdrop, ydrop]);

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  lxb := X_Temp;
  lyb := Y_Temp;
    lbcrdBu.caption := format ('%d, %d', [lxb, lyb]);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    hotkeys;
end;

procedure TForm1.edithotkeygetKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // 1. PRIMEIRO enviamos a tecla real que o usuário apertou para a procedure
  ProcessarHotkey(Key, 0, '');
  // 2. AGORA sim, zeramos o 'Key' para o Lazarus não digitar a letra no Edit
  Key := 0;

  // Exibe o nome traduzido no seu componente de texto
  edithotkeyget.Text := namehotkey;

  // Joga o foco para outro componente (seu botão ou painel) para sair do modo de edição
  hotkey.setFocus;
  hotkeyget := MinhaHotkeyCodigo;
end;

procedure TForm1.edithotkeygetMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  CodMouse: Word;
  TextoMouse: string;
begin
  case Button of
      mbExtra1: begin CodMouse := 5; TextoMouse := 'MB 1';  end; // Geralmente Botão 4
      mbExtra2: begin CodMouse := 6; TextoMouse := 'MB 2';  end; // Geralmente Botão 5

      // Extensão lógica manual até o 17 (Caso o driver envie como botões virtuais estendidos)
      else
        begin
          // O Lazarus não tem constantes para mbExtra3 em diante,
          // então checamos o ID numérico do botão convertido pelo tipo.
          case Ord(Button) of
            5:  begin CodMouse := 7;  TextoMouse := 'MB 3';  end;
            6:  begin CodMouse := 8;  TextoMouse := 'MB 4';  end;
            7:  begin CodMouse := 9;  TextoMouse := 'MB 5';  end;
            8:  begin CodMouse := 10; TextoMouse := 'MB 6';  end;
            9:  begin CodMouse := 11; TextoMouse := 'MB 7';  end;
            10: begin CodMouse := 12; TextoMouse := 'MB 8';  end;
            11: begin CodMouse := 13; TextoMouse := 'MB 9';  end;
            12: begin CodMouse := 14; TextoMouse := 'MB 10'; end;
            13: begin CodMouse := 15; TextoMouse := 'MB 11'; end;
            14: begin CodMouse := 16; TextoMouse := 'MB 12'; end;
            15: begin CodMouse := 17; TextoMouse := 'MB 13'; end;
            16: begin CodMouse := 18; TextoMouse := 'MB 14'; end;
            17: begin CodMouse := 19; TextoMouse := 'MB 15'; end;
          else
            Exit; // Se for um botão desconhecido fora do range, ignora
          end;
        end;
    end;

  // Envia o número do ID e o texto para processar
  ProcessarHotkey(CodMouse, 1, TextoMouse);

  CodMouse := codmouseget;

  // ADICIONADO: Atualiza o texto do Edit quando o usuário clica com o mouse!
  edithotkeyget.Text := namehotkey;
  hotkey.setFocus;
end;

procedure TForm1.editkeycomboClick(Sender: TObject);
begin
    UnregisterHotKey(Handle, 5);
  editkeycombo.text := '';
end;

procedure TForm1.editkeycomboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
       // 1. PRIMEIRO enviamos a tecla real que o usuário apertou para a procedure
  ProcessarHotkey(Key, 0, '');

  // 2. AGORA sim, zeramos o 'Key' para o Lazarus não digitar a letra no Edit
  Key := 0;

  // Exibe o nome traduzido no seu componente de texto
  editkeycombo.Text := namehotkey;

  // Joga o foco para outro componente (seu botão ou painel) para sair do modo de edição
  hotkey.setFocus;
  hotkeycombo := MinhaHotkeyCodigo;
end;

procedure TForm1.editkeycomboMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  CodMouse: Word;
  TextoMouse: string;
begin
  case Button of
      mbExtra1: begin CodMouse := 5; TextoMouse := 'MB 1';  end; // Geralmente Botão 4
      mbExtra2: begin CodMouse := 6; TextoMouse := 'MB 2';  end; // Geralmente Botão 5

      // Extensão lógica manual até o 17 (Caso o driver envie como botões virtuais estendidos)
      else
        begin
          // O Lazarus não tem constantes para mbExtra3 em diante,
          // então checamos o ID numérico do botão convertido pelo tipo.
          case Ord(Button) of
            5:  begin CodMouse := 7;  TextoMouse := 'MB 3';  end;
            6:  begin CodMouse := 8;  TextoMouse := 'MB 4';  end;
            7:  begin CodMouse := 9;  TextoMouse := 'MB 5';  end;
            8:  begin CodMouse := 10; TextoMouse := 'MB 6';  end;
            9:  begin CodMouse := 11; TextoMouse := 'MB 7';  end;
            10: begin CodMouse := 12; TextoMouse := 'MB 8';  end;
            11: begin CodMouse := 13; TextoMouse := 'MB 9';  end;
            12: begin CodMouse := 14; TextoMouse := 'MB 10'; end;
            13: begin CodMouse := 15; TextoMouse := 'MB 11'; end;
            14: begin CodMouse := 16; TextoMouse := 'MB 12'; end;
            15: begin CodMouse := 17; TextoMouse := 'MB 13'; end;
            16: begin CodMouse := 18; TextoMouse := 'MB 14'; end;
            17: begin CodMouse := 19; TextoMouse := 'MB 15'; end;
          else
            Exit; // Se for um botão desconhecido fora do range, ignora
          end;
        end;
    end;

  // Envia o número do ID e o texto para processar
  ProcessarHotkey(CodMouse, 1, TextoMouse);

  CodMouse := codmousecombo;

  // ADICIONADO: Atualiza o texto do Edit quando o usuário clica com o mouse!
  editkeycombo.Text := namehotkey;
  hotkey.setFocus;
end;

procedure TForm1.editkeydropClick(Sender: TObject);
begin
  UnregisterHotKey(Handle, 4);
  editkeydrop.text := '';
end;

procedure TForm1.editkeydropKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      // 1. PRIMEIRO enviamos a tecla real que o usuário apertou para a procedure
  ProcessarHotkey(Key, 0, '');

  // 2. AGORA sim, zeramos o 'Key' para o Lazarus não digitar a letra no Edit
  Key := 0;

  // Exibe o nome traduzido no seu componente de texto
  editkeydrop.Text := namehotkey;

  // Joga o foco para outro componente (seu botão ou painel) para sair do modo de edição
  hotkey.setFocus;
  hotkeydrop := MinhaHotkeyCodigo;
end;

procedure TForm1.editkeydropMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  CodMouse: Word;
  TextoMouse: string;
begin
  case Button of
      mbExtra1: begin CodMouse := 5; TextoMouse := 'MB 1';  end; // Geralmente Botão 4
      mbExtra2: begin CodMouse := 6; TextoMouse := 'MB 2';  end; // Geralmente Botão 5

      // Extensão lógica manual até o 17 (Caso o driver envie como botões virtuais estendidos)
      else
        begin
          // O Lazarus não tem constantes para mbExtra3 em diante,
          // então checamos o ID numérico do botão convertido pelo tipo.
          case Ord(Button) of
            5:  begin CodMouse := 7;  TextoMouse := 'MB 3';  end;
            6:  begin CodMouse := 8;  TextoMouse := 'MB 4';  end;
            7:  begin CodMouse := 9;  TextoMouse := 'MB 5';  end;
            8:  begin CodMouse := 10; TextoMouse := 'MB 6';  end;
            9:  begin CodMouse := 11; TextoMouse := 'MB 7';  end;
            10: begin CodMouse := 12; TextoMouse := 'MB 8';  end;
            11: begin CodMouse := 13; TextoMouse := 'MB 9';  end;
            12: begin CodMouse := 14; TextoMouse := 'MB 10'; end;
            13: begin CodMouse := 15; TextoMouse := 'MB 11'; end;
            14: begin CodMouse := 16; TextoMouse := 'MB 12'; end;
            15: begin CodMouse := 17; TextoMouse := 'MB 13'; end;
            16: begin CodMouse := 18; TextoMouse := 'MB 14'; end;
            17: begin CodMouse := 19; TextoMouse := 'MB 15'; end;
          else
            Exit; // Se for um botão desconhecido fora do range, ignora
          end;
        end;
    end;

  // Envia o número do ID e o texto para processar
  ProcessarHotkey(CodMouse, 1, TextoMouse);

  CodMouse := codmousedrop;

  // ADICIONADO: Atualiza o texto do Edit quando o usuário clica com o mouse!
  editkeydrop.Text := namehotkey;
  hotkey.setFocus;
end;

procedure TForm1.editstartClick(Sender: TObject);
begin
    UnregisterHotKey(Handle, 1);
    editstart.text := '';
end;

procedure TForm1.editstartKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     // 1. PRIMEIRO enviamos a tecla real que o usuário apertou para a procedure
  ProcessarHotkey(Key, 0, '');

  // 2. AGORA sim, zeramos o 'Key' para o Lazarus não digitar a letra no Edit
  Key := 0;

  // Exibe o nome traduzido no seu componente de texto
  editstart.Text := namehotkey;

  // Joga o foco para outro componente (seu botão ou painel) para sair do modo de edição
  hotkey.setFocus;
  hotkeystart := MinhaHotkeyCodigo;
end;

procedure TForm1.editstartMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  CodMouse: Word;
  TextoMouse: string;
begin
  case Button of
      mbExtra1: begin CodMouse := 5; TextoMouse := 'MB 1';  end; // Geralmente Botão 4
      mbExtra2: begin CodMouse := 6; TextoMouse := 'MB 2';  end; // Geralmente Botão 5

      // Extensão lógica manual até o 17 (Caso o driver envie como botões virtuais estendidos)
      else
        begin
          // O Lazarus não tem constantes para mbExtra3 em diante,
          // então checamos o ID numérico do botão convertido pelo tipo.
          case Ord(Button) of
            5:  begin CodMouse := 7;  TextoMouse := 'MB 3';  end;
            6:  begin CodMouse := 8;  TextoMouse := 'MB 4';  end;
            7:  begin CodMouse := 9;  TextoMouse := 'MB 5';  end;
            8:  begin CodMouse := 10; TextoMouse := 'MB 6';  end;
            9:  begin CodMouse := 11; TextoMouse := 'MB 7';  end;
            10: begin CodMouse := 12; TextoMouse := 'MB 8';  end;
            11: begin CodMouse := 13; TextoMouse := 'MB 9';  end;
            12: begin CodMouse := 14; TextoMouse := 'MB 10'; end;
            13: begin CodMouse := 15; TextoMouse := 'MB 11'; end;
            14: begin CodMouse := 16; TextoMouse := 'MB 12'; end;
            15: begin CodMouse := 17; TextoMouse := 'MB 13'; end;
            16: begin CodMouse := 18; TextoMouse := 'MB 14'; end;
            17: begin CodMouse := 19; TextoMouse := 'MB 15'; end;
          else
            Exit; // Se for um botão desconhecido fora do range, ignora
          end;
        end;
    end;

  // Envia o número do ID e o texto para processar
  ProcessarHotkey(CodMouse, 1, TextoMouse);

  CodMouse := codmousestart;

  // ADICIONADO: Atualiza o texto do Edit quando o usuário clica com o mouse!
  editstart.Text := namehotkey;
  hotkey.setFocus;
end;

procedure TForm1.editStopClick(Sender: TObject);
begin
  UnregisterHotKey(Handle, 2);
  editStop.text := '';
end;

procedure TForm1.editStopKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     // 1. PRIMEIRO enviamos a tecla real que o usuário apertou para a procedure
  ProcessarHotkey(Key, 0, '');

  // 2. AGORA sim, zeramos o 'Key' para o Lazarus não digitar a letra no Edit
  Key := 0;

  // Exibe o nome traduzido no seu componente de texto
  editstop.Text := namehotkey;

  // Joga o foco para outro componente (seu botão ou painel) para sair do modo de edição
  hotkey.setFocus;
  hotkeystop := MinhaHotkeyCodigo;
end;

procedure TForm1.editStopMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  CodMouse: Word;
  TextoMouse: string;
begin
  case Button of
      mbExtra1: begin CodMouse := 5; TextoMouse := 'MB 1';  end; // Geralmente Botão 4
      mbExtra2: begin CodMouse := 6; TextoMouse := 'MB 2';  end; // Geralmente Botão 5

      // Extensão lógica manual até o 17 (Caso o driver envie como botões virtuais estendidos)
      else
        begin
          // O Lazarus não tem constantes para mbExtra3 em diante,
          // então checamos o ID numérico do botão convertido pelo tipo.
          case Ord(Button) of
            5:  begin CodMouse := 7;  TextoMouse := 'MB 3';  end;
            6:  begin CodMouse := 8;  TextoMouse := 'MB 4';  end;
            7:  begin CodMouse := 9;  TextoMouse := 'MB 5';  end;
            8:  begin CodMouse := 10; TextoMouse := 'MB 6';  end;
            9:  begin CodMouse := 11; TextoMouse := 'MB 7';  end;
            10: begin CodMouse := 12; TextoMouse := 'MB 8';  end;
            11: begin CodMouse := 13; TextoMouse := 'MB 9';  end;
            12: begin CodMouse := 14; TextoMouse := 'MB 10'; end;
            13: begin CodMouse := 15; TextoMouse := 'MB 11'; end;
            14: begin CodMouse := 16; TextoMouse := 'MB 12'; end;
            15: begin CodMouse := 17; TextoMouse := 'MB 13'; end;
            16: begin CodMouse := 18; TextoMouse := 'MB 14'; end;
            17: begin CodMouse := 19; TextoMouse := 'MB 15'; end;
          else
            Exit; // Se for um botão desconhecido fora do range, ignora
          end;
        end;
    end;

  // Envia o número do ID e o texto para processar
  ProcessarHotkey(CodMouse, 1, TextoMouse);

  CodMouse := codmousestop;

  // ADICIONADO: Atualiza o texto do Edit quando o usuário clica com o mouse!
  editstop.Text := namehotkey;
  hotkey.setFocus;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  comboa := 0;
  ativo  := 1;
  // Ativa o sistema de dicas globalmente
    ShowHint := True;
    lbStatus.ShowHint := True; // Garante que o label aceite dicas

    Application.HintPause := 100;      // Aparece rápido
    Application.HintHidePause := 10000; // Fica visível por 10 segundos
    timeBeginPeriod(1);
  // 1. Verificação de Segurança (Se falhar, nem carrega o resto)
  if not AutenticarHardware then
  begin
    Application.Terminate;
    Exit;
  end;
  // 2. Configurações Visuais da Interface
  Self.BorderStyle := bsSingle;
  Self.BorderIcons := [biSystemMenu, biMinimize];
  Self.Position    := poScreenCenter;

  // 3. Chama o carregamento das configurações do arquivo INI
  CarregarConfig;
  ativo := 1;
  RegisterHotKey(Handle, 6, 0, VK_RETURN);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if BotRodando then
    BtStopClick(Self);
end;

procedure TForm1.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  // Se o mouse estiver no Caption (Barra) ou HTSYSMENU (Ícone)
  if (Msg.Result = HTCAPTION) or (Msg.Result = HTSYSMENU) then
  begin
    // Ativa a dica na posição atual do mouse
    Application.ActivateHint(Mouse.CursorPos);
  end;
end;

end.
