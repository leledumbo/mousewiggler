unit formmain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Spin, Menus, ActnList, LCLType, IniPropStorage;

type

  { TMainForm }

  TMainForm = class(TForm)
    MainTrayIcon: TTrayIcon;
    TrayPopupMenu: TPopupMenu;
    MIExit: TMenuItem;
    MainActionList: TActionList;
    ActionAppExit: TAction;
    WiggleTimer: TTimer;
    PanelWiggleOption: TPanel;
    LabelWiggleEvery: TLabel;
    SpinEditWiggleInterval: TSpinEdit;
    LabelSeconds: TLabel;
    PanelWiggleStatus: TPanel;
    PanelWiggleControl: TPanel;
    ButtonToggleWiggle: TButton;
    LabelStatus: TLabel;
    LabelActiveInactive: TLabel;
    ButtonExit: TButton;
    MainPropStorage: TIniPropStorage;
    procedure ActionAppExitExecute(Sender: TObject);
    procedure ButtonToggleWiggleClick(Sender: TObject);
    procedure WiggleTimerTimer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure MainTrayIconClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

uses
  LCLIntf,MouseAndKeyInput;

resourcestring
  rsApply = '&Apply';
  rsInactive = 'Inactive';
  rsStop = '&Stop';
  rsActive = 'Active';
  rsMouseWiggler = 'Mouse Wiggler' + LineEnding + '- Click to toggle main form visibility'
    + LineEnding + '- ' + 'Right click for menu';
  rsClickToToggl = '- Click to toggle main form visibility' + LineEnding + '- Right click for '
    + 'menu';

var
  cs: TCriticalSection;
  CloseAllowed: Boolean;

{ TMainForm }

procedure TMainForm.ActionAppExitExecute(Sender: TObject);
begin
  CloseAllowed := true;
  Close;
end;

procedure TMainForm.ButtonToggleWiggleClick(Sender: TObject);
begin
  if WiggleTimer.Enabled then begin
    WiggleTimer.Enabled := false;
    ButtonToggleWiggle.Caption := rsApply;
    LabelActiveInactive.Font.Color := clBlack;
    LabelActiveInactive.Caption := rsInactive;
  end else begin
    WiggleTimer.Interval := SpinEditWiggleInterval.Value * 1000;
    WiggleTimer.Enabled := true;
    ButtonToggleWiggle.Caption := rsStop;
    LabelActiveInactive.Font.Color := clBlue;
    LabelActiveInactive.Caption := rsActive;
  end;
end;

procedure TMainForm.WiggleTimerTimer(Sender: TObject);
var
  P: TPoint;
begin
  EnterCriticalSection(cs);
  try
    if GetCursorPos(P) then begin
      MouseInput.Move([],P.x,P.y + 5);
      Application.ProcessMessages;
      MouseInput.Move([],P.x,P.y);
    end;
  finally
    LeaveCriticalSection(cs);
  end;
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin
  WiggleTimer.Enabled := false;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := CloseAllowed;
  if not CanClose then begin
    Hide;
    MainTrayIcon.ShowBalloonHint;
  end;
end;

procedure TMainForm.MainTrayIconClick(Sender: TObject);
begin
  if not Visible then begin
    Show;
    CloseAllowed := false;
  end else begin
    Hide;
    MainTrayIcon.ShowBalloonHint;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  MainTrayIcon.Hint := rsMouseWiggler;
  MainTrayIcon.BalloonHint := rsClickToToggl;
  CloseAllowed := false;
end;

initialization
  InitializeCriticalSection(cs);

finalization
  DeleteCriticalSection(cs);

end.

