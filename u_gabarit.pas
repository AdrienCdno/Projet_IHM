unit u_gabarit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, StdCtrls;

type

  { Tf_gabarit }


  Tf_gabarit = class(TForm)
    item_accueil: TMenuItem;
    item_quitter: TMenuItem;
    item_filiere: TMenuItem;
    item_inscrit: TMenuItem;
    item_listefiliere: TMenuItem;
    item_stat: TMenuItem;
    item_listeinscrit: TMenuItem;
    item_archive: TMenuItem;
    item_archive1: TMenuItem;
    item_archive2: TMenuItem;
    lbl_accueil: TLabel;
    mnu_main: TMainMenu;
    pnl_selection: TPanel;
    pnl_travail: TPanel;
    pnl_info: TPanel;
    pnl_ariane: TPanel;
    procedure item_archive1Click(Sender: TObject);
    procedure item_archive2Click(Sender: TObject);
    procedure item_archiveClick(Sender: TObject);
    procedure item_listeinscritClick(Sender: TObject);
    procedure item_quitterClick(Sender: TObject);
    procedure item_statClick(Sender: TObject);
    procedure mnu_item_Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure item_accueilClick(Sender: TObject);
    procedure item_listefiliereClick(Sender: TObject);
    procedure pnl_travailClick(Sender: TObject);
    procedure choix_item_listeinscrit;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  f_gabarit: Tf_gabarit;

implementation

{$R *.lfm}

{ Tf_gabarit }
uses u_feuille_style, u_list_inscription, u_select_inscription, u_detail_inscription, u_modele ;

procedure Tf_gabarit.item_accueilClick(Sender: TObject);
begin

end;

procedure Tf_gabarit.item_listefiliereClick(Sender: TObject);
begin

end;

procedure Tf_gabarit.pnl_travailClick(Sender: TObject);
begin

end;

procedure Tf_gabarit.FormCreate(Sender: TObject);
begin

end;

procedure Tf_gabarit.FormShow(Sender: TObject);
begin
  style.panel_selection (pnl_ariane);
 style.panel_defaut (pnl_selection);
 style.panel_travail (pnl_travail);
 style.panel_defaut (pnl_info);
 f_gabarit.width := 1200;
 f_gabarit.height := 800;
 pnl_selection.caption := '';
 pnl_travail.caption := '';
 pnl_ariane.caption := ' >' + item_accueil.caption;
 lbl_accueil.Caption := 'Bienvenue'#13#10' dans l'#39'application de'#13#10' gestion de scolarité';
 lbl_accueil.Font.Color:= clBlue;
 lbl_accueil.Font.Height:=100;
// lbl_accueil.BevelWidth := 100;
 lbl_accueil.Font.Style:= [fsBold,fsItalic];
 lbl_accueil.Alignment:=taCenter;
 modele.open;
end;
 procedure Tf_gabarit.mnu_item_Click(Sender: TObject);
var
   item : TMenuItem;
begin
   pnl_selection.show;

   pnl_ariane.Caption := '';
   item := TmenuItem(Sender);
   repeat
         pnl_ariane.caption := ' >' + item.caption +pnl_ariane.Caption;
         item := item.parent;
   until item.parent = nil;
   item := TmenuItem(Sender);
   if item=item_listeinscrit then choix_item_listeinscrit
   else if (item = item_accueil) then
   begin
     f_select_inscription.hide;
     f_list_inscription.hide;
   end;
end;
 procedure Tf_gabarit.choix_item_listeinscrit;
begin
 f_list_inscription.borderstyle := bsNone;
 f_list_inscription.parent := pnl_travail;
 f_list_inscription.align := alClient;
 f_list_inscription.init;
 f_list_inscription.show ;
 f_select_inscription.borderstyle := bsNone;
 f_select_inscription.parent := pnl_selection;
 f_select_inscription.align := alClient;
 f_select_inscription.init;
 f_select_inscription.show;
end;

procedure Tf_gabarit.item_listeinscritClick(Sender: TObject);
begin

end;

procedure Tf_gabarit.item_quitterClick(Sender: TObject);
begin
  modele.close;
  close;
end;

procedure Tf_gabarit.item_statClick(Sender: TObject);
begin

end;

procedure Tf_gabarit.item_archiveClick(Sender: TObject);
begin

end;

procedure Tf_gabarit.item_archive1Click(Sender: TObject);
begin

end;

procedure Tf_gabarit.item_archive2Click(Sender: TObject);
begin

end;

end.

