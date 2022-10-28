unit DJPDFReport;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, libjpfpdfextends, libjpfpdf, typinfo;

type

  TRectStyle       = (rsDraw, rsFill, rsDrawFill);
  TTextDirection   = (tdLeftToRight, tdBottomToTop, tdTopToBottom, tdRightToLeft);
  TTexBoxAlignment = (baLeft, baRight, baCenter, baJustify);
  TTextBoxBorder   = (bbAll, bbBottom, bbLeft, bbRight, bbTop);
  TTextBoxBorders  = set of TTextBoxBorder;

  { TDJPDFReport }

  TDJPDFReport = class
  private
    fPDFReport: TJPFpdfExtends;

    fDefaultFontFamily   : TPDFFontFamily;
    fDefaultFontStyle    : TPDFFontStyle;
    fDefaultFontSize     : Double;
    fDefaultFontUnderLine: Boolean;

    fDefaultTextBoxWidth    : Double;
    fDefaultTextBoxHeight   : Double;
    fDefaultTextBoxBorder   : String;
    fDefaultTextBoxLineBreak: Integer;
    fDefaultTextBoxAlign    : String;
    fDefaultTextBoxFill     : Integer;

    fProxyHost: String;
    fProxyPass: String;
    fProxyPort: String;
    fProxyUser: String;

    function BorderToStr(aValue: TTextBoxBorders): String;
    function BoolToInt(aValue: Boolean): Integer;
    function AlignToStr(aValue: TTexBoxAlignment): String;
    function GetRowBorderHeight: Double;
    function GetRowLinesHeight: Double;
    procedure Inicialize(orientation: TPDFOrientation; aAddPage: Boolean = True);
    procedure SetCorePDF(AValue: TJPFpdfExtends);
    procedure SetRowBorderHeight(AValue: Double);
    procedure SetRowLinesHeight(AValue: Double);
  public
    constructor Create(aAddPage: Boolean = True);
    constructor Create(orientation: TPDFOrientation; pageUnit: TPDFUnit;
      pageFormat: TPDFPageFormat; aAddPage: Boolean = True); overload;
    constructor Create(orientation: TPDFOrientation; pageUnit: TPDFUnit;
      pageSizeW: Double; pageSizeH: Double = 0; aAddPage: Boolean = True); overload;
    destructor Destroy; override;

    // Métodos republicados da classe núcleo
    procedure SetMargins(aMarginLeft: Double; aMarginTop: Double;
      aMarginRight: Double = -1);
    procedure SetAutoPageBreak(aAuto: Boolean; aMargin: Double = 0.0);
    procedure SetTitle(aTitle: String);
    procedure SetAuthor(aAuthor: String);
    procedure AliasNbPages(aAlias: String = '{nb}');
    procedure AddPage(aOrientation: TPDFOrientation = poDefault);
    function PageNo: Integer;
    procedure SetTextColor(aColor: TJPColor);
    procedure SetFillColor(aColor: TJPColor);
    procedure SetDrawColor(aColor: TJPColor);
    procedure SetLineWidth(aWidth: Double);
    procedure Line(aX1, aY1, aX2, aY2: Double);
    procedure Text(aX, aY: Double; aText: String);
    procedure Writer(aHeight: Double; aText: String);
    function AcceptPageBreak: Boolean;
    procedure Image(aFileOrURL: String; aX: Double; aY: Double; aWidth: Double;
      aHeight: Double = 0.0);
    procedure Image(aImageStream: TStream; aTypeImageExt: String; aX: double;
      aY: double; aWidth: double; aHeight: double = 0.0); overload;
    procedure SaveToFile(aFile: String);
    function SaveToStream: TStream;
    function SaveToString: String;
    function CreateContentStream(aCS: TPDFContentStream = csToViewBrowser): TStream;

    // Métodos novos, renomeados ou refatorados
    procedure SetFont(aFamily: TPDFFontFamily; aStyle: TPDFFontStyle;
      aSize: Double; aUnderline: Boolean);
    procedure SetFont(aFamily: TPDFFontFamily; aStyle: TPDFFontStyle;
      aSize: Double); overload;
    procedure SetFont(aFamily: TPDFFontFamily; aStyle: TPDFFontStyle); overload;
    procedure SetFont(aFamily: TPDFFontFamily; aSize: double); overload;
    procedure SetFontFamily(aFamily: TPDFFontFamily);
    procedure SetFontStyle(aStyle: TPDFFontStyle);
    procedure SetFontSize(aSize: Double);
    procedure SetFontUnderLine(aUnderline: Boolean);
    procedure Rect(aX, aY, aWidht, aHeight: Double; aStyle: TRectStyle = rsDraw);
    procedure LnBreak(aHeight: Double = 0);
    function GetPgPosX: Double;
    procedure SetPgPosX(aX: Double);
    function GetPgPosY: Double;
    procedure SetPgPosY(aY: Double);
    procedure SetPgPosXY(aX, aY: Double);
    procedure SetTextBoxInnerMargin(aSize: Double = 0.2);
    procedure DrawHorizontalLine(aWidth: Double);

    procedure SetDefTextBoxProperties(aWidth: Double; aHeight: Double;
      aAlign: TTexBoxAlignment; aLineBreak: Boolean; aBorder: TTextBoxBorders;
      aFill: Boolean);

    procedure SetDefTextBoxWidth(aWidth: Double);
    procedure SetDefTextBoxHeight(aHeight: Double);
    procedure SetDefTextBoxAlign(aAlign: TTexBoxAlignment);
    procedure SetDefTextBoxLineBreak(aLineBreak: Boolean);
    procedure SetDefTextBoxBorder(aBorder: TTextBoxBorders);
    procedure SetDefTextBoxFill(aFill: Boolean);

    procedure SetDefTextBoxSize(aWidth: Double; aHeight: Double);
    procedure SetDefTextBoxLine(aAlign: TTexBoxAlignment; aLineBreak: Boolean);
    procedure SetDefTextBoxDraw(aBorder: TTextBoxBorders; aFill: Boolean);

    procedure TextWithDirection(aX, aY: Double; aText: String;
      aDirection: TTextDirection = tdLeftToRight);
    procedure TextWithRotation(aX, aY: Double; aText: String; aTxtAngle: Double;
      aFontAngle: Double = 0);

    procedure TextBox(aText: String = '');
    procedure TextBox(aText: String; aAlign: TTexBoxAlignment; aLineBreak:
      Boolean; aBorder: TTextBoxBorders; aFill: Boolean); overload;
    procedure TextBox(aText: String; aAlign: TTexBoxAlignment; aLineBreak:
      Boolean; aBorder: TTextBoxBorders); overload;
    procedure TextBox(aText: String; aAlign: TTexBoxAlignment; aLineBreak:
      Boolean); overload;
    procedure TextBox(aText: String; aAlign: TTexBoxAlignment); overload;
    procedure TextBox(aText: String; aLineBreak: Boolean); overload;
    procedure TextBox(aText: String; aBorder: TTextBoxBorders; aFill: Boolean); overload;
    procedure TextBox(aWidth: Double; aText: String; aBorder: TTextBoxBorders;
      aFill: Boolean); overload;
    procedure TextBox(aWidth: Double; aHeight: Double; aText: String; aBorder:
      TTextBoxBorders; aFill: Boolean); overload;
    procedure TextBox(aText: String; aBorder: TTextBoxBorders); overload;
    procedure TextBox(aWidth: Double; aText: String; aBorder: TTextBoxBorders); overload;
    procedure TextBox(aWidth: Double; aHeight: Double; aText: String; aBorder:
      TTextBoxBorders); overload;
    procedure TextBox(aWidth: Double; aText: String); overload;
    procedure TextBox(aWidth: Double; aHeight: Double; aText: String); overload;
    procedure TextBox(aWidth: Double; aText: String; aAlign: TTexBoxAlignment); overload;
    procedure TextBox(aWidth: Double; aHeight: Double; aText: String;
      aAlign: TTexBoxAlignment); overload;
    procedure TextBox(aWidth: Double; aText: String; aLineBreak: Boolean); overload;
    procedure TextBox(aWidth: Double; aHeight: Double; aText: String; aLineBreak: Boolean); overload;
    procedure TextBox(aWidth: Double; aText: String; aAlign: TTexBoxAlignment;
      aLineBreak: Boolean); overload;
    procedure TextBox(aWidth: Double; aText: String; aAlign: TTexBoxAlignment;
      aLineBreak: Boolean; aBorder: TTextBoxBorders); overload;
    procedure TextBox(aWidth: Double; aText: String; aAlign: TTexBoxAlignment;
      aLineBreak: Boolean; aBorder: TTextBoxBorders; aFill: Boolean); overload;
    procedure TextBox(aWidth: Double; aHeight: Double; aText: String;
      aAlign: TTexBoxAlignment; aLineBreak: Boolean); overload;
    procedure TextBox(aWidth: Double; aHeight: Double; aText: String;
      aAlign: TTexBoxAlignment; aLineBreak: Boolean; aBorder: TTextBoxBorders); overload;
    procedure TextBox(aWidth: Double; aHeight: Double; aText: String;
      aAlign: TTexBoxAlignment; aLineBreak: Boolean; aBorder: TTextBoxBorders;
      aFill: Boolean); overload;

    procedure MultiTextBox(aText: String = '');
    procedure MultiTextBox(aWidth: Double; aText: String); overload;
    procedure MultiTextBox(aWidth: Double; aHeight: Double; aText: String); overload;

    procedure MultiTextBox(aText: String; aAlign: TTexBoxAlignment); overload;
    procedure MultiTextBox(aWidth: Double; aText: String; aAlign: TTexBoxAlignment); overload;
    procedure MultiTextBox(aWidth: Double; aHeight: Double; aText: String;
      aAlign: TTexBoxAlignment); overload;

    procedure MultiTextBox(aText: String; aBorder: TTextBoxBorders); overload;
    procedure MultiTextBox(aWidth: Double; aText: String; aBorder: TTextBoxBorders); overload;
    procedure MultiTextBox(aWidth: Double; aHeight: Double; aText: String;
      aBorder: TTextBoxBorders); overload;

    procedure MultiTextBox(aText: String; aBorder: TTextBoxBorders;
      aFill: Boolean); overload;
    procedure MultiTextBox(aWidth: Double; aText: String; aBorder: TTextBoxBorders;
      aFill: Boolean); overload;
    procedure MultiTextBox(aWidth: Double; aHeight: Double; aText: String;
      aBorder: TTextBoxBorders; aFill: Boolean); overload;

    procedure MultiTextBox(aText: String; aAlign: TTexBoxAlignment;
      aBorder: TTextBoxBorders; aFill: Boolean); overload;
    procedure MultiTextBox(aWidth: Double; aText: String; aAlign: TTexBoxAlignment;
      aBorder: TTextBoxBorders; aFill: Boolean); overload;
    procedure MultiTextBox(aWidth: Double; aHeight: Double; aText: String;
      aAlign: TTexBoxAlignment; aBorder: TTextBoxBorders; aFill: Boolean); overload;

    procedure SetTableWidths(aWidths: array of Double);
    procedure SetTableAligns(aAligns: array of TTexBoxAlignment);
    procedure SetTableTitles(aTitles: array of String; aUseBorders: Boolean = True;
      aRepeatTitleOnNewPage: Boolean = True; aFill: Boolean = True);
    procedure DrawTableTitles;
    procedure TableRow(aData: array of String; aUseBorders: Boolean = True;
      aFill: Boolean = False);

    function ConvertTAlignmentToTTexBoxAlignment(Alignment: TAlignment): TTexBoxAlignment;

    // Acesso aos métodos base e extensões da classe núcleo
    property CorePDF: TJPFpdfExtends read fPDFReport write SetCorePDF;
    property ProxyHost: String       read fProxyHost Write fProxyHost;
    property ProxyPort: String       read fProxyPort Write fProxyPort;
    property ProxyUser: String       read fProxyUser Write fProxyUser;
    property ProxyPass: String       read fProxyPass Write fProxyPass;

    property RowBorderHeight: Double read GetRowBorderHeight write SetRowBorderHeight;
    property RowLinesHeight : Double read GetRowLinesHeight  write SetRowLinesHeight;
  end;

implementation

{ TDJPDFReport }

function TDJPDFReport.BorderToStr(aValue: TTextBoxBorders): String;
begin
  Result := '';
  if (bbAll in aValue) then
    Result := '1'
  else
  begin
    if (bbBottom in aValue) then
      Result := 'B';

    if (bbLeft in aValue) then
      Result := Result + 'L';

    if (bbRight in aValue) then
      Result := Result + 'R';

    if (bbTop in aValue) then
      Result := Result + 'T';

    if (Result = '') then
      Result := '0';
  end;
end;

function TDJPDFReport.BoolToInt(aValue: Boolean): Integer;
begin
  Result := 0;
  if aValue then
    Result := 1;
end;

function TDJPDFReport.AlignToStr(aValue: TTexBoxAlignment): String;
begin
  Result := '';
  case aValue of
    baJustify: Result := 'J';
    baCenter : Result := 'C';
    baRight  : Result := 'R';
  end;
end;

function TDJPDFReport.GetRowBorderHeight: Double;
begin
  Result := fPDFReport.RowBorderHeight;
end;

function TDJPDFReport.GetRowLinesHeight: Double;
begin
  Result := fPDFReport.RowLinesHeight;
end;

procedure TDJPDFReport.Inicialize(orientation: TPDFOrientation;
  aAddPage: Boolean);
begin
  fProxyHost := '';
  fProxyPass := '';
  fProxyPort := '';
  fProxyUser := '';

  fDefaultFontFamily    := ffHelvetica;
  fDefaultFontStyle     := fsNormal;
  fDefaultFontSize      := 10;
  fDefaultFontUnderLine := False;

  fDefaultTextBoxWidth     := 0.0;
  fDefaultTextBoxHeight    := 0.0;
  fDefaultTextBoxBorder    := '0';
  fDefaultTextBoxLineBreak := 0;
  fDefaultTextBoxAlign     := '';
  fDefaultTextBoxFill      := 0;

  DefaultSystemCodePage := 1252;

  with fPDFReport do
  begin
    compress := True;
    SetUTF8(True);
    SetTitle('Relatorio');
    SetAuthor('DJSystem');
    SetMargins(5, 5, 5);
    SetAutoPageBreak(true, 10);

    if aAddPage then
      AddPage(orientation);

    AliasNbPages();

    SetTextColor(cBlack);
    SetDrawColor(cBlack);
    SetFillColor(cSilver);

    SetFont(fDefaultFontFamily, fDefaultFontStyle, fDefaultFontSize,
            fDefaultFontUnderLine);
  end;
end;

procedure TDJPDFReport.SetCorePDF(AValue: TJPFpdfExtends);
var
  vOrientation: TPDFOrientation;
begin
  if FPDFReport = AValue then
    Exit;

  vOrientation := fPDFReport.DefOrientation;
  fPDFReport.Free;
  FPDFReport := AValue;
  Inicialize(vOrientation, False);
  CorePDF.AddPage(vOrientation);
end;

procedure TDJPDFReport.SetRowBorderHeight(AValue: Double);
begin
  fPDFReport.RowBorderHeight := AValue;
end;

procedure TDJPDFReport.SetRowLinesHeight(AValue: Double);
begin
  fPDFReport.RowLinesHeight := AValue;
end;

constructor TDJPDFReport.Create(aAddPage: Boolean);
begin
  fPDFReport := TJPFpdfExtends.Create;
  Inicialize(poPortrait, aAddPage);
end;

constructor TDJPDFReport.Create(orientation: TPDFOrientation;
  pageUnit: TPDFUnit; pageFormat: TPDFPageFormat; aAddPage: Boolean);
begin
  fPDFReport := TJPFpdfExtends.Create(orientation, pageUnit, pageFormat);
  Inicialize(orientation, aAddPage);
end;

constructor TDJPDFReport.Create(orientation: TPDFOrientation;
  pageUnit: TPDFUnit; pageSizeW: Double; pageSizeH: Double; aAddPage: Boolean);
begin
  fPDFReport := TJPFpdfExtends.Create(orientation, pageUnit, pageSizeW, pageSizeH);
  Inicialize(orientation, aAddPage);
end;

destructor TDJPDFReport.Destroy;
begin
  fPDFReport.Destroy;
  inherited Destroy;
end;

procedure TDJPDFReport.SetMargins(aMarginLeft: Double; aMarginTop: Double;
  aMarginRight: Double);
begin
  fPDFReport.SetMargins(aMarginLeft, aMarginTop, aMarginRight);
end;

procedure TDJPDFReport.SetAutoPageBreak(aAuto: Boolean; aMargin: Double);
begin
  fPDFReport.SetAutoPageBreak(aAuto, aMargin);
end;

procedure TDJPDFReport.SetTitle(aTitle: String);
begin
  fPDFReport.SetTitle(aTitle);
end;

procedure TDJPDFReport.SetAuthor(aAuthor: String);
begin
  fPDFReport.SetAuthor(aAuthor);
end;

procedure TDJPDFReport.AliasNbPages(aAlias: String);
begin
  fPDFReport.AliasNbPages(aAlias);
end;

procedure TDJPDFReport.AddPage(aOrientation: TPDFOrientation);
begin
  fPDFReport.AddPage(aOrientation);
end;

function TDJPDFReport.PageNo: Integer;
begin
  Result := fPDFReport.PageNo;
end;

procedure TDJPDFReport.SetTextColor(aColor: TJPColor);
begin
  fPDFReport.SetTextColor(aColor);
end;

procedure TDJPDFReport.SetFillColor(aColor: TJPColor);
begin
  fPDFReport.SetFillColor(aColor);
end;

procedure TDJPDFReport.SetDrawColor(aColor: TJPColor);
begin
  fPDFReport.SetDrawColor(aColor);
end;

procedure TDJPDFReport.SetLineWidth(aWidth: Double);
begin
  fPDFReport.SetLineWidth(aWidth);
end;

procedure TDJPDFReport.Line(aX1, aY1, aX2, aY2: Double);
begin
  fPDFReport.Line(aX1, aY1, aX2, aY2);
end;

procedure TDJPDFReport.Rect(aX, aY, aWidht, aHeight: Double; aStyle: TRectStyle
  );
var
  vStl: String;
begin
  vStl := 'D';
  case aStyle of
    rsFill    : vStl := 'F';
    rsDrawFill: vStl := 'FD';
  end;

  fPDFReport.Rect(aX, aY, aWidht, aHeight, vStl);
end;

procedure TDJPDFReport.LnBreak(aHeight: Double);
begin
  fPDFReport.Ln(aHeight);
end;

function TDJPDFReport.GetPgPosX: Double;
begin
  Result := fPDFReport.GetX;
end;

procedure TDJPDFReport.SetPgPosX(aX: Double);
begin
  fPDFReport.SetX(aX);
end;

function TDJPDFReport.GetPgPosY: Double;
begin
  Result := fPDFReport.GetY;
end;

procedure TDJPDFReport.SetPgPosY(aY: Double);
begin
  fPDFReport.SetY(aY);
end;

procedure TDJPDFReport.SetPgPosXY(aX, aY: Double);
begin
  fPDFReport.SetXY(aX, aY);
end;

procedure TDJPDFReport.SetTextBoxInnerMargin(aSize: Double);
begin
  fPDFReport.cMargin := aSize;
end;

procedure TDJPDFReport.DrawHorizontalLine(aWidth: Double);
begin
  fPDFReport.MultiCell(aWidth, 1, ' ', 'B');
end;

procedure TDJPDFReport.SetDefTextBoxProperties(aWidth: Double; aHeight: Double;
  aAlign: TTexBoxAlignment; aLineBreak: Boolean; aBorder: TTextBoxBorders;
  aFill: Boolean);
begin
  fDefaultTextBoxWidth     := aWidth;
  fDefaultTextBoxHeight    := aHeight;
  fDefaultTextBoxBorder    := BorderToStr(aBorder);
  fDefaultTextBoxLineBreak := BoolToInt(aLineBreak);
  fDefaultTextBoxAlign     := AlignToStr(aAlign);
  fDefaultTextBoxFill      := BoolToInt(aFill);
end;

procedure TDJPDFReport.SetDefTextBoxWidth(aWidth: Double);
begin
  fDefaultTextBoxWidth := aWidth;
end;

procedure TDJPDFReport.SetDefTextBoxHeight(aHeight: Double);
begin
  fDefaultTextBoxHeight := aHeight;
end;

procedure TDJPDFReport.SetDefTextBoxAlign(aAlign: TTexBoxAlignment);
begin
  fDefaultTextBoxAlign := AlignToStr(aAlign);
end;

procedure TDJPDFReport.SetDefTextBoxLineBreak(aLineBreak: Boolean);
begin
  fDefaultTextBoxLineBreak := BoolToInt(aLineBreak);
end;

procedure TDJPDFReport.SetDefTextBoxBorder(aBorder: TTextBoxBorders);
begin
  fDefaultTextBoxBorder := BorderToStr(aBorder);
end;

procedure TDJPDFReport.SetDefTextBoxFill(aFill: Boolean);
begin
  fDefaultTextBoxFill := BoolToInt(aFill);
end;

procedure TDJPDFReport.SetDefTextBoxSize(aWidth: Double; aHeight: Double);
begin
  fDefaultTextBoxWidth  := aWidth;
  fDefaultTextBoxHeight := aHeight;
end;

procedure TDJPDFReport.SetDefTextBoxLine(aAlign: TTexBoxAlignment;
  aLineBreak: Boolean);
begin
  fDefaultTextBoxAlign     := AlignToStr(aAlign);
  fDefaultTextBoxLineBreak := BoolToInt(aLineBreak);
end;

procedure TDJPDFReport.SetDefTextBoxDraw(aBorder: TTextBoxBorders;
  aFill: Boolean);
begin
  fDefaultTextBoxBorder := BorderToStr(aBorder);
  fDefaultTextBoxFill   := BoolToInt(aFill);
end;

procedure TDJPDFReport.TextWithDirection(aX, aY: Double; aText: String;
  aDirection: TTextDirection);
var
  vDirection: String;
begin
  vDirection := 'R';
  case aDirection of
    tdLeftToRight: vDirection := 'R';
    tdBottomToTop: vDirection := 'U';
    tdTopToBottom: vDirection := 'D';
    tdRightToLeft: vDirection := 'L';
  end;
  fPDFReport.TextWithDirection(aX, aY, aText, vDirection);
end;

procedure TDJPDFReport.TextWithRotation(aX, aY: Double; aText: String;
  aTxtAngle: Double; aFontAngle: Double);
begin
  fPDFReport.TextWithRotation(aX, aY, aText, aTxtAngle, aFontAngle);
end;

procedure TDJPDFReport.SetFontUnderLine(aUnderline: Boolean);
begin
  fDefaultFontUnderLine := aUnderline;
  fPDFReport.SetUnderline(aUnderline);
end;

procedure TDJPDFReport.Text(aX, aY: Double; aText: String);
begin
  fPDFReport.Text(aX, aY, aText);
end;

procedure TDJPDFReport.Writer(aHeight: Double; aText: String);
begin
  fPDFReport.Writer(aHeight, aText);
end;

function TDJPDFReport.AcceptPageBreak: Boolean;
begin
  Result := fPDFReport.AcceptPageBreak;
end;

procedure TDJPDFReport.Image(aFileOrURL: String; aX: Double; aY: Double;
  aWidth: Double; aHeight: Double);
begin
  fPDFReport.ProxyHost := ProxyHost;
  fPDFReport.ProxyPort := ProxyPort;
  fPDFReport.ProxyUser := ProxyUser;
  fPDFReport.ProxyPass := ProxyPass;

  fPDFReport.Image(aFileOrURL, aX, aY, aWidth, aHeight);
end;

procedure TDJPDFReport.Image(aImageStream: TStream; aTypeImageExt: String;
  aX: double; aY: double; aWidth: double; aHeight: double);
begin
  fPDFReport.Image(aImageStream, aTypeImageExt, aX, aY, aWidth, aHeight);
end;

procedure TDJPDFReport.SaveToFile(aFile: String);
begin
  fPDFReport.SaveToFile(aFile);
end;

function TDJPDFReport.SaveToStream: TStream;
begin
  Result := fPDFReport.SaveToStream;
end;

function TDJPDFReport.SaveToString: String;
begin
  Result := fPDFReport.SaveToString;
end;

function TDJPDFReport.CreateContentStream(aCS: TPDFContentStream): TStream;
begin
  Result := fPDFReport.CreateContentStream(aCS);
end;

procedure TDJPDFReport.SetFont(aFamily: TPDFFontFamily; aStyle: TPDFFontStyle);
begin
  fDefaultFontFamily := aFamily;
  fDefaultFontStyle  := aStyle;
  fPDFReport.SetFont(fDefaultFontFamily, fDefaultFontStyle, fDefaultFontSize,
                     fDefaultFontUnderLine);
end;

procedure TDJPDFReport.SetFont(aFamily: TPDFFontFamily; aSize: double);
begin
  fDefaultFontFamily := aFamily;
  fDefaultFontSize   := aSize;
  fPDFReport.SetFont(fDefaultFontFamily, fDefaultFontStyle, fDefaultFontSize,
                     fDefaultFontUnderLine);
end;

procedure TDJPDFReport.SetFont(aFamily: TPDFFontFamily; aStyle: TPDFFontStyle;
  aSize: Double);
begin
  fDefaultFontFamily := aFamily;
  fDefaultFontStyle  := aStyle;
  fDefaultFontSize   := aSize;
  fPDFReport.SetFont(fDefaultFontFamily, fDefaultFontStyle, fDefaultFontSize,
                     fDefaultFontUnderLine);
end;

procedure TDJPDFReport.SetFont(aFamily: TPDFFontFamily; aStyle: TPDFFontStyle;
  aSize: Double; aUnderline: Boolean);
begin
  fDefaultFontFamily    := aFamily;
  fDefaultFontStyle     := aStyle;
  fDefaultFontSize      := aSize;
  fDefaultFontUnderLine := aUnderline;
  fPDFReport.SetFont(fDefaultFontFamily, fDefaultFontStyle, fDefaultFontSize,
                     fDefaultFontUnderLine);
end;

procedure TDJPDFReport.SetFontFamily(aFamily: TPDFFontFamily);
begin
  fDefaultFontFamily := aFamily;
  fPDFReport.SetFont(fDefaultFontFamily, fDefaultFontStyle, fDefaultFontSize,
                     fDefaultFontUnderLine);
end;

procedure TDJPDFReport.SetFontStyle(aStyle: TPDFFontStyle);
begin
  fDefaultFontStyle := aStyle;
  fPDFReport.SetFont(fDefaultFontFamily, fDefaultFontStyle, fDefaultFontSize,
                     fDefaultFontUnderLine);
end;

procedure TDJPDFReport.SetFontSize(aSize: Double);
begin
  fDefaultFontSize := aSize;
  fPDFReport.SetFont(fDefaultFontFamily, fDefaultFontStyle, fDefaultFontSize,
                     fDefaultFontUnderLine);
end;

procedure TDJPDFReport.TextBox(aText: String);
begin
  fPDFReport.Cell(fDefaultTextBoxWidth, fDefaultTextBoxHeight, aText,
                  fDefaultTextBoxBorder, fDefaultTextBoxLineBreak,
                  fDefaultTextBoxAlign, fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aText: String; aAlign: TTexBoxAlignment;
  aLineBreak: Boolean; aBorder: TTextBoxBorders; aFill: Boolean);
begin
  fPDFReport.Cell(fDefaultTextBoxWidth, fDefaultTextBoxHeight, aText,
                  BorderToStr(aBorder), BoolToInt(aLineBreak),
                  AlignToStr(aAlign), BoolToInt(aFill));
end;

procedure TDJPDFReport.TextBox(aText: String; aAlign: TTexBoxAlignment;
  aLineBreak: Boolean; aBorder: TTextBoxBorders);
begin
  fPDFReport.Cell(fDefaultTextBoxWidth, fDefaultTextBoxHeight, aText,
                  BorderToStr(aBorder), BoolToInt(aLineBreak),
                  AlignToStr(aAlign), fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aText: String; aAlign: TTexBoxAlignment;
  aLineBreak: Boolean);
begin
  fPDFReport.Cell(fDefaultTextBoxWidth, fDefaultTextBoxHeight, aText,
                  fDefaultTextBoxBorder, BoolToInt(aLineBreak),
                  AlignToStr(aAlign), fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aText: String; aAlign: TTexBoxAlignment);
begin
  fPDFReport.Cell(fDefaultTextBoxWidth, fDefaultTextBoxHeight, aText,
                  fDefaultTextBoxBorder, fDefaultTextBoxLineBreak,
                  AlignToStr(aAlign), fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aText: String; aLineBreak: Boolean);
begin
  fPDFReport.Cell(fDefaultTextBoxWidth, fDefaultTextBoxHeight, aText,
                  fDefaultTextBoxBorder, BoolToInt(aLineBreak),
                  fDefaultTextBoxAlign, fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aText: String; aBorder: TTextBoxBorders;
  aFill: Boolean);
begin
  fPDFReport.Cell(fDefaultTextBoxWidth, fDefaultTextBoxHeight, aText,
                  BorderToStr(aBorder), fDefaultTextBoxLineBreak,
                  fDefaultTextBoxAlign, BoolToInt(aFill));
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aText: String;
  aBorder: TTextBoxBorders; aFill: Boolean);
begin
  fPDFReport.Cell(aWidth, fDefaultTextBoxHeight, aText, BorderToStr(aBorder),
                  fDefaultTextBoxLineBreak, fDefaultTextBoxAlign,
                  BoolToInt(aFill));
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aHeight: Double; aText: String;
  aBorder: TTextBoxBorders; aFill: Boolean);
begin
  fPDFReport.Cell(aWidth, aHeight, aText, BorderToStr(aBorder),
                  fDefaultTextBoxLineBreak, fDefaultTextBoxAlign,
                  BoolToInt(aFill));
end;

procedure TDJPDFReport.TextBox(aText: String; aBorder: TTextBoxBorders);
begin
  fPDFReport.Cell(fDefaultTextBoxWidth, fDefaultTextBoxHeight, aText,
                  BorderToStr(aBorder), fDefaultTextBoxLineBreak,
                  fDefaultTextBoxAlign, fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aText: String;
  aBorder: TTextBoxBorders);
begin
  fPDFReport.Cell(aWidth, fDefaultTextBoxHeight, aText,
                  BorderToStr(aBorder), fDefaultTextBoxLineBreak,
                  fDefaultTextBoxAlign, fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aHeight: Double; aText: String;
  aBorder: TTextBoxBorders);
begin
  fPDFReport.Cell(aWidth, aHeight, aText, BorderToStr(aBorder),
                  fDefaultTextBoxLineBreak, fDefaultTextBoxAlign,
                  fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aText: String);
begin
  fPDFReport.Cell(aWidth, fDefaultTextBoxHeight, aText, fDefaultTextBoxBorder,
                  fDefaultTextBoxLineBreak, fDefaultTextBoxAlign,
                  fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aHeight: Double;
  aText: String);
begin
  fPDFReport.Cell(aWidth, aHeight, aText, fDefaultTextBoxBorder,
                  fDefaultTextBoxLineBreak, fDefaultTextBoxAlign,
                  fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aText: String;
  aAlign: TTexBoxAlignment; aLineBreak: Boolean);
begin
  fPDFReport.Cell(aWidth, fDefaultTextBoxHeight, aText, fDefaultTextBoxBorder,
                  BoolToInt(aLineBreak), AlignToStr(aAlign), fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aText: String;
  aAlign: TTexBoxAlignment; aLineBreak: Boolean; aBorder: TTextBoxBorders);
begin
  fPDFReport.Cell(aWidth, fDefaultTextBoxHeight, aText, BorderToStr(aBorder),
                  BoolToInt(aLineBreak), AlignToStr(aAlign), fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aText: String;
  aAlign: TTexBoxAlignment; aLineBreak: Boolean; aBorder: TTextBoxBorders;
  aFill: Boolean);
begin
  fPDFReport.Cell(aWidth, fDefaultTextBoxHeight, aText, BorderToStr(aBorder),
                  BoolToInt(aLineBreak), AlignToStr(aAlign), BoolToInt(aFill));
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aHeight: Double;
  aText: String; aAlign: TTexBoxAlignment; aLineBreak: Boolean);
begin
  fPDFReport.Cell(aWidth, aHeight, aText, fDefaultTextBoxBorder, BoolToInt(aLineBreak),
                  AlignToStr(aAlign), fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aHeight: Double; aText: String;
  aAlign: TTexBoxAlignment; aLineBreak: Boolean; aBorder: TTextBoxBorders);
begin
  fPDFReport.Cell(aWidth, aHeight, aText, BorderToStr(aBorder), BoolToInt(aLineBreak),
                  AlignToStr(aAlign), fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aHeight: Double; aText: String;
  aAlign: TTexBoxAlignment; aLineBreak: Boolean; aBorder: TTextBoxBorders;
  aFill: Boolean);
begin
  fPDFReport.Cell(aWidth, aHeight, aText, BorderToStr(aBorder), BoolToInt(aLineBreak),
                  AlignToStr(aAlign), BoolToInt(aFill));
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aText: String;
  aAlign: TTexBoxAlignment);
begin
  fPDFReport.Cell(aWidth, fDefaultTextBoxHeight, aText, fDefaultTextBoxBorder,
                  fDefaultTextBoxLineBreak, AlignToStr(aAlign), fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aHeight: Double;
  aText: String; aAlign: TTexBoxAlignment);
begin
  fPDFReport.Cell(aWidth, aHeight, aText, fDefaultTextBoxBorder,
                  fDefaultTextBoxLineBreak, AlignToStr(aAlign), fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aText: String;
  aLineBreak: Boolean);
begin
  fPDFReport.Cell(aWidth, fDefaultTextBoxHeight, aText, fDefaultTextBoxBorder,
                  BoolToInt(aLineBreak), fDefaultTextBoxAlign, fDefaultTextBoxFill);
end;

procedure TDJPDFReport.TextBox(aWidth: Double; aHeight: Double;
  aText: String; aLineBreak: Boolean);
begin
  fPDFReport.Cell(aWidth, aHeight, aText, fDefaultTextBoxBorder,
                  BoolToInt(aLineBreak), fDefaultTextBoxAlign, fDefaultTextBoxFill);
end;

procedure TDJPDFReport.MultiTextBox(aText: String);
begin
  fPDFReport.MultiCell(fDefaultTextBoxWidth, fDefaultTextBoxHeight, aText,
                       fDefaultTextBoxBorder, fDefaultTextBoxAlign,
                       fDefaultTextBoxFill);
end;

procedure TDJPDFReport.MultiTextBox(aWidth: Double; aText: String);
begin
  fPDFReport.MultiCell(aWidth, fDefaultTextBoxHeight, aText,
                       fDefaultTextBoxBorder, fDefaultTextBoxAlign,
                       fDefaultTextBoxFill);
end;

procedure TDJPDFReport.MultiTextBox(aWidth: Double; aHeight: Double;
  aText: String);
begin
  fPDFReport.MultiCell(aWidth, aHeight, aText, fDefaultTextBoxBorder,
                       fDefaultTextBoxAlign, fDefaultTextBoxFill);
end;

procedure TDJPDFReport.MultiTextBox(aText: String; aAlign: TTexBoxAlignment);
begin
  fPDFReport.MultiCell(fDefaultTextBoxWidth, fDefaultTextBoxHeight, aText,
                       fDefaultTextBoxBorder, AlignToStr(aAlign),
                       fDefaultTextBoxFill);
end;

procedure TDJPDFReport.MultiTextBox(aWidth: Double; aText: String;
  aAlign: TTexBoxAlignment);
begin
  fPDFReport.MultiCell(aWidth, fDefaultTextBoxHeight, aText, fDefaultTextBoxBorder,
                       AlignToStr(aAlign), fDefaultTextBoxFill);
end;

procedure TDJPDFReport.MultiTextBox(aWidth: Double; aHeight: Double;
  aText: String; aAlign: TTexBoxAlignment);
begin
  fPDFReport.MultiCell(aWidth, aHeight, aText, fDefaultTextBoxBorder,
                       AlignToStr(aAlign), fDefaultTextBoxFill);
end;

procedure TDJPDFReport.MultiTextBox(aText: String; aBorder: TTextBoxBorders);
begin
  fPDFReport.MultiCell(fDefaultTextBoxWidth, fDefaultTextBoxHeight, aText,
                       BorderToStr(aBorder), fDefaultTextBoxAlign,
                       fDefaultTextBoxFill);
end;

procedure TDJPDFReport.MultiTextBox(aWidth: Double; aText: String;
  aBorder: TTextBoxBorders);
begin
  fPDFReport.MultiCell(aWidth, fDefaultTextBoxHeight, aText,
                       BorderToStr(aBorder), fDefaultTextBoxAlign,
                       fDefaultTextBoxFill);
end;

procedure TDJPDFReport.MultiTextBox(aWidth: Double; aHeight: Double;
  aText: String; aBorder: TTextBoxBorders);
begin
  fPDFReport.MultiCell(aWidth, aHeight, aText,
                       BorderToStr(aBorder), fDefaultTextBoxAlign,
                       fDefaultTextBoxFill);
end;

procedure TDJPDFReport.MultiTextBox(aText: String; aBorder: TTextBoxBorders;
  aFill: Boolean);
begin
  fPDFReport.MultiCell(fDefaultTextBoxWidth, fDefaultTextBoxHeight, aText,
                       BorderToStr(aBorder), fDefaultTextBoxAlign,
                       BoolToInt(aFill));
end;

procedure TDJPDFReport.MultiTextBox(aWidth: Double; aText: String;
  aBorder: TTextBoxBorders; aFill: Boolean);
begin
  fPDFReport.MultiCell(aWidth, fDefaultTextBoxHeight, aText,
                       BorderToStr(aBorder), fDefaultTextBoxAlign,
                       BoolToInt(aFill));
end;

procedure TDJPDFReport.MultiTextBox(aWidth: Double; aHeight: Double;
  aText: String; aBorder: TTextBoxBorders; aFill: Boolean);
begin
  fPDFReport.MultiCell(aWidth, aHeight, aText,
                       BorderToStr(aBorder), fDefaultTextBoxAlign,
                       BoolToInt(aFill));
end;

procedure TDJPDFReport.MultiTextBox(aText: String; aAlign: TTexBoxAlignment;
  aBorder: TTextBoxBorders; aFill: Boolean);
begin
  fPDFReport.MultiCell(fDefaultTextBoxWidth, fDefaultTextBoxHeight, aText,
                       BorderToStr(aBorder), AlignToStr(aAlign), BoolToInt(aFill));
end;

procedure TDJPDFReport.MultiTextBox(aWidth: Double; aText: String;
  aAlign: TTexBoxAlignment; aBorder: TTextBoxBorders; aFill: Boolean);
begin
  fPDFReport.MultiCell(aWidth, fDefaultTextBoxHeight, aText, BorderToStr(aBorder),
                       AlignToStr(aAlign), BoolToInt(aFill));
end;

procedure TDJPDFReport.MultiTextBox(aWidth: Double; aHeight: Double;
  aText: String; aAlign: TTexBoxAlignment; aBorder: TTextBoxBorders;
  aFill: Boolean);
begin
  fPDFReport.MultiCell(aWidth, aHeight, aText, BorderToStr(aBorder),
                       AlignToStr(aAlign), BoolToInt(aFill));
end;

procedure TDJPDFReport.SetTableWidths(aWidths: array of Double);
begin
  fPDFReport.SetWidths(aWidths);
end;

procedure TDJPDFReport.SetTableAligns(aAligns: array of TTexBoxAlignment);
var
  i: Integer;
  vAlign: array of Char;
begin
  SetLength(vAlign, 0);
  SetLength(vAlign, Length(aAligns));
  For i := 0 to Length(aAligns)-1 do
  begin
    case aAligns[i] of
      baLeft   : vAlign[i] := 'L';
      baRight  : vAlign[i] := 'R';
      baCenter : vAlign[i] := 'C';
      baJustify: vAlign[i] := 'J';
    end;
  end;
  fPDFReport.SetAligns(vAlign);
end;

procedure TDJPDFReport.SetTableTitles(aTitles: array of String;
  aUseBorders: Boolean; aRepeatTitleOnNewPage: Boolean; aFill: Boolean);
begin
  fPDFReport.SetTitles(aTitles, aUseBorders, aRepeatTitleOnNewPage, aFill);
end;

procedure TDJPDFReport.DrawTableTitles;
begin
  fPDFReport.DrawTitles;
end;

procedure TDJPDFReport.TableRow(aData: array of String; aUseBorders: Boolean;
  aFill: Boolean);
begin
  fPDFReport.Row(aData, aUseBorders, aFill);
end;

function TDJPDFReport.ConvertTAlignmentToTTexBoxAlignment(Alignment: TAlignment
  ): TTexBoxAlignment;
begin
  case Alignment of
    taLeftJustify: Result := baLeft;
    taRightJustify: Result := baRight;
    taCenter: Result := baCenter;
  else
    Result := baJustify;
  end;
end;

end.

