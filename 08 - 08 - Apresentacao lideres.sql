SELECT TECNICOPESSOA."TecnicoNome"                                        as NomeDoTecnico,
       OS."Veiculo_Id"                                                    as OS_Veiculo_Id,
       OS."Situacao_Id"                                                   as OS_Situacao_Id,
       OS."Tipo_Id"                                                       as OS_Tipo_Id,
       OS."Motivo_Id"                                                     as OS_Motivo_Id,
       OS."Franquia_Id"                                                   as OS_Franquia_Id,
       OS."Descricao"                                                     as OS_Descricao_Id,
       CAST(OS."created_at" AS TIMESTAMP(0))                              as OS_Created_at,
       CAST(Agendamento."created_at" AS TIMESTAMP(0))                     as Agendamento_Created_at,
       CAST(Agendamento."InicioDoServico" AS TIMESTAMP(0))                as Agendamento_InicioDoServico,
       CAST(Agendamento."FimDoServico" AS TIMESTAMP(0))                   as Agendamento_FimDoServico,
       CAST(Agendamento."Agendamento" AS TIMESTAMP(0))                    as Agendamento_DataDoAgendamento,
       Agendamento."OS_Id"                                                as Agendamento_OS_Id,
       Agendamento."Situacao_Id"                                          as Agendamento_Situacao_Id,
       Agendamento."Etapa_Id"                                             as Agendamento_Etapa_Id,
       Veiculo."Id"                                                       as Veiculo_Id,
       Veiculo."Placa"                                                    as Veiculo_Placa,
       Veiculo."Apelido"                                                  as Veiculo_Apelido,
       Veiculo."NumeroDoChassi"                                           as Veiculo_NumeroDoChassi,
       Veiculo."Cor"                                                      as Veiculo_Cor,
       Veiculo."AnoDeFabricacao"                                          as Veiculo_AnoDeFabricacao,
       Veiculo."Maquina"                                                  as Veiculo_Maquina,
       ItensRastreaveis."Id"                                              as ItensRastreaveis_Id,
       ItensRastreaveis."Placa"                                           as ItensRastreaveis_Placa,
       ItensRastreaveis."DataDeAtivacao"                                  as ItensRastreaveis_DataDeAtivacao,
       ItensRastreaveis."DataDeAtivacaoLegado"                            as ItensRastreaveis_DataDeAtivacaoLegado,
       ItensRastreaveis."DataDeDesativacao"                               as ItensRastreaveis_DataDeDesativacao,
       ItensRastreaveis."DataDeDesativacaoLegado"                         as ItensRastreaveis_DataDeDesativacaoLegado,
       ItensRastreaveis."Permuta"                                         as ItensRastreaveis_Permuta,
       ItensRastreaveis."PagamentoAnual"                                  as ItensRastreaveis_PagamentoAnual,
       TECNICO."Id"                                                       AS Tecnico_id,
       Agendamento."Id"                                                   AS Agendamento_Id,
       OS."Id"                                                            AS OS_id,
       TECNICO."ClientePessoaPrestadorId"                                 AS Cliente_id,
       TECNICO."FornecedorPessoaPrestadorId"                              AS fornecedor_id,
       TECNICO."ColaboradorPessoaPrestadorId"                             AS colaborador_id,
       PROPOSTA."Propostas_Id"                                            AS Proposta_id,
       OrdemPagamentoLancamento."LcId"                                    AS Lancamento_id,
       CLIENTEPROPOSTA."ClienteDePropostaId"                              AS ClienteDeProposta_id,
       CAST(MovimentacoesLancamento."MOVDataDePagamento" AS TIMESTAMP(0)) AS Movimentacoes_DataDePagamento
FROM erprastreamento.ordemdeservico."OrdemDeServico" AS OS
         LEFT JOIN erprastreamento.ordemdeservicoagendamentos."Agendamentos" AS Agendamento
                   ON OS."Id" = Agendamento."OS_Id"
         LEFT JOIN dblink('dbname=identidades', 'SELECT
                            TEC."Id",
                            -- Este vínculo com o cliente é para OSs executados pelo próprio cliente
                            CL."Pessoa_Id" AS "ClientePessoaPrestadorId",
                            FO."Pessoa_Id" AS "FornecedorPessoaPrestadorId",
                            CO."Pessoa_Id" AS "ColaboradorPessoaPrestadorId"
                            FROM identidades.pessoas."Tecnicos" AS TEC
                              LEFT JOIN identidades.pessoas."Clientes" AS CL ON TEC."TipoPessoa_Id" = CL."Id"
                              LEFT JOIN identidades.pessoas."Fornecedores" AS FO ON TEC."TipoPessoa_Id" = FO."Id"
                              LEFT JOIN identidades.pessoas."Colaboradores" AS CO ON TEC."TipoPessoa_Id" = CO."Id"')
                                AS TECNICO ("Id" uuid,
                                            "ClientePessoaPrestadorId" uuid,
                                            "FornecedorPessoaPrestadorId" uuid,
                                            "ColaboradorPessoaPrestadorId" uuid)
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
                                AS OrdemPagamentoLancamento ("LcId" uuid, "OpId" uuid, "OsId" uuid)
                                  ON OS."Id" = OrdemPagamentoLancamento."OsId"
         LEFT JOIN dblink('dbname=identidades',
                         'SELECT Tecnicos."Id",Pessoas."Nome" from identidades.public."Pessoas" as Pessoas
                             left join identidades.pessoas."Colaboradores" as Colaboradores on Colaboradores."Pessoa_Id" = Pessoas."Id"
                             left join identidades.pessoas."Tecnicos" as Tecnicos on Tecnicos."TipoPessoa_Id" = Colaboradores."Id"')
                                AS TECNICOPESSOA("TecnicoNomeId" uuid, "TecnicoNome" text)
                                    ON Agendamento."Tecnico_Id" = TECNICOPESSOA."TecnicoNomeId"
         LEFT JOIN dblink('dbname=identidades',
                        'SELECT Veic."Id",Veic."Placa",Veic."Apelido",Veic."NumeroDoChassi",Veic."Cor",Veic."AnoDeFabricacao",Veic."Maquina" from identidades.veiculos."Veiculos" as Veic')
                                as VEICULO("Id" uuid,"Placa" text,"Apelido" text,"NumeroDoChassi" text,"Cor" text,"AnoDeFabricacao" integer,"Maquina" boolean)
                                    on OS."Veiculo_Id" = VEICULO."Id"
         LEFT JOIN dblink('dbname=identidades',
                        'SELECT IR."Id", Veic."Placa",IR."DataDeAtivacao",IR."DataDeAtivacaoLegado",IR."DataDeDesativacao",IR."DataDeDesativacaoLegado",IR."Permuta",IR."PagamentoAnual" from identidades.itensrastreaveis."ItensRastreaveis" as IR
                             Left Join identidades.veiculos."Veiculos" as Veic on IR."Veiculo_Id" = Veic."Id"')
                                as ItensRastreaveis("Id" uuid, "Placa" text,"DataDeAtivacao" date,"DataDeAtivacaoLegado" date,"DataDeDesativacao" date,"DataDeDesativacaoLegado" date,"Permuta" boolean,"PagamentoAnual" boolean)
                                    on OS."ItemRastreavel_Id" = ItensRastreaveis."Id"
         LEFT JOIN dblink('dbname=financeiro',
                        'SELECT LC."Id" AS LcId, MOV."DataDePagamento" as MOVDataDePagamento,OP."OS_Id" FROM financeiro.public."OrdensDepagamento" AS OP
                              LEFT JOIN financeiro.lancamentos."Lancamentos" AS LC ON OP."Id" = LC."OrdemDePagamento_Id"
                              LEFT JOIN financeiro.public."Movimentacoes" as MOV on LC."Id" = MOV."Lancamento_Id"')
                                AS MovimentacoesLancamento ("LcId" uuid, "MOVDataDePagamento" date,"OS_Id" uuid)
                                  ON OS."Id" = MovimentacoesLancamento."OS_Id";




-- Tentando corrigir o erro de data de pagamento nulo

SELECT TECNICOPESSOA."TecnicoNome"                                                     as NomeDoTecnico,
       OS."Veiculo_Id"                                                                 as OS_Veiculo_Id,
       OS."Situacao_Id"                                                                as OS_Situacao_Id,
       OS."Tipo_Id"                                                                    as OS_Tipo_Id,
       OS."Motivo_Id"                                                                  as OS_Motivo_Id,
       OS."Franquia_Id"                                                                as OS_Franquia_Id,
       OS."Descricao"                                                                  as OS_Descricao_Id,
       CAST(OS."created_at" AS TIMESTAMP(0))                                           as OS_Created_at,
       CAST(Agendamento."created_at" AS TIMESTAMP(0))                                  as Agendamento_Created_at,
       CAST(Agendamento."InicioDoServico" AS TIMESTAMP(0))                             as Agendamento_InicioDoServico,
       CAST(Agendamento."FimDoServico" AS TIMESTAMP(0))                                as Agendamento_FimDoServico,
       CAST(Agendamento."Agendamento" AS TIMESTAMP(0))                                 as Agendamento_DataDoAgendamento,
       Agendamento."OS_Id"                                                             as Agendamento_OS_Id,
       Agendamento."Situacao_Id"                                                       as Agendamento_Situacao_Id,
       Agendamento."Etapa_Id"                                                          as Agendamento_Etapa_Id,
       Veiculo."Id"                                                                    as Veiculo_Id,
       Veiculo."Placa"                                                                 as Veiculo_Placa,
       Veiculo."Apelido"                                                               as Veiculo_Apelido,
       Veiculo."NumeroDoChassi"                                                        as Veiculo_NumeroDoChassi,
       Veiculo."Cor"                                                                   as Veiculo_Cor,
       Veiculo."AnoDeFabricacao"                                                       as Veiculo_AnoDeFabricacao,
       Veiculo."Maquina"                                                               as Veiculo_Maquina,
       ItensRastreaveis."Id"                                                           as ItensRastreaveis_Id,
       ItensRastreaveis."Placa"                                                        as ItensRastreaveis_Placa,
       ItensRastreaveis."DataDeAtivacao"                                               as ItensRastreaveis_DataDeAtivacao,
       ItensRastreaveis."DataDeAtivacaoLegado"                                         as ItensRastreaveis_DataDeAtivacaoLegado,
       ItensRastreaveis."DataDeDesativacao"                                            as ItensRastreaveis_DataDeDesativacao,
       ItensRastreaveis."DataDeDesativacaoLegado"                                      as ItensRastreaveis_DataDeDesativacaoLegado,
       ItensRastreaveis."Permuta"                                                      as ItensRastreaveis_Permuta,
       ItensRastreaveis."PagamentoAnual"                                               as ItensRastreaveis_PagamentoAnual,
       TECNICO."Id"                                                                    AS Tecnico_id,
       Agendamento."Id"                                                                AS Agendamento_Id,
       OS."Id"                                                                         AS OS_id,
       TECNICO."ClientePessoaPrestadorId"                                              AS Cliente_id,
       TECNICO."FornecedorPessoaPrestadorId"                                           AS fornecedor_id,
       TECNICO."ColaboradorPessoaPrestadorId"                                          AS colaborador_id,
       PROPOSTA."Propostas_Id"                                                         AS Proposta_id,
       OrdemPagamentoLancamento."LcId"                                                 AS Lancamento_id,
       CLIENTEPROPOSTA."ClienteDePropostaId"                                           AS ClienteDeProposta_id,
       CAST(MovimentacoesLancamentoDesinstalacao."MOVDataDePagamento" AS TIMESTAMP(0)) AS Movimentacoes_DataDePagamentoDesinstalacao,
       CAST(MovimentacoesLancamentoInstalacao."MOVDataDePagamento" AS TIMESTAMP(0))    AS Movimentacoes_DataDePagamentoInstalacao
FROM erprastreamento.ordemdeservico."OrdemDeServico" AS OS
         LEFT JOIN erprastreamento.ordemdeservicoagendamentos."Agendamentos" AS Agendamento
                   ON OS."Id" = Agendamento."OS_Id"
         LEFT JOIN dblink('dbname=identidades', 'SELECT
                            TEC."Id",
                            -- Este vínculo com o cliente é para OSs executados pelo próprio cliente
                            CL."Pessoa_Id" AS "ClientePessoaPrestadorId",
                            FO."Pessoa_Id" AS "FornecedorPessoaPrestadorId",
                            CO."Pessoa_Id" AS "ColaboradorPessoaPrestadorId"
                            FROM identidades.pessoas."Tecnicos" AS TEC
                              LEFT JOIN identidades.pessoas."Clientes" AS CL ON TEC."TipoPessoa_Id" = CL."Id"
                              LEFT JOIN identidades.pessoas."Fornecedores" AS FO ON TEC."TipoPessoa_Id" = FO."Id"
                              LEFT JOIN identidades.pessoas."Colaboradores" AS CO ON TEC."TipoPessoa_Id" = CO."Id"')
                                AS TECNICO ("Id" uuid,
                                            "ClientePessoaPrestadorId" uuid,
                                            "FornecedorPessoaPrestadorId" uuid,
                                            "ColaboradorPessoaPrestadorId" uuid)
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
                                AS OrdemPagamentoLancamento ("LcId" uuid, "OpId" uuid, "OsId" uuid)
                                  ON OS."Id" = OrdemPagamentoLancamento."OsId"
         LEFT JOIN dblink('dbname=identidades',
                         'SELECT Tecnicos."Id",Pessoas."Nome" from identidades.public."Pessoas" as Pessoas
                             left join identidades.pessoas."Colaboradores" as Colaboradores on Colaboradores."Pessoa_Id" = Pessoas."Id"
                             left join identidades.pessoas."Tecnicos" as Tecnicos on Tecnicos."TipoPessoa_Id" = Colaboradores."Id"')
                                AS TECNICOPESSOA("TecnicoNomeId" uuid, "TecnicoNome" text)
                                    ON Agendamento."Tecnico_Id" = TECNICOPESSOA."TecnicoNomeId"
         LEFT JOIN dblink('dbname=identidades',
                        'SELECT Veic."Id",Veic."Placa",Veic."Apelido",Veic."NumeroDoChassi",Veic."Cor",Veic."AnoDeFabricacao",Veic."Maquina" from identidades.veiculos."Veiculos" as Veic')
                                as VEICULO("Id" uuid,"Placa" text,"Apelido" text,"NumeroDoChassi" text,"Cor" text,"AnoDeFabricacao" integer,"Maquina" boolean)
                                    on OS."Veiculo_Id" = VEICULO."Id"
         LEFT JOIN dblink('dbname=identidades',
                        'SELECT IR."Id", Veic."Placa",IR."DataDeAtivacao",IR."DataDeAtivacaoLegado",IR."DataDeDesativacao",IR."DataDeDesativacaoLegado",IR."Permuta",IR."PagamentoAnual" from identidades.itensrastreaveis."ItensRastreaveis" as IR
                             Left Join identidades.veiculos."Veiculos" as Veic on IR."Veiculo_Id" = Veic."Id"')
                                as ItensRastreaveis("Id" uuid, "Placa" text,"DataDeAtivacao" date,"DataDeAtivacaoLegado" date,"DataDeDesativacao" date,"DataDeDesativacaoLegado" date,"Permuta" boolean,"PagamentoAnual" boolean)
                                    on OS."ItemRastreavel_Id" = ItensRastreaveis."Id"
         LEFT JOIN dblink('dbname=financeiro',
                        'SELECT LC."Id" AS LcId, MOV."DataDePagamento" as MOVDataDePagamento,OP."OS_Id" FROM financeiro.public."OrdensDepagamento" AS OP
                              LEFT JOIN financeiro.lancamentos."Lancamentos" AS LC ON OP."Id" = LC."OrdemDePagamento_Id"
                              LEFT JOIN financeiro.public."Movimentacoes" as MOV on LC."Id" = MOV."Lancamento_Id" ')
                                AS MovimentacoesLancamentoDesinstalacao ("LcId" uuid, "MOVDataDePagamento" date,"OS_Id" uuid)
                                  ON OS."Id" = MovimentacoesLancamentoDesinstalacao."OS_Id"
         LEFT JOIN dblink('dbname=financeiro',
                        'SELECT LC."Id" AS LcId, MOV."DataDePagamento" as MOVDataDePagamento,OP."Proposta_Id" as Prop_Id,OP."OS_Id" FROM financeiro.public."OrdensDepagamento" AS OP
                              LEFT JOIN financeiro.lancamentos."Lancamentos" AS LC ON OP."Id" = LC."OrdemDePagamento_Id"
                              LEFT JOIN financeiro.public."Movimentacoes" as MOV on LC."Id" = MOV."Lancamento_Id" ')
                                AS MovimentacoesLancamentoInstalacao ("LcId" uuid, "MOVDataDePagamento" date,"OS_Id" uuid,"Prop_Id" uuid)
                                  ON OS."Proposta_Id" = MovimentacoesLancamentoInstalacao."Prop_Id"
WHERE OS."Tipo_Id"='instalacao';