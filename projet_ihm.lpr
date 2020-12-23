program projet_ihm;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, u_gabarit, u_feuille_style, u_select_inscription, u_list_inscription,
  zcomponent, u_detail_inscription, u_releve_list, u_modele
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tf_gabarit, f_gabarit);
  Application.CreateForm(Tf_select_inscription, f_select_inscription);
  Application.CreateForm(Tf_list_inscription, f_list_inscription);
  Application.CreateForm(Tf_detail_inscription, f_detail_inscription);
  Application.CreateForm(Tf_releve_list, f_releve_list);
  Application.Run;
end.

