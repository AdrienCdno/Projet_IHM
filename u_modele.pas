unit u_modele;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, u_loaddataset;

type
Tmodele = class(TMySQL)
 private
 { private declarations }
 public
 { public declarations }
 procedure open;
 function inscription_liste_tous : TLoadDataSet;
 function inscription_liste_etudiant (id, nom : string) : TLoadDataSet;
 function inscription_liste_filiere (code : string) : TLoadDataSet;
 function inscription_num (num : string) : TLoadDataSet;
 function inscription_civ (num : string) : string;
 function inscription_nom (num : string) : string;
 function inscription_prenom (num : string) : string;
 function inscription_adresse (num : string) : string;
 function inscription_cp (num : string) : string;
 function inscription_ville (num : string) : string;
 function inscription_telephone (num : string) : string;
 function inscription_portable (num : string) : string;
 function inscription_mel (num : string) : string;
 function inscription_code (num : string) : string;
 function inscription_filiere (num : string) : string;
 function inscription_note (num : string) : TLoadDataSet;
 function inscription_moy_etu (num :string) : string;
 function inscription_moy_filiere (num :string) : string;
 procedure inscription_delete (id : string);
 procedure inscription_insert (id, civ, nom, prenom, adresse, cp, ville, telephone, portable, mel, code : string);
 procedure inscription_update (id, civ, nom, prenom, adresse, cp, ville, telephone, portable, mel : string);
 function inscription_filiere_code : TLoadDataSet;
 procedure close;
end;

var
 modele: Tmodele;

implementation

procedure Tmodele.open;
begin
 Bd_open ('devbdd.iutmetz.univ-lorraine.fr', 0, 'celindan3u_bdprojetihm', 'celindan3u_appli',
 '31902871', 'mysqld-5', 'libmysql64.dll');
end;

procedure Tmodele.close;
begin
 Bd_close;
end;

// toutes les inscription
function Tmodele.inscription_liste_tous : TLoadDataSet;
begin
 result := load('sp_inscription_liste_tous',[]);
end;
function Tmodele.inscription_filiere_code : TLoadDataSet;
begin
 result := load('sp_etudiant_code',[]);
end;

// inscription
function Tmodele.inscription_liste_etudiant (id, nom : string) : TLoadDataSet;
begin
 result := load('sp_inscription_liste_etu',[id, nom]);
end;

// inscriptions
function Tmodele.inscription_liste_filiere (code : string) : TLoadDataSet;
begin
 result := load('sp_inscription_liste_filiere',[code]);
end;
function Tmodele.inscription_num (num : string) : TLoadDataSet;
begin
 result := load('sp_etudiant_num',[num]);
end;
function Tmodele.inscription_civ (num : string) : string;
begin
 load('sp_etudiant_num',[num], result);
end;

function Tmodele.inscription_nom (num : string) : string;
begin
 load('sp_etudiant_num',[num], result);
end;

function Tmodele.inscription_prenom (num : string) : string;
begin
 load('sp_etudiant_num',[num], result);
end;
function Tmodele.inscription_adresse (num : string) : string;
begin
 load('sp_etudiant_num',[num], result);
end;
function Tmodele.inscription_cp (num : string) : string;
begin
 load('sp_etudiant_num',[num], result);
end;
function Tmodele.inscription_ville (num : string) : string;
begin
 load('sp_etudiant_num',[num], result);
end;
function Tmodele.inscription_telephone (num : string) : string;
begin
 load('sp_etudiant_num',[num], result);
end;
function Tmodele.inscription_portable (num : string) : string;
begin
 load('sp_etudiant_num',[num], result);
end;
function Tmodele.inscription_mel (num : string) : string;
begin
 load('sp_etudiant_num',[num], result);
end;
function Tmodele.inscription_code (num : string) : string;
begin
 load('sp_etudiant_num',[num], result);
end;
function Tmodele.inscription_filiere (num : string) : string;
begin
 load('sp_lib_filiere',[num], result);
end;
function Tmodele.inscription_note (num : string) : TLoadDataSet;
begin
 result := load('sp_releve_note',[num]);
end;
function Tmodele.inscription_moy_etu (num : string) : string;
begin
 load('sp_moy_inscrit',[num], result);
end;
function Tmodele.inscription_moy_filiere (num : string) : string;
begin
 load('sp_moy_filiere',[num], result);
end;
procedure Tmodele.inscription_delete (id : string);
begin
 exec('sp_inscription_delete',[id]);
end;

procedure Tmodele.inscription_insert (id, civ, nom, prenom, adresse, cp, ville, telephone, portable, mel, code : string);
begin
 exec('sp_inscription_insert',[id, civ, nom, prenom, adresse, cp, ville, telephone, portable, mel, code]);
end;

procedure Tmodele.inscription_update (id, civ, nom, prenom, adresse, cp, ville, telephone, portable, mel : string);
begin
 exec('sp_inscription_update',[id], [civ, nom, prenom, adresse, cp, ville, telephone, portable, mel]);
end;






begin
 modele := TModele.Create;
end.



implementation

end.

