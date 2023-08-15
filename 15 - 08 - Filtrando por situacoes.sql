
SELECT COUNT(DISTINCT OS."Id") AS CountDistinctRecords
FROM erprastreamento.ordemdeservico."OrdemDeServico" AS OS
LEFT JOIN erprastreamento.ordemdeservicoagendamentos."Agendamentos" AS Agendamento
         ON OS."Id" = Agendamento."OS_Id"
WHERE OS."Situacao_Id" = 'agendada'
and OS.deleted_at is null;

SELECT COUNT(DISTINCT OS."Id") AS CountDistinctRecords
FROM erprastreamento.ordemdeservico."OrdemDeServico" AS OS
LEFT JOIN erprastreamento.ordemdeservicoagendamentos."Agendamentos" AS Agendamento
         ON OS."Id" = Agendamento."OS_Id"
WHERE OS."Situacao_Id" = 'cancelada'
and OS.deleted_at is null;

SELECT COUNT(DISTINCT OS."Id") AS CountDistinctRecords
FROM erprastreamento.ordemdeservico."OrdemDeServico" AS OS
LEFT JOIN erprastreamento.ordemdeservicoagendamentos."Agendamentos" AS Agendamento
         ON OS."Id" = Agendamento."OS_Id"
WHERE OS."Situacao_Id" = 'finalizada'
and OS.deleted_at is null;

SELECT COUNT(DISTINCT OS."Id") AS CountDistinctRecords
FROM erprastreamento.ordemdeservico."OrdemDeServico" AS OS
LEFT JOIN erprastreamento.ordemdeservicoagendamentos."Agendamentos" AS Agendamento
         ON OS."Id" = Agendamento."OS_Id"
WHERE OS."Situacao_Id" = 'frustada'
and OS.deleted_at is null;

SELECT COUNT(DISTINCT OS."Id") AS CountDistinctRecords
FROM erprastreamento.ordemdeservico."OrdemDeServico" AS OS
LEFT JOIN erprastreamento.ordemdeservicoagendamentos."Agendamentos" AS Agendamento
         ON OS."Id" = Agendamento."OS_Id"
WHERE OS."Situacao_Id" = 'aberta'
and OS.deleted_at is null;

-- Com Tabela de Agendamentos

SELECT COUNT(DISTINCT Agendamento."Id") AS CountDistinctRecords
FROM erprastreamento.ordemdeservicoagendamentos."Agendamentos" AS Agendamento
LEFT JOIN erprastreamento.ordemdeservico."OrdemDeServico" AS OS
         ON OS."Id" = Agendamento."OS_Id"
WHERE Agendamento.deleted_at is null;

SELECT COUNT(DISTINCT Agendamento."Id") AS CountDistinctRecords
FROM erprastreamento.ordemdeservicoagendamentos."Agendamentos" AS Agendamento
LEFT JOIN erprastreamento.ordemdeservico."OrdemDeServico" AS OS
         ON OS."Id" = Agendamento."OS_Id"
WHERE Agendamento."Situacao_Id" = 'criada'
and Agendamento.deleted_at is null;

SELECT COUNT(DISTINCT Agendamento."Id") AS CountDistinctRecords
FROM erprastreamento.ordemdeservicoagendamentos."Agendamentos" AS Agendamento
LEFT JOIN erprastreamento.ordemdeservico."OrdemDeServico" AS OS
         ON OS."Id" = Agendamento."OS_Id"
WHERE Agendamento."Situacao_Id" = 'iniciada'
and Agendamento.deleted_at is null;

SELECT COUNT(DISTINCT Agendamento."Id") AS CountDistinctRecords
FROM erprastreamento.ordemdeservicoagendamentos."Agendamentos" AS Agendamento
LEFT JOIN erprastreamento.ordemdeservico."OrdemDeServico" AS OS
         ON OS."Id" = Agendamento."OS_Id"
WHERE Agendamento."Situacao_Id" = 'frustada'
and Agendamento.deleted_at is null;

SELECT COUNT(DISTINCT Agendamento."Id") AS CountDistinctRecords
FROM erprastreamento.ordemdeservicoagendamentos."Agendamentos" AS Agendamento
LEFT JOIN erprastreamento.ordemdeservico."OrdemDeServico" AS OS
         ON OS."Id" = Agendamento."OS_Id"
WHERE Agendamento."Situacao_Id" = 'concluida'
and Agendamento.deleted_at is null;
