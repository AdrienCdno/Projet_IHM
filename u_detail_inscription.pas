unit u_detail_inscription;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { Tf_detail_inscription }

  Tf_detail_inscription = class(TForm)
    btn_retour: TButton;
    btn_valider: TButton;
    btn_annuler: TButton;
    cbo_civilite: TComboBox;
    cbo_filiere: TComboBox;
    edt_mel: TEdit;
    edt_portable: TEdit;
    edt_telephone: TEdit;
    edt_adresse: TEdit;
    edt_cp: TEdit;
    edt_commune: TEdit;
    edt_prenom: TEdit;
    edt_nom: TEdit;
    edt_num: TEdit;
    lbl_moy_filiere: TLabel;
    lbl_moy_fil: TLabel;
    lbl_moy_etud: TLabel;
    lbl_moy_etu: TLabel;
    lbl_releve: TLabel;
    lbl_filiere_erreur: TLabel;
    lbl_filiere: TLabel;
    lbl_mel_erreur: TLabel;
    lbl_telephone_portable_erreur: TLabel;
    lbl_mel: TLabel;
    lbl_portable: TLabel;
    lbl_telephone: TLabel;
    lbl_contact: TLabel;
    lbl_commune_erreur: TLabel;
    lbl_cp_erreur: TLabel;
    lbl_adresse_erreur: TLabel;
    lbl_adresse: TLabel;
    lbl_prenom_erreur: TLabel;
    lbl_nom_erreur: TLabel;
    lbl_num_erreur: TLabel;
    lbl_prenom: TLabel;
    lbl_nom: TLabel;
    lbl_num: TLabel;
    lbl_ident: TLabel;
    mmo_lib: TMemo;
    pnl_releve_list: TPanel;
    pnl_releve_titre: TPanel;
    pnl_releve: TPanel;
    pnl_filiere: TPanel;
    pnl_contact: TPanel;
    pnl_adresse: TPanel;
    pnl_ident: TPanel;
    pnl_detail: TPanel;
    pnl_btn: TPanel;
    pnl_titre: TPanel;
    procedure btn_annulerClick(Sender: TObject);
    procedure btn_retourClick(Sender: TObject);
    procedure btn_validerClick(Sender: TObject);
    procedure cbo_filiereExit(Sender: TObject);
    procedure edt_adresseExit(Sender: TObject);
    procedure edt_communeExit(Sender: TObject);
    procedure edt_cpExit(Sender: TObject);
    procedure edt_melExit(Sender: TObject);
    procedure edt_nomExit(Sender: TObject);
    procedure edt_numEnter(Sender: TObject);
    procedure edt_numExit(Sender: TObject);
    procedure edt_portableExit(Sender: TObject);
    procedure edt_prenomExit(Sender: TObject);
    procedure edt_telephoneExit(Sender: TObject);
    procedure lbl_identClick(Sender: TObject);
    procedure lbl_moy_etudClick(Sender: TObject);
    procedure pnl_releve_listClick(Sender: TObject);
    procedure pnl_titreClick(Sender: TObject);
    procedure init ( idins : string; affi : boolean);
    procedure detail ( idins : string);
    procedure edit ( idins : string);
    procedure add;
    procedure delete ( idins : string);
    procedure edt_Enter (Sender : TObject );

  private
     procedure affi_page;
     procedure affi_filiere (num : string);
     function affi_erreur_saisie (erreur : string; lbl : TLabel; edt : TEdit) : boolean;
     function affi_erreur_saisie_cbo (erreur : string; lbl : TLabel; cbo : TComboBox) : boolean;
  public
    { public declarations }
  end;

var
  f_detail_inscription: Tf_detail_inscription;

implementation

{$R *.lfm}

uses u_feuille_style, u_list_inscription, u_releve_list, u_modele, u_loaddataset;

{ Tf_detail_inscription }

Var oldvaleur : string; // utilisée dans la modification pour comparer l’ancienne valeur avec la saisie
id : string; // variable active dans toute l'unité, contenant l'id infraction affichée
procedure Tf_detail_inscription.Init ( idins : string; affi : boolean);
// ajout nouvelle inscription : id est vide
// affichage détail d'une inscription : affi est vrai sinon affi est faux
begin
style.panel_travail (pnl_titre);
style.panel_travail (pnl_btn);
style.panel_travail (pnl_detail);

style.panel_travail (pnl_ident);
style.label_titre (lbl_ident);
style.label_erreur (lbl_num_erreur); lbl_num_erreur.caption := '' ;
style.label_erreur (lbl_nom_erreur); lbl_nom_erreur.caption := '' ;
style.label_erreur (lbl_prenom_erreur); lbl_prenom_erreur.caption := '' ;

style.panel_travail (pnl_adresse);
style.label_titre (lbl_adresse);
style.label_erreur (lbl_adresse_erreur); lbl_adresse_erreur.caption := '' ;
style.label_erreur (lbl_cp_erreur); lbl_cp_erreur.caption := '' ;
style.label_erreur (lbl_commune_erreur); lbl_commune_erreur.caption := '' ;

style.panel_travail (pnl_contact);
style.label_titre (lbl_contact);
style.label_erreur (lbl_telephone_portable_erreur); lbl_telephone_portable_erreur.caption := '' ;
style.label_erreur (lbl_mel_erreur); lbl_mel_erreur.caption := '' ;

style.panel_travail (pnl_filiere);
style.label_titre (lbl_filiere);
style.label_erreur (lbl_filiere_erreur); lbl_filiere_erreur.caption := '' ;

style.panel_travail (pnl_releve);
style.panel_travail (pnl_releve_titre);
style.label_titre (lbl_releve);
style.panel_travail (pnl_releve_list);
// initialisation identification
lbl_num_erreur.caption :='';
edt_num.clear;
edt_num.ReadOnly :=affi;
cbo_civilite.enabled := NOT affi;
edt_nom.clear;
edt_nom.ReadOnly :=affi;
edt_prenom.clear;
edt_prenom.ReadOnly :=affi;
// initialisation adresse
lbl_adresse_erreur.caption :='';
lbl_cp_erreur.caption :='';
lbl_commune_erreur.caption :='';
edt_adresse.clear;
edt_adresse.ReadOnly :=affi;
edt_cp.clear;
edt_cp.ReadOnly :=affi;
edt_commune.clear;
edt_commune.ReadOnly :=affi;
// initialisation contact
lbl_telephone_portable_erreur.caption :='';
lbl_mel_erreur.caption :='';
edt_telephone.clear;
edt_telephone.ReadOnly :=affi;
edt_portable.clear;
edt_portable.ReadOnly :=affi;
edt_mel.clear;
edt_mel.ReadOnly :=affi;
// initialisation filiere
lbl_filiere_erreur.caption :='';
mmo_lib.clear;
mmo_lib.ReadOnly := affi;
cbo_filiere.enabled := NOT affi;
//boutons
btn_retour.visible :=affi; // visible quand affichage filière
btn_valider.visible :=NOT affi; // visible quand ajout/modification inscription
btn_annuler.visible :=NOT affi; // visible quand ajout/modification inscription
// initialisation relevé
f_releve_list.borderstyle := bsNone;
 f_releve_list.parent := pnl_releve_list;
 f_releve_list.align := alClient;
 f_releve_list.init(affi);
 f_releve_list.show;
 f_releve_list.affi_data(modele.inscription_note(idins));
 //lbl_moy_etu.Visible := affi;


show;
id := idins;
IF NOT ( id = '') // affichage/modification inscription
THEN affi_page;
end;

procedure Tf_detail_inscription.affi_page;
var
 flux : TLoadDataSet;
begin
flux := modele.inscription_num(id);
 flux.read;
 edt_num.text := flux.Get('id');
 cbo_civilite.text := flux.Get('civ');
 edt_nom.text := flux.Get('nom');
 edt_prenom.text := flux.Get('prenom');
 edt_adresse.text := flux.Get('adresse');
 edt_cp.text := flux.Get('cp');
 edt_commune.text := flux.Get('ville');
 edt_telephone.text := flux.Get('telephone');
 edt_portable.text := flux.Get('portable');
 edt_mel.text := flux.Get('mel');
 cbo_filiere.text := flux.Get('code');
 lbl_releve.caption := 'Relevé de Notes - Moyenne étudiant : ' + modele.inscription_moy_etu(edt_num.text) + ' - Moyenne filière : ' + modele.inscription_moy_filiere(cbo_filiere.text);
 flux.destroy;

 affi_filiere (cbo_filiere.text);

end;


procedure Tf_detail_inscription.affi_filiere (num : string);
var
 ch : string;
begin
 mmo_lib.clear;
 if num = ''
 then mmo_lib.lines.add('Filière non identifiée.')
 else begin
    ch := modele.inscription_filiere(num);
    if ch ='' then mmo_lib.lines.add('Filière inconnue.')
    else mmo_lib.lines.text := ch;
 end;
end;

procedure Tf_detail_inscription.detail (idins : string);
begin
init (idins, true); // mode affichage
pnl_titre.caption := 'Détail d''une inscription';
cbo_civilite.Style := csSimple;
cbo_filiere.Style := csSimple;
btn_retour.setFocus;
end;
procedure Tf_detail_inscription.edit (idins : string);
begin
init (idins, false);
pnl_titre.caption := 'Modification d''une inscription';
edt_num.ReadOnly := true;
cbo_civilite.Style := csDropDown;
cbo_filiere.Style := csSimple;
mmo_lib.ReadOnly := true;
end;
procedure Tf_detail_inscription.add;
begin
init ('',false); // pas de numéro d'inscription
pnl_titre.caption := 'Nouvelle inscription';
edt_num.setFocus;
cbo_civilite.text := 'M';
cbo_civilite.Style := csDropDown;
cbo_filiere.Style := csDropDown;
cbo_filiere.text := '';
mmo_lib.ReadOnly := true;
lbl_releve.caption := 'Relevé de Notes';
end;
procedure Tf_detail_inscription.delete (idins : string);
begin
IF messagedlg ('Demande de confirmation'
,'Confirmez-vous la suppression de l''inscrit n°' +idins
,mtConfirmation, [mbYes,mbNo], 0, mbNo) = mrYes
THEN BEGIN
  modele.inscription_delete (idins);
f_list_inscription.line_delete;
END;
end;
function Tf_detail_inscription.affi_erreur_saisie (erreur : string; lbl : TLabel; edt : TEdit) : boolean;
begin
 lbl.caption := erreur;
 if NOT (erreur = '')
 then begin
 edt.setFocus;
 result := false;
 end
 else result := true;
end;
function Tf_detail_inscription.affi_erreur_saisie_cbo (erreur : string; lbl : TLabel; cbo : TComboBox) : boolean;
begin
 lbl.caption := erreur;
 if NOT (erreur = '')
 then begin
 cbo.setFocus;
 result := false;
 end
 else result := true;
end;


procedure Tf_detail_inscription.pnl_titreClick(Sender: TObject);
begin

end;

procedure Tf_detail_inscription.btn_retourClick(Sender: TObject);
begin
   close;
end;

procedure Tf_detail_inscription.btn_validerClick(Sender: TObject);
  var
 flux : TLoadDataSet;
 saisie, erreur, ch : string;
 i : integer;
 valide : boolean;
begin
 valide := true;
// test validité saisie dans l'ordre inverse de tabulation
// code filière obligatoire et existe
erreur := '';
if cbo_filiere.text = '' then erreur := 'Le code filière doit être rempli.'
else begin
ch := modele.inscription_filiere(cbo_filiere.text);
if ch = '' then erreur := 'Filière inexistante.';
end;
valide := affi_erreur_saisie_cbo (erreur, lbl_filiere_erreur, cbo_filiere) AND valide;
// mail  obligatoire
erreur := '';
if edt_mel.text = '' then erreur := 'L''adresse mail doit être remplie.';
valide := affi_erreur_saisie (erreur, lbl_mel_erreur, edt_mel) AND valide;
// telephone ou portable  obligatoire
erreur := '';
if ((edt_telephone.text = '') AND (edt_portable.text=''))then erreur := 'Le téléphone ou le portable doit être rempli.';
valide := affi_erreur_saisie (erreur, lbl_telephone_portable_erreur, edt_telephone) AND valide;
// ville  obligatoire
erreur := '';
if edt_commune.text = '' then erreur := 'La commune doit être remplie.';
valide := affi_erreur_saisie (erreur, lbl_commune_erreur, edt_commune) AND valide;
// code postal  obligatoire
erreur := '';
if edt_cp.text = '' then erreur := 'Le code postal doit être rempli.';
valide := affi_erreur_saisie (erreur, lbl_cp_erreur, edt_cp) AND valide;
// adresse  obligatoire
erreur := '';
if edt_adresse.text = '' then erreur := 'L''adresse doit être remplie.';
valide := affi_erreur_saisie (erreur, lbl_adresse_erreur, edt_adresse) AND valide;
// prenom  obligatoire
erreur := '';
if edt_prenom.text = '' then erreur := 'Le prénom doit être rempli.';
valide := affi_erreur_saisie (erreur, lbl_prenom_erreur, edt_prenom) AND valide;
// nom  obligatoire
erreur := '';
if edt_nom.text = '' then erreur := 'Le nom doit être rempli.';
valide := affi_erreur_saisie (erreur, lbl_nom_erreur, edt_nom) AND valide;








 // uniquement pour une nouvelle inscription numéro inscription correct ?
 if id = ''
 then begin
 erreur := '';
 saisie := edt_num.text;
 if saisie = '' then erreur := 'Le numéro doit être rempli.'
 else begin
 flux := modele.inscription_num(saisie);
 if NOT flux.endOf
 then erreur := 'Le numéro existe déjà';
 end;
 end;
 valide := affi_erreur_saisie (erreur, lbl_num_erreur, edt_num) AND valide;

 if NOT valide
 then messagedlg ('Erreur enregistrement Inscription'
 , 'La saisie est incorrecte.' +#13 +'Corrigez la saisie et validez à nouveau.'
 , mtWarning, [mbOk], 0)
 else begin
 // sauvegarde des données
 if id =''
 then modele.inscription_insert(edt_num.text, cbo_civilite.text, edt_nom.text, edt_prenom.text, edt_adresse.text, edt_cp.text, edt_commune.text, edt_portable.text, edt_telephone.text, edt_mel.text, cbo_filiere.text)
 else begin
 modele.inscription_update(id, cbo_civilite.text, edt_nom.text, edt_prenom.text, edt_adresse.text, edt_cp.text, edt_commune.text, edt_portable.text, edt_telephone.text, edt_mel.text);
 end;
 if id='' then
    begin
         f_list_inscription.line_add (modele.inscription_num(edt_num.text));
         f_list_inscription.affi_data(modele.inscription_liste_tous);
    end
 else begin
      f_list_inscription.line_edit(modele.inscription_num(id));
      f_list_inscription.affi_data(modele.inscription_liste_tous) ;
      end;
 close;
 end;
end;
procedure Tf_detail_inscription.cbo_filiereExit(Sender: TObject);
begin
  cbo_filiere.text := TRIM(cbo_filiere.text);
  IF NOT ( cbo_filiere.text = oldvaleur )
  THEN affi_filiere (cbo_filiere.text);
end;

procedure Tf_detail_inscription.edt_adresseExit(Sender: TObject);
begin
  edt_adresse.text := TRIM(edt_adresse.text);

end;

procedure Tf_detail_inscription.edt_communeExit(Sender: TObject);
begin
  edt_commune.text := TRIM(edt_commune.text);

end;

procedure Tf_detail_inscription.edt_cpExit(Sender: TObject);
begin
  edt_cp.text := TRIM(edt_cp.text);

end;

procedure Tf_detail_inscription.edt_melExit(Sender: TObject);
begin
  edt_mel.text := TRIM(edt_mel.text);

end;

procedure Tf_detail_inscription.edt_nomExit(Sender: TObject);
begin
  edt_nom.text := TRIM(edt_nom.text);

end;

procedure Tf_detail_inscription.edt_numEnter(Sender: TObject);
begin

end;

procedure Tf_detail_inscription.edt_numExit(Sender: TObject);
begin
  edt_num.text := TRIM(edt_num.text);
end;

procedure Tf_detail_inscription.edt_portableExit(Sender: TObject);
begin
  edt_portable.text := TRIM(edt_portable.text);

end;

procedure Tf_detail_inscription.edt_prenomExit(Sender: TObject);
begin
  edt_prenom.text := TRIM(edt_prenom.text);

end;

procedure Tf_detail_inscription.edt_telephoneExit(Sender: TObject);
begin
  edt_telephone.text := TRIM(edt_telephone.text);

end;

procedure Tf_detail_inscription.lbl_identClick(Sender: TObject);
begin

end;

procedure Tf_detail_inscription.lbl_moy_etudClick(Sender: TObject);
begin

end;

procedure Tf_detail_inscription.pnl_releve_listClick(Sender: TObject);
begin

end;

procedure Tf_detail_inscription.btn_annulerClick(Sender: TObject);
begin
  close;
end;
procedure Tf_detail_inscription.edt_Enter(Sender :
TObject);
begin
oldvaleur := TEdit(Sender).text;
end;


end.

