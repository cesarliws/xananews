unit PropertyPageGeneralForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PropertyPageForm, ExtCtrls, StdCtrls;

type
  TPropertyPageGeneralData = class(TPropertyPageData)
  private
    fShowInSystemTray: Boolean;
    fShowTooltips: Boolean;
    fCheckVersionOnInternet: Integer;
    fHideDormantConnections: Boolean;
    fAutoCrossPostDetect: Boolean;
    fQuoteFullText: Boolean;
    fSearchInternetURLStub: string;
    fPlainTextPasswords: Boolean;
    fTextInternetURLStub: string;
    fUseVistaExplorerTheme: Boolean;
  protected
    procedure Initialize; override;
  public
    function Apply: Boolean; override;
  end;

  TfmPropertyPageGeneral = class(TfmPropertyPage)
    cbShowInSystemTray: TCheckBox;
    cbShowTooltips: TCheckBox;
    Label1: TLabel;
    rbVersionAsk: TRadioButton;
    rbVersionDont: TRadioButton;
    rbVersionAlways: TRadioButton;
    cbHideDormantConnections: TCheckBox;
    cbAutoCrossPostDetect: TCheckBox;
    cbQuoteFullText: TCheckBox;
    Label2: TLabel;
    edSearchInternetURLStub: TEdit;
    Label3: TLabel;
    cbPlainTextPasswords: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    edTextInternetURLStub: TEdit;
    cbUseVistaExplorerTheme: TCheckBox;
    procedure edTextInternetURLStubChange(Sender: TObject);
    procedure edSearchInternetURLStubChange(Sender: TObject);
    procedure ControlClick(Sender: TObject);
  private
    fData: TPropertyPageGeneralData;
  public
    class function GetDataClass: TPropertyPageDataClass; override;
    procedure PopulateControls(AData: TPropertyPageData); override;
  end;

var
  fmPropertyPageGeneral: TfmPropertyPageGeneral;

implementation

uses unitNNTPServices, unitNewsReaderOptions;

{$R *.dfm}

{ TfmPropertyPageGeneral }

class function TfmPropertyPageGeneral.GetDataClass: TPropertyPageDataClass;
begin
  Result := TPropertyPageGeneralData
end;

procedure TfmPropertyPageGeneral.PopulateControls(AData: TPropertyPageData);
begin
  inherited;

  fData := AData as TPropertyPageGeneralData;

  cbShowInSystemTray.Checked := fData.fShowInSystemTray;
  cbShowTooltips.Checked := fData.fShowTooltips;
  cbHideDormantConnections.Checked := fData.fHideDormantConnections;
  cbAutoCrossPostDetect.Checked := fData.fAutoCrossPostDetect;
  cbQuoteFullText.Checked := fData.fQuoteFullText;
  edSearchInternetURLStub.Text := fData.fSearchInternetURLStub;
  edTextInternetURLStub.Text := fData.fTextInternetURLStub;
  cbPlainTextPasswords.Checked := fData.fPlainTextPasswords;
  cbUseVistaExplorerTheme.Checked := fData.fUseVistaExplorerTheme;

  case fData.fCheckVersionOnInternet of
    1: rbVersionDont.Checked := True;
    2: rbVersionAlways.Checked := True;
  else
    rbVersionAsk.Checked := True
  end
end;

{ TPropertyPageGeneralData }

function TPropertyPageGeneralData.Apply: Boolean;
begin
  Result := True;
  XNOptions.ShowInSystemTray := fShowInSystemTray;
  XNOptions.ShowTooltips := fShowTooltips;
  NNTPAccounts.DoVersionCheck := fCheckVersionOnInternet;
  NNTPAccounts.HideDormantConnections := fHideDormantConnections;
  XNOptions.AutoCrosspostDetect := fAutoCrossPostDetect;
  XNOptions.QuoteSelectedText := fQuoteFullText;
  XNOptions.SearchInternetURLStub := fSearchInternetURLStub;
  XNOptions.TextInternetURLStub := fTextInternetURLStub;
  XNOptions.PlainTextPasswords := fPlainTextPasswords;
  XNOptions.UseVistaExplorerTheme := fUseVistaExplorerTheme;
end;

procedure TPropertyPageGeneralData.Initialize;
begin
  fShowInSystemTray := XNOptions.ShowInSystemTray;
  fShowTooltips := XNOptions.ShowTooltips;
  fCheckVersionOnInternet := NNTPAccounts.DoVersionCheck;
  fHideDormantConnections := NNTPAccounts.HideDormantConnections;
  fAutoCrossPostDetect := XNOptions.AutoCrosspostDetect;
  fQuoteFullText := XNOptions.QuoteSelectedText;
  fSearchInternetURLStub := XNOptions.SearchInternetURLStub;
  fTextInternetURLStub := XNOptions.TextInternetURLStub;
  fPlainTextPasswords := XNOptions.PlainTextPasswords;
  fUseVistaExplorerTheme := XNOptions.UseVistaExplorerTheme;
end;

procedure TfmPropertyPageGeneral.ControlClick(Sender: TObject);
begin
  if Populating then Exit;
  fData.fShowInSystemTray := cbShowInSystemTray.Checked;
  fData.fShowTooltips := cbShowTooltips.Checked;
  fData.fPlainTextPasswords := cbPlainTextPasswords.Checked;

  if rbVersionAlways.Checked then
    fData.fCheckVersionOnInternet := 2
  else
    if rbVersionDont.Checked then
      fData.fCheckVersionOnInternet := 1
    else
      fData.fCheckVersionOnInternet := 0;

  fData.fHideDormantConnections := cbHideDormantConnections.Checked;
  fData.fAutoCrossPostDetect := cbAutoCrosspostDetect.Checked;
  fData.fQuoteFullText := cbQuoteFullText.Checked;
  fData.fUseVistaExplorerTheme := cbUseVistaExplorerTheme.Checked;
end;

procedure TfmPropertyPageGeneral.edSearchInternetURLStubChange(Sender: TObject);
begin
  if Populating then Exit;
  fData.fSearchInternetURLStub := edSearchInternetURLStub.Text
end;

procedure TfmPropertyPageGeneral.edTextInternetURLStubChange(Sender: TObject);
begin
  if Populating then Exit;
  fData.fTextInternetURLStub := edTextInternetURLStub.Text
end;

end.
