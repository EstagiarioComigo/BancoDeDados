-- Código simples
select * from identidades.public."Pessoas" as Pessoas
   left join identidades.pessoas."Colaboradores" as Colaboradores on Colaboradores."Pessoa_Id"= Pessoas."Id"
         left join identidades.pessoas."Tecnicos" as Tecnicos on Tecnicos."TipoPessoa_Id"=Colaboradores."Id"
   where Tecnicos."Id"='b9a77824-d64c-491f-a95a-071d7f7cf9de';

-- O mesmo código sendo usado em uma consulta mais complexa com integração entre bancos de dados
SELECT NOMETECNICO."TecnicoNome",
       OS."Id",
       OS."Veiculo_Id",
       OS."Situacao_Id",
       OS."Tipo_Id",
       OS."Motivo_Id",
       OS."Franquia_Id",
       OS."Descricao",
       Agendamento."Id",
       Agendamento."InicioDoServico",
       Agendamento."FimDoServico",
       Agendamento."Agendamento",
       Agendamento."OS_Id",
       Agendamento."Situacao_Id",
       Agendamento."Etapa_Id",
       TECNICO."Id"          AS Tecnico_id,
       Agendamento."Id"      AS Agendamento_Id,
       OS."Id"               AS OS_id,
       "ClientePessoaid"     AS Cliente_id,
       "FornecedorPessoaid"  AS fornecedor_id,
       "ColaboradorPessoaid" AS colaborador_id,
       "Propostas_Id"        AS Proposta_id,
       "LcId"                as Lancamento_id,
       CLIENTEPROPOSTA."ClienteDePropostaId" AS ClienteDeProposta_id
FROM erprastreamento.ordemdeservico."OrdemDeServico" AS OS
         LEFT JOIN erprastreamento.ordemdeservicoagendamentos."Agendamentos" AS Agendamento
                   ON OS."Id" = Agendamento."OS_Id"
         LEFT JOIN dblink('dbname=identidades', 'SELECT
    TECNICOS."Id",
    CLIENTE."Pessoa_Id" AS "ClientePessoaid",
    FORNECEDOR."Pessoa_Id" AS "FornecedorPessoaid",
    COLABORADOR."Pessoa_Id" AS "ColaboradorPessoaid"
FROM identidades.pessoas."Tecnicos" AS TECNICOS
    LEFT JOIN identidades.pessoas."Clientes" AS CLIENTE ON TECNICOS."TipoPessoa_Id" = CLIENTE."Id"
    LEFT JOIN identidades.pessoas."Fornecedores" AS FORNECEDOR ON TECNICOS."TipoPessoa_Id" = FORNECEDOR."Id"
    LEFT JOIN identidades.pessoas."Colaboradores" AS COLABORADOR ON TECNICOS."TipoPessoa_Id" = COLABORADOR."Id"')
    AS TECNICO ("Id" uuid,
                "ClientePessoaid" uuid,
                "FornecedorPessoaid" uuid,
                "ColaboradorPessoaid" uuid)
                   ON TECNICO."Id" = Agendamento."Tecnico_Id"
         LEFT JOIN dblink('dbname=marketplace',
                          'SELECT PROPOSTAS."Id" AS Propostas_Id, PROPOSTAS."Cliente_Id" AS MarPropostasClienteId FROM marketplace.propostas."Propostas" AS PROPOSTAS')
                            AS PROPOSTA ("Propostas_Id" uuid, "MarPropostasClienteId" uuid)
                             ON OS."Proposta_Id" = PROPOSTA."Propostas_Id"
         LEFT JOIN dblink('dbname=identidades',
                          'SELECT CLIENTESDEPROPOSTAS."Id" AS ClienteDePropostaId FROM identidades.pessoas."Clientes" AS CLIENTESDEPROPOSTAS')
                            AS CLIENTEPROPOSTA ("ClienteDePropostaId" uuid)
                             ON PROPOSTA."MarPropostasClienteId" = CLIENTEPROPOSTA."ClienteDePropostaId"
         LEFT JOIN dblink('dbname=financeiro',
                          'SELECT LC."Id" AS LcId, OP."Id" AS OpId, OP."OS_Id" AS OsId FROM financeiro.public."OrdensDepagamento" AS OP
                              LEFT JOIN financeiro.lancamentos."Lancamentos" AS LC ON OP."Id" = LC."OrdemDePagamento_Id"')
                                AS OPELC ("LcId" uuid, "OpId" uuid, "OsId" uuid)
                                  ON OS."Id" = OPELC."OsId"
         LEFT JOIN dblink('dbname=identidades',
                         'SELECT Tecnicos."Id",Pessoas."Nome" from identidades.public."Pessoas" as Pessoas
                             left join identidades.pessoas."Colaboradores" as Colaboradores on Colaboradores."Pessoa_Id" = Pessoas."Id"
                             left join identidades.pessoas."Tecnicos" as Tecnicos on Tecnicos."TipoPessoa_Id" = Colaboradores."Id"')
                                AS NOMETECNICO("TecnicoNomeId" uuid, "TecnicoNome" text)
                                    ON Agendamento."Tecnico_Id" = NOMETECNICO."TecnicoNomeId";
