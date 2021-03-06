program SGPB;

uses
  Forms,
  UPrincipalFrm in 'UPrincipalFrm.pas' {PrincipalFrm},
  UAcercaDeFrm in 'UAcercaDeFrm.pas' {AcercaDeFrm},
  UUsuario in 'UUsuario.pas',
  ULogonFrm in 'ULogonFrm.pas' {LogonFrm},
  USistema in 'USistema.pas',
  UObjectDB in 'UObjectDB.pas',
  UMotorSQL in 'UMotorSQL.pas',
  UUsuarioDB in 'UUsuarioDB.pas',
  UUsuarioFrm in 'UUsuarioFrm.pas' {UsuarioFrm},
  UModificacion in 'UModificacion.pas',
  UOperacion in 'UOperacion.pas',
  UAlta in 'UAlta.pas',
  UBaja in 'UBaja.pas',
  UDetalle in 'UDetalle.pas',
  UConsultaUsuariosFrm in 'UConsultaUsuariosFrm.pas' {ConsultaUsuariosFrm},
  UTareasPendientes in 'UTareasPendientes.pas' {TareasPendientesFrm},
  UPlanoDB in 'UPlanoDB.pas',
  UPlano in 'UPlano.pas',
  UPlanoAltaFrm in 'UPlanoAltaFrm.pas' {PlanoAltaFrm},
  UPlanoAprobarFrm in 'UPlanoAprobarFrm.pas' {PlanoAprobarFrm},
  UAprobar in 'UAprobar.pas',
  URecibir in 'URecibir.pas',
  UPlanoSuperarFrm in 'UPlanoSuperarFrm.pas' {PlanoSuperarFrm},
  UConsultasFrm in 'UConsultasFrm.pas' {ConsultasFrm},
  UPurgarPlanosFrm in 'UPurgarPlanosFrm.pas' {PurgarPlanosFrm},
  UPlanoBajaFrm in 'UPlanoBajaFrm.pas' {PlanoBajaFrm},
  URecuperar in 'URecuperar.pas',
  UPantallaFrm in 'UPantallaFrm.pas',
  UUtiles in 'UUtiles.pas',
  UPermisos in 'UPermisos.pas',
  UPermisosDB in 'UPermisosDB.pas',
  UPassFrm in 'UPassFrm.pas' {PassFrm},
  URestablecerPass in 'URestablecerPass.pas',
  UCambiarPass in 'UCambiarPass.pas',
  UMaterialesAltaForm in 'UMaterialesAltaForm.pas' {FormAltaMateriales},
  UMaterialesAltaFrm in 'UMaterialesAltaFrm.pas' {MaterialesAltaFrm},
  UMaterialesBajaFrm in 'UMaterialesBajaFrm.pas' {MaterialesBajaFrm},
  UMaterialesModificarFrm in 'UMaterialesModificarFrm.pas' {ListaMaterialesModificarFrm},
  UMateriales in 'UMateriales.pas',
  UManuales in 'UManuales.pas',
  UMaterialesAprobarFrm in 'UMaterialesAprobarFrm.pas' {MaterialesAprobarFrm},
  URecibirMaterialesFrm in 'URecibirMaterialesFrm.pas' {RecibirMaterialesFrm},
  UMaterialesSuperarFrm in 'UMaterialesSuperarFrm.pas' {MaterialesSuperarFrm},
  UManualesAltaFrm in 'UManualesAltaFrm.pas' {ManualesAltaFrm},
  UManualesBajaFrm in 'UManualesBajaFrm.pas' {ManualesBajaFrm},
  UManualModificarFrm in 'UManualModificarFrm.pas' {ManualModificarFrm},
  UManualAprobarFrm in 'UManualAprobarFrm.pas' {ManualAprobarFrm},
  UManualSuperarFrm in 'UManualSuperarFrm.pas' {ManualSuperarFrm},
  UDVarios in 'UDVarios.pas',
  UInstructivosProdAltaFrm in 'UInstructivosProdAltaFrm.pas' {InstructivosMaterialesAltaFrm},
  UInstructivosProdModificarFrm in 'UInstructivosProdModificarFrm.pas' {InstructivosProduccionModificarFrm},
  UInstructivosProdBaja in 'UInstructivosProdBaja.pas' {InstructivosProdBajaFrm},
  UInstructivosProdAprobarFrm in 'UInstructivosProdAprobarFrm.pas' {InstructivosProdAprobarFrm},
  UInstructivosProdRecibirFrm in 'UInstructivosProdRecibirFrm.pas' {RecibirInstructivosProdFrm},
  UInstructivosProdSuperarFrm in 'UInstructivosProdSuperarFrm.pas' {SuperarInstructivosProdFrm},
  USubinstructivosProdAltaFrm in 'USubinstructivosProdAltaFrm.pas' {SubinstructivosProdAltaFrm},
  USubinstructivosBajaFrm in 'USubinstructivosBajaFrm.pas' {SubinstructivosProdBajaFrm},
  USubinstructivosProdModificarFrm in 'USubinstructivosProdModificarFrm.pas' {ModificarSubinstructivosFrm},
  USubinstructivosProdAprobarFrm in 'USubinstructivosProdAprobarFrm.pas' {SubinstructivosProdAprobarFrm},
  USubinstructivosProdRecibirFrm in 'USubinstructivosProdRecibirFrm.pas' {RecibirSubinstructivosProdFrm},
  USubinstructivosProdSuperarFrm in 'USubinstructivosProdSuperarFrm.pas' {SubinstructivosProdSuperarFrm},
  UInstructivos_SubinstructivosAltaFrm in 'UInstructivos_SubinstructivosAltaFrm.pas' {Instructivos_SubinstructivosAltaFrm},
  UInstructivos_SubinstructivosBajaFrm in 'UInstructivos_SubinstructivosBajaFrm.pas' {Instructivos_Subinstructivos_EnsayosBajaFrm},
  UInstructivos_SubinstructivosModificarFrm in 'UInstructivos_SubinstructivosModificarFrm.pas' {Instructivos_SubinstructivosModificarFrm},
  UInstructivos_SubinstructivosAprobarFrm in 'UInstructivos_SubinstructivosAprobarFrm.pas' {Instructivos_SubinstructivosAprobarFrm},
  UInstructivos_SubinstructivosRecibirFrm in 'UInstructivos_SubinstructivosRecibirFrm.pas' {Instructivos_SubinstructivosRecibirFrm},
  UInstructivos_SubinstructivosSuperarFrm in 'UInstructivos_SubinstructivosSuperarFrm.pas' {Instructivos_SubinstructivosSuperarFrm},
  UDocumentosClientesAltaFrm in 'UDocumentosClientesAltaFrm.pas' {DocumentosClientesAltaFrm},
  UDocumentosClientesBajaFrm in 'UDocumentosClientesBajaFrm.pas' {DocumentosClientesBajaFrm},
  UDocumentosClientesModificarFrm in 'UDocumentosClientesModificarFrm.pas' {DocumentosClientesModificarFrm},
  UDocumentosClientesRecibirFrm in 'UDocumentosClientesRecibirFrm.pas' {RecibirDocumentosClientesFrm},
  UDocumentosClientesSuperarFrm in 'UDocumentosClientesSuperarFrm.pas' {SuperarDocumentosClientesFrm},
  UEspecificacionesTecnicasAltaFrm in 'UEspecificacionesTecnicasAltaFrm.pas' {EspecificacionesTecnicasAltaFrm},
  UEspecificacionesTecnicasBajaFrm in 'UEspecificacionesTecnicasBajaFrm.pas' {EspecificacionesTecnicasBajaFrm},
  UEspecificacionesTecnicasModificarFrm in 'UEspecificacionesTecnicasModificarFrm.pas' {EspecificacionesTecnicasModificarFrm},
  UEspecificacionesTecnicasAprobarFrm in 'UEspecificacionesTecnicasAprobarFrm.pas' {EspecificacionesTecnicasAprobarFrm},
  UEspecificacionesTecnicasRecibirFrm in 'UEspecificacionesTecnicasRecibirFrm.pas' {EspecificacionesTecnicasRecibirFrm},
  UEspecificacionesTecnicasSuperarFrm in 'UEspecificacionesTecnicasSuperarFrm.pas' {SuperarEspecificacionesTecnicasFrm},
  UManual in 'UManual.pas',
  UManualDB in 'UManualDB.pas',
  USubinstructivo in 'USubinstructivo.pas',
  USubinstructivoDB in 'USubinstructivoDB.pas',
  ULista in 'ULista.pas',
  UListaDB in 'UListaDB.pas',
  SortIcon in 'SortIcon.pas',
  UListaAprobarFrm in 'UListaAprobarFrm.pas' {ListaAprobarFrm},
  UInstructivo in 'UInstructivo.pas',
  UInstructivoDB in 'UInstructivoDB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title:= 'Sistema de Gesti�n de Planos BOHERDI ELECTRONICA';
  Application.CreateForm(TLogonFrm, LogonFrm);
  Application.CreateForm(TPrincipalFrm, PrincipalFrm);
  Application.CreateForm(TUsuarioFrm, UsuarioFrm);
  Application.CreateForm(TAcercaDeFrm, AcercaDeFrm);
  Application.CreateForm(TConsultaUsuariosFrm, ConsultaUsuariosFrm);
  Application.CreateForm(TTareasPendientesFrm, TareasPendientesFrm);
  Application.CreateForm(TPlanoAltaFrm, PlanoAltaFrm);
  Application.CreateForm(TPlanoAprobarFrm, PlanoAprobarFrm);
  Application.CreateForm(TPlanoSuperarFrm, PlanoSuperarFrm);
  Application.CreateForm(TConsultasFrm, ConsultasFrm);
  Application.CreateForm(TPurgarPlanosFrm, PurgarPlanosFrm);
  Application.CreateForm(TPlanoBajaFrm, PlanoBajaFrm);
  Application.CreateForm(TPassFrm, PassFrm);
  Application.CreateForm(TFormAltaMateriales, FormAltaMateriales);
  Application.CreateForm(TMaterialesAltaFrm, MaterialesAltaFrm);
  Application.CreateForm(TMaterialesBajaFrm, MaterialesBajaFrm);
  Application.CreateForm(TListaMaterialesModificarFrm, ListaMaterialesModificarFrm);
  Application.CreateForm(TListaAprobarFrm, ListaAprobarFrm);
  // Application.CreateForm(TPlanoModificarFrm, PlanoModificarFrm);
  Application.CreateForm(TMaterialesAprobarFrm, MaterialesAprobarFrm);
  Application.CreateForm(TRecibirMaterialesFrm, RecibirMaterialesFrm);
  Application.CreateForm(TMaterialesSuperarFrm, MaterialesSuperarFrm);
  Application.CreateForm(TManualesAltaFrm, ManualesAltaFrm);
  Application.CreateForm(TManualesBajaFrm, ManualesBajaFrm);
  Application.CreateForm(TManualModificarFrm, ManualModificarFrm);
  Application.CreateForm(TManualAprobarFrm, ManualAprobarFrm);
 // Application.CreateForm(TManualRecibirFrm, ManualRecibirFrm);
  Application.CreateForm(TManualSuperarFrm, ManualSuperarFrm);
  Application.CreateForm(TInstructivosMaterialesAltaFrm, InstructivosMaterialesAltaFrm);
  Application.CreateForm(TInstructivosProduccionModificarFrm, InstructivosProduccionModificarFrm);
  Application.CreateForm(TInstructivosProdBajaFrm, InstructivosProdBajaFrm);
  Application.CreateForm(TInstructivosProdAprobarFrm, InstructivosProdAprobarFrm);
  Application.CreateForm(TRecibirInstructivosProdFrm, RecibirInstructivosProdFrm);
  Application.CreateForm(TSuperarInstructivosProdFrm, SuperarInstructivosProdFrm);
  Application.CreateForm(TSubinstructivosProdAltaFrm, SubinstructivosProdAltaFrm);
  Application.CreateForm(TSubinstructivosProdBajaFrm, SubinstructivosProdBajaFrm);
  Application.CreateForm(TModificarSubinstructivosFrm, ModificarSubinstructivosFrm);
  Application.CreateForm(TSubinstructivosProdAprobarFrm, SubinstructivosProdAprobarFrm);
  Application.CreateForm(TRecibirSubinstructivosProdFrm, RecibirSubinstructivosProdFrm);
  Application.CreateForm(TSubinstructivosProdSuperarFrm, SubinstructivosProdSuperarFrm);
  Application.CreateForm(TInstructivos_SubinstructivosAltaFrm, Instructivos_SubinstructivosAltaFrm);
  Application.CreateForm(TInstructivos_Subinstructivos_EnsayosBajaFrm, Instructivos_Subinstructivos_EnsayosBajaFrm);
  Application.CreateForm(TInstructivos_SubinstructivosModificarFrm, Instructivos_SubinstructivosModificarFrm);
  Application.CreateForm(TInstructivos_SubinstructivosAprobarFrm, Instructivos_SubinstructivosAprobarFrm);
  Application.CreateForm(TInstructivos_SubinstructivosRecibirFrm, Instructivos_SubinstructivosRecibirFrm);
  Application.CreateForm(TInstructivos_SubinstructivosSuperarFrm, Instructivos_SubinstructivosSuperarFrm);
  Application.CreateForm(TDocumentosClientesAltaFrm, DocumentosClientesAltaFrm);
  Application.CreateForm(TDocumentosClientesBajaFrm, DocumentosClientesBajaFrm);
  Application.CreateForm(TDocumentosClientesModificarFrm, DocumentosClientesModificarFrm);
  Application.CreateForm(TRecibirDocumentosClientesFrm, RecibirDocumentosClientesFrm);
  Application.CreateForm(TSuperarDocumentosClientesFrm, SuperarDocumentosClientesFrm);
  Application.CreateForm(TEspecificacionesTecnicasAltaFrm, EspecificacionesTecnicasAltaFrm);
  Application.CreateForm(TEspecificacionesTecnicasBajaFrm, EspecificacionesTecnicasBajaFrm);
  Application.CreateForm(TEspecificacionesTecnicasModificarFrm, EspecificacionesTecnicasModificarFrm);
  Application.CreateForm(TEspecificacionesTecnicasAprobarFrm, EspecificacionesTecnicasAprobarFrm);
  Application.CreateForm(TEspecificacionesTecnicasRecibirFrm, EspecificacionesTecnicasRecibirFrm);
  Application.CreateForm(TSuperarEspecificacionesTecnicasFrm, SuperarEspecificacionesTecnicasFrm);
  //  Application.CreateForm(TBuscarLMFrm, BuscarLMFrm);
  Application.Run;

end.
