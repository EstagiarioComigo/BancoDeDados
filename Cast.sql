SELECT *, CAST(ordemdeservicoagendamentos."Agendamentos"."FimDoServico" AS TIMESTAMP(0)), CAST(ordemdeservicoagendamentos."Agendamentos"."InicioDoServico" AS TIMESTAMP(0)), CAST(ordemdeservicoagendamentos."Agendamentos"."created_at" AS TIMESTAMP(0)), CAST(ordemdeservicoagendamentos."Agendamentos"."updated_at" AS TIMESTAMP(0)), CAST(ordemdeservicoagendamentos."Agendamentos"."deleted_at" AS TIMESTAMP(0)),
CAST(ordemdeservico."OrdemDeServico"."created_at" AS TIMESTAMP(0)),
CAST(ordemdeservico."OrdemDeServico"."updated_at" AS TIMESTAMP(0)),
CAST(ordemdeservico."OrdemDeServico"."deleted_at" AS TIMESTAMP(0))
         FROM ordemdeservicoagendamentos."Agendamentos"
    LEFT JOIN ordemdeservico."Atividades"
 ON ordemdeservicoagendamentos."Agendamentos"."OS_Id" = ordemdeservico."Atividades"."OrdemDeServico_Id"
    LEFT JOIN ordemdeservico."OrdemDeServico"
 ON ordemdeservicoagendamentos."Agendamentos"."OS_Id" = ordemdeservico."OrdemDeServico"."Id";