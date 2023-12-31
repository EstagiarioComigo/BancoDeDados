-- QUE GILVAN MANDOU

-- Por plano de contas de despesa
SELECT
    PCI."Nome",
    (sum(MV."ValorPago")/100) as SomaValor
FROM
    financeiro.lancamentos."Lancamentos" as LC
    left join financeiro.public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id"='c07e66d4-e4c2-4444-a047-e2952adcf663' -- MAXLINE 6f47b439-d725-4508-b47c-728f0dce2166
    -- AND PC."Id" = '707c6484-dacd-43c9-adea-7d3045e32843'
    AND (LC."Vencimento" >= (('2023/07/01')::timestamptz) AND LC."Vencimento" <= (('2023/07/31')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'despesa'
group by PCI."Nome";


-- Por plano de contas de receita
SELECT
    PCI."Nome",
    (sum(MV."ValorPago")/100) as SomaValor
FROM
    financeiro.lancamentos."Lancamentos" as LC
    left join financeiro.public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id"='c07e66d4-e4c2-4444-a047-e2952adcf663'
    -- AND PC."Id" = '707c6484-dacd-43c9-adea-7d3045e32843'
    AND (LC."Vencimento" >= (('2023/07/01')::timestamptz) AND LC."Vencimento" <= (('2023/07/31')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
group by PCI."Nome";


-- Id Franqui / Id Pessoa / Url
-- 4eb453af-1270-48da-bf78-374a8131b5e9 5f61f680-4c0c-4e47-aa29-5ecdda434521 https://currais.semprecomigo.com
-- 6f47b439-d725-4508-b47c-728f0dce2166 b9d5e8c7-2cc3-44c4-a366-03fe89f9177d https://maxline.semprecomigo.com
-- 70791887-a5c9-41ec-9dd1-fd56c5eb2f81 6baaf1ad-086e-4678-ad9e-ef0f21c4a62d https://assistencia.semprecomigo.com
-- c07e66d4-e4c2-4444-a047-e2952adcf663 79a3a873-9457-43de-9abc-469b6af80156 https://rastreamento.semprecomigo.com
-- 263d16c7-4dde-4a2d-a72d-d82870f0adbc 519bb4ad-4fa4-45ed-8227-64a64572c5b3 https://marketplace.semprecomigo.com

-- Por plano de contas de despesa
SELECT
    PCI."Nome",
    (sum(MV."ValorPago")/100) as SomaValor
FROM
    financeiro.lancamentos."Lancamentos" as LC
    left join financeiro.public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id"='c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."Vencimento" >= (('2023/07/01')::timestamptz) AND LC."Vencimento" <= (('2023/07/31')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'despesa'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = true
    AND
        (
            (LC."Lancamento_Id" IS NOT NULL AND LC."ModalidadeDoLancamento_Id" = 'recorrente')
            OR
            (LC."Lancamento_Id" IS NULL AND (LC."ModalidadeDoLancamento_Id" <> 'recorrente' AND LC."TipoDoLancamento_Id" <> 'transferencia')
        )
    )
group by PCI."Nome";



-- Por plano de contas de receita
SELECT
    PCI."Nome",
    (sum(MV."ValorPago")/100) as SomaValor
FROM
    financeiro.lancamentos."Lancamentos" as LC
    left join financeiro.public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."Vencimento" >= (('2023/07/01')::timestamptz) AND LC."Vencimento" <= (('2023/07/31')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = true
    AND
        (
            (LC."Lancamento_Id" IS NOT NULL AND LC."ModalidadeDoLancamento_Id" = 'recorrente')
                OR (LC."Lancamento_Id" IS NULL AND (LC."ModalidadeDoLancamento_Id" <> 'recorrente' AND LC."TipoDoLancamento_Id" <> 'transferencia')
            )
        )
group by PCI."Nome";




-- Descrição dos lançamentos
SELECT
    LC."Descricao",
    MV."ValorPago"
FROM
    financeiro.lancamentos."Lancamentos" as LC
    left join financeiro.public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id"='c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."Vencimento" >= (('2023/07/01')::timestamptz) AND LC."Vencimento" <= (('2023/07/31')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'despesa'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = true
    AND LC."PlanoDeContaItem_Id" IS NULL
    AND
        (
            (LC."Lancamento_Id" IS NOT NULL AND LC."ModalidadeDoLancamento_Id" = 'recorrente')
            OR
            (LC."Lancamento_Id" IS NULL AND (LC."ModalidadeDoLancamento_Id" <> 'recorrente' AND LC."TipoDoLancamento_Id" <> 'transferencia')
        )
    )


-- Dia 22/08

-- Por plano de contas de despesa
SELECT
    PCI."Nome",
    (sum(MV."ValorPago")/100) as SomaValor
FROM
    financeiro.lancamentos."Lancamentos" as LC
    left join financeiro.lancamentos."Lancamentos" as LP on LC."Lancamento_Id" = LP."Id"
    left join financeiro.public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LP."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id"='c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."Vencimento" >= (('2023/06/01')::timestamptz) AND LC."Vencimento" <= (('2023/06/30')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'despesa'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = true
    AND (LC."Lancamento_Id" IS NOT NULL AND LC."ModalidadeDoLancamento_Id" = 'recorrente')
group by PCI."Nome";

-- Por plano de contas de despesa
SELECT
    PCI."Nome",
    (sum(MV."ValorPago")/100) as SomaValor
FROM
    financeiro.lancamentos."Lancamentos" as LC
    left join financeiro.lancamentos."Lancamentos" as LP on LC."Lancamento_Id" = LP."Id"
    left join financeiro.public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id"='c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."Vencimento" >= (('2023/06/01')::timestamptz) AND LC."Vencimento" <= (('2023/06/30')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'despesa'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = true
    AND (LC."Lancamento_Id" IS NULL AND (LC."ModalidadeDoLancamento_Id" <> 'recorrente' AND LC."TipoDoLancamento_Id" <> 'transferencia'))
group by PCI."Nome";

-- Por plano de contas de receita
SELECT
    PCI."Nome",
    (sum(MV."ValorPago")/100) as SomaValor
FROM
    financeiro.lancamentos."Lancamentos" as LC
    left join financeiro.lancamentos."Lancamentos" as LP on LC."Lancamento_Id" = LP."Id"
    left join financeiro.public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."Vencimento" >= (('2023/06/01')::timestamptz) AND LC."Vencimento" <= (('2023/06/30')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = true
    AND LC."Lancamento_Id" IS NOT NULL
    AND LC."ModalidadeDoLancamento_Id" = 'recorrente'
group by PCI."Nome";

-- Por plano de contas de receita
SELECT
    PCI."Nome",
    (sum(MV."ValorPago")/100) as SomaValor
FROM
    financeiro.lancamentos."Lancamentos" as LC
    left join financeiro.lancamentos."Lancamentos" as LP on LC."Lancamento_Id" = LP."Id"
    left join financeiro.public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."Vencimento" >= (('2023/06/01')::timestamptz) AND LC."Vencimento" <= (('2023/06/30')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = true
    AND LC."Lancamento_Id" IS NULL
    AND LC."ModalidadeDoLancamento_Id" <> 'recorrente'
    AND LC."TipoDoLancamento_Id" <> 'transferencia'
group by PCI."Nome";

SELECT
    PCI."Nome",
    (sum(MV."ValorPago")/100) as SomaValor
FROM
    financeiro.lancamentos."Lancamentos" as LC
    left join financeiro.lancamentos."Lancamentos" as LP on LC."Lancamento_Id" = LP."Id"
    left join financeiro.public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."Vencimento" >= (('2023/07/01')::timestamptz) AND LC."Vencimento" <= (('2023/07/31')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = true
    AND LC."Lancamento_Id" IS NULL AND LC."ModalidadeDoLancamento_Id" <> 'recorrente' AND LC."TipoDoLancamento_Id" <> 'transferencia'
group by PCI."Nome";


-- Gilvan mandou no dia 28/08


-- Id Franqui / Id Pessoa / Url
-- 4eb453af-1270-48da-bf78-374a8131b5e9 5f61f680-4c0c-4e47-aa29-5ecdda434521 https://currais.semprecomigo.com
-- 6f47b439-d725-4508-b47c-728f0dce2166 b9d5e8c7-2cc3-44c4-a366-03fe89f9177d https://maxline.semprecomigo.com
-- 70791887-a5c9-41ec-9dd1-fd56c5eb2f81 6baaf1ad-086e-4678-ad9e-ef0f21c4a62d https://assistencia.semprecomigo.com
-- c07e66d4-e4c2-4444-a047-e2952adcf663 79a3a873-9457-43de-9abc-469b6af80156 https://rastreamento.semprecomigo.com
-- 263d16c7-4dde-4a2d-a72d-d82870f0adbc 519bb4ad-4fa4-45ed-8227-64a64572c5b3 https://marketplace.semprecomigo.com


-----------------------------------------------------------------------------------------
-- Abril


SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON (LP."PlanoDeContaItem_Id" = PCI."Id" OR LC."PlanoDeContaItem_Id" = PCI."Id")
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-03-31'::timestamptz) AND LC."DataDeCompetencia" < ('2023-05-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'despesa'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = TRUE
    AND ((LC."Lancamento_Id" IS NOT NULL AND LC."ModalidadeDoLancamento_Id" = 'recorrente')
         OR (LC."Lancamento_Id" IS NULL AND (LC."ModalidadeDoLancamento_Id" <> 'recorrente' AND LC."TipoDoLancamento_Id" <> 'transferencia')))
group by PCI."Nome";

SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-03-31'::timestamptz) AND LC."DataDeCompetencia" < ('2023-05-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = TRUE
    AND LC."Lancamento_Id" IS NOT NULL
    AND LC."ModalidadeDoLancamento_Id" = 'recorrente'
group by PCI."Nome"

UNION ALL

SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-03-31'::timestamptz) AND LC."DataDeCompetencia" < ('2023-05-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = TRUE
    AND LC."Lancamento_Id" IS NULL
    AND LC."ModalidadeDoLancamento_Id" <> 'recorrente'
    AND LC."TipoDoLancamento_Id" <> 'transferencia'
group by PCI."Nome";


-----------------------------------------------------------------------------------------
-- Maio


SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON (LP."PlanoDeContaItem_Id" = PCI."Id" OR LC."PlanoDeContaItem_Id" = PCI."Id")
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-04-30'::timestamptz) AND LC."DataDeCompetencia" < ('2023-06-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'despesa'
    AND LC.deleted_at IS NULL
    AND ((LC."Lancamento_Id" IS NOT NULL AND LC."ModalidadeDoLancamento_Id" = 'recorrente')
         OR (LC."Lancamento_Id" IS NULL AND (LC."ModalidadeDoLancamento_Id" <> 'recorrente' AND LC."TipoDoLancamento_Id" <> 'transferencia')))
group by PCI."Nome";

SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-04-30'::timestamptz) AND LC."DataDeCompetencia" < ('2023-06-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Lancamento_Id" IS NOT NULL
    AND LC."ModalidadeDoLancamento_Id" = 'recorrente'
--     AND (MV."DataDePagamento" > LC."Vencimento" AND MV."DataDePagamento" >= ('2023-05-25'::timestamptz))
--     AND MV."DataDePagamento" > LC."Vencimento"
--     AND MV."DataDePagamento" > (LC."Vencimento" + INTERVAL '5 DAY')
group by PCI."Nome"

UNION ALL

SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-04-30'::timestamptz) AND LC."DataDeCompetencia" < ('2023-06-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Lancamento_Id" IS NULL
    AND LC."ModalidadeDoLancamento_Id" <> 'recorrente'
    AND LC."TipoDoLancamento_Id" <> 'transferencia'
--     AND (MV."DataDePagamento" > LC."Vencimento" AND MV."DataDePagamento" >= ('2023-05-25'::timestamptz))
--     AND MV."DataDePagamento" > LC."Vencimento"
--     AND MV."DataDePagamento" > (LC."Vencimento" + INTERVAL '5 DAY')
group by PCI."Nome";


-----------------------------------------------------------------------------------------
-- Junho


SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON (LP."PlanoDeContaItem_Id" = PCI."Id" OR LC."PlanoDeContaItem_Id" = PCI."Id")
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-05-31'::timestamptz) AND LC."DataDeCompetencia" < ('2023-07-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'despesa'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = TRUE
    AND ((LC."Lancamento_Id" IS NOT NULL AND LC."ModalidadeDoLancamento_Id" = 'recorrente')
         OR (LC."Lancamento_Id" IS NULL AND (LC."ModalidadeDoLancamento_Id" <> 'recorrente' AND LC."TipoDoLancamento_Id" <> 'transferencia')))
group by PCI."Nome";

SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-05-31'::timestamptz) AND LC."DataDeCompetencia" < ('2023-07-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Lancamento_Id" IS NOT NULL
    AND LC."ModalidadeDoLancamento_Id" = 'recorrente'
--     AND (MV."DataDePagamento" > LC."Vencimento" AND MV."DataDePagamento" >= ('2023-06-25'::timestamptz))
group by PCI."Nome"

UNION ALL

SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-05-31'::timestamptz) AND LC."DataDeCompetencia" < ('2023-07-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Lancamento_Id" IS NULL
    AND LC."ModalidadeDoLancamento_Id" <> 'recorrente'
    AND LC."TipoDoLancamento_Id" <> 'transferencia'
--     AND (MV."DataDePagamento" > LC."Vencimento" AND MV."DataDePagamento" >= ('2023-06-25'::timestamptz))
group by PCI."Nome";


-----------------------------------------------------------------------------------------
-- Julho


SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON (LP."PlanoDeContaItem_Id" = PCI."Id" OR LC."PlanoDeContaItem_Id" = PCI."Id")
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-06-30'::timestamptz) AND LC."DataDeCompetencia" < ('2023-08-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'despesa'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = TRUE
    AND ((LC."Lancamento_Id" IS NOT NULL AND LC."ModalidadeDoLancamento_Id" = 'recorrente')
         OR (LC."Lancamento_Id" IS NULL AND (LC."ModalidadeDoLancamento_Id" <> 'recorrente' AND LC."TipoDoLancamento_Id" <> 'transferencia')))
group by PCI."Nome";

SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-06-30'::timestamptz) AND LC."DataDeCompetencia" < ('2023-08-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Lancamento_Id" IS NOT NULL
    AND LC."ModalidadeDoLancamento_Id" = 'recorrente'
--     AND (MV."DataDePagamento" > LC."Vencimento" AND MV."DataDePagamento" >= ('2023-07-25'::timestamptz))
group by PCI."Nome"

UNION ALL

SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-06-30'::timestamptz) AND LC."DataDeCompetencia" < ('2023-08-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Lancamento_Id" IS NULL
    AND LC."ModalidadeDoLancamento_Id" <> 'recorrente'
    AND LC."TipoDoLancamento_Id" <> 'transferencia'
--     AND (MV."DataDePagamento" > LC."Vencimento" AND MV."DataDePagamento" >= ('2023-07-25'::timestamptz))
group by PCI."Nome";


-----------------------------------------------------------------------------------------
-- Agosto


SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",,
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON (LP."PlanoDeContaItem_Id" = PCI."Id" OR LC."PlanoDeContaItem_Id" = PCI."Id")
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-07-31'::timestamptz) AND LC."DataDeCompetencia" < ('2023-09-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'despesa'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = TRUE
    AND ((LC."Lancamento_Id" IS NOT NULL AND LC."ModalidadeDoLancamento_Id" = 'recorrente')
         OR (LC."Lancamento_Id" IS NULL AND (LC."ModalidadeDoLancamento_Id" <> 'recorrente' AND LC."TipoDoLancamento_Id" <> 'transferencia')))
group by PCI."Nome";

SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-07-31'::timestamptz) AND LC."DataDeCompetencia" < ('2023-09-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = TRUE
    AND LC."Lancamento_Id" IS NOT NULL
    AND LC."ModalidadeDoLancamento_Id" = 'recorrente'
group by PCI."Nome"

UNION ALL

SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-07-31'::timestamptz) AND LC."DataDeCompetencia" < ('2023-09-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = TRUE
    AND LC."Lancamento_Id" IS NULL
    AND LC."ModalidadeDoLancamento_Id" <> 'recorrente'
    AND LC."TipoDoLancamento_Id" <> 'transferencia'
group by PCI."Nome";

-----------------------------------------------------------------------------------------------------------------------



-- MINHA VEZ


SELECT LC."Id"                               AS Lanc_Id,
       CAST(LC.created_at AS TIMESTAMP(0))   AS Lanc_Created_At,
       CAST(LC.updated_at AS TIMESTAMP(0))   AS Lanc_Updated_At,
       CAST(LC.deleted_at AS TIMESTAMP(0))   AS Lanc_Deleted_At,
       LC."Descricao"                        AS Lanc_Descricao,
       CAST(LC."Vencimento" AS TIMESTAMP(0)) AS Lanc_Vencimento,
       LC."Valor"                            AS Lanc_Valor,
       LC."Cliente_Id"                       AS Lanc_Cliente_Id,
       LC."Fornecedor_Id"                    AS Lanc_Fornecedor_Id,
       LC."ContaBancaria_Id"                 AS Lanc_ContaBancaria_Id,
       LC."DataDeCompetencia"                AS Lanc_DataDeCompetencia,
       LC."Fatura_Id"                        AS Lanc_Fatura_Id,
       LC."Boleto_Id"                        AS Lanc_Boleto_Id,
       LC."NFCE_Id"                          AS Lanc_NFCE_Id,
       LC."NFS_Id"                           AS Lanc_NFS_Id,
       LC."NumeroReciboPrestador"            AS Lanc_NumeroReciboPrestador,
       LC."TipoDePagamento_Id"               AS Lanc_TipoDePagamento_Id,
       LC."TipoDoLancamento_Id"              AS Lanc_TipoDoLancamento_Id,
       LC."FormaDePagamento_Id"              AS Lanc_FormaDePagamento_Id,
       LC."Colaborador_Id"                   AS Lanc_Colaborador_Id,
       LC."Pago"                             AS Lanc_Pago,
       LC."PlanoDeContaItem_Id"              AS Lanc_PlanoDeContaItem_Id,
       LC."CentroDeCustoItem_Id"             AS Lanc_CentroDeCustoItem_Id,
       LC."Lancamento_Id"                    AS Lanc_Lancamento_Id,
       LC."Recibo"                           AS Lanc_Recibo,
       LC."Nota"                             AS Lanc_Nota,
       LC."CupomFiscal"                      AS Lanc_CupomFiscal,
       LC."ModalidadeDoLancamento_Id"        AS Lanc_ModalidadeDoLancamento_Id,
       LC."IntervaloDeRecorrencia"           AS Lanc_IntervaloDeRecorrencia,
       LC."RecorrenciaEncerrada"             AS Lanc_RecorrenciaEncerrada,
       LC."Observacoes"                      AS Lanc_Observacoes,
       LC."ContaDeOrigem_Id"                 AS Lanc_ContaDeOrigem_Id,
       LC."ContaDeDestino_Id"                AS Lanc_ContaDeDestino_Id,
       LC."Franquia_Id"                      AS Lanc_Franquia_Id,
       LC."OrdemDePagamento_Id"              AS Lanc_OrdemDePagamento_Id,
       LC."NotaFiscalDeServico"              AS Lanc_NotaFiscalDeServico,
       LC."FaturaDeLocacao"                  AS Lanc_FaturaDeLocacao,
       LC."CodigoReferencia"                 AS Lanc_CodigoReferencia,
       LC."MotivoApagado"                    AS Lanc_MotivoApagado,
       LC."SplitPai_Id"                      AS Lanc_SplitPai_Id,
       LC."NaoCobrarTaxas"                   AS Lanc_NaoCobrarTaxas,
       MV."Id"                               AS MV_Id,
       CAST(MV.created_at AS TIMESTAMP(0))   AS MV_Created_At,
       CAST(MV.updated_at AS TIMESTAMP(0))   AS MV_Updated_At,
       CAST(MV.deleted_at AS TIMESTAMP(0))   AS MV_Deleted_At,
       MV."Lancamento_Id"                    AS MV_Lancamento_Id,
       MV."JurosAplicado"                    AS MV_JurosAplicado,
       MV."ValorPago"                        AS MV_ValorPago,
       MV."DataDePagamento"                  AS MV_DataDePagamento,
       MV."Multa"                            AS MV_Multa,
       MV."Desconto"                         AS MV_Desconto,
       MV."ValorHonorario"                   AS MV_ValorHonorario,
       PCI."Id"                              AS PCI_Id,
       CAST(PCI.created_at AS TIMESTAMP(0))  AS PCI_Created_At,
       CAST(PCI.updated_at AS TIMESTAMP(0))  AS PCI_Updated_At,
       CAST(PCI.deleted_at AS TIMESTAMP(0))  AS PCI_Deleted_At,
       PCI."Nome"                            AS PCI_Nome,
       PCI."PlanoDeContas_Id"                AS PCI_PlanoDeContas_Id,
       PCI."Pai_Id"                          AS PCI_Pai_Id,
       PCI."Classificacao"                   AS PCI_Classificacao,
       PC."Id"                               AS PC_Id,
       CAST(PC.created_at AS TIMESTAMP(0))   AS PC_Created_At,
       CAST(PC.updated_at AS TIMESTAMP(0))   AS PC_Updated_At,
       CAST(PC.deleted_at AS TIMESTAMP(0))   AS PC_Deleted_At,
       PC."Nome"                             AS PC_Nome,
       PC."Descricao"                        AS PC_Descricao,
       PC."Franquia_Id"                      AS PC_Franquia_Id,
       FRANQUIA."EmpresaId"                  AS Fran_Pessoa_Id,
       FRANQUIA."PessoaNome"                 AS Fran_Pessoa_Nome,
       FRANQUIA.Empresa                      AS Fran_Empresa,
       LP."Id"                               AS LP_Id,
       CAST(LP.created_at AS TIMESTAMP(0))   AS LP_Created_At,
       CAST(LP.updated_at AS TIMESTAMP(0))   AS LP_Updated_At,
       CAST(LP.deleted_at AS TIMESTAMP(0))   AS LP_Deleted_At,
       LP."Descricao"                        AS LP_Descricao,
       CAST(LP."Vencimento" AS TIMESTAMP(0)) AS LP_Vencimento,
       LP."Valor"                            AS LP_Valor,
       LP."Cliente_Id"                       AS LP_Cliente_Id,
       LP."Fornecedor_Id"                    AS LP_Fornecedor_Id,
       LP."ContaBancaria_Id"                 AS LP_ContaBancaria_Id,
       LP."DataDeCompetencia"                AS LP_DataDeCompetencia,
       LP."Fatura_Id"                        AS LP_Fatura_Id,
       LP."Boleto_Id"                        AS LP_Boleto_Id,
       LP."NFCE_Id"                          AS LP_NFCE_Id,
       LP."NFS_Id"                           AS LP_NFS_Id,
       LP."NumeroReciboPrestador"            AS LP_NumeroReciboPrestador,
       LP."TipoDePagamento_Id"               AS LP_TipoDePagamento_Id,
       LP."TipoDoLancamento_Id"              AS LP_TipoDoLancamento_Id,
       LP."FormaDePagamento_Id"              AS LP_FormaDePagamento_Id,
       LP."Colaborador_Id"                   AS LP_Colaborador_Id,
       LP."Pago"                             AS LP_Pago,
       LP."PlanoDeContaItem_Id"              AS LP_PlanoDeContaItem_Id,
       LP."CentroDeCustoItem_Id"             AS LP_CentroDeCustoItem_Id,
       LP."Lancamento_Id"                    AS LP_Lancamento_Id,
       LP."Recibo"                           AS LP_Recibo,
       LP."Nota"                             AS LP_Nota,
       LP."CupomFiscal"                      AS LP_CupomFiscal,
       LP."ModalidadeDoLancamento_Id"        AS LP_ModalidadeDoLancamento_Id,
       LP."IntervaloDeRecorrencia"           AS LP_IntervaloDeRecorrencia,
       LP."RecorrenciaEncerrada"             AS LP_RecorrenciaEncerrada,
       LP."Observacoes"                      AS LP_Observacoes,
       LP."ContaDeOrigem_Id"                 AS LP_ContaDeOrigem_Id,
       LP."ContaDeDestino_Id"                AS LP_ContaDeDestino_Id,
       LP."Franquia_Id"                      AS LP_Franquia_Id,
       LP."OrdemDePagamento_Id"              AS LP_OrdemDePagamento_Id,
       LP."NotaFiscalDeServico"              AS LP_NotaFiscalDeServico,
       LP."FaturaDeLocacao"                  AS LP_FaturaDeLocacao,
       LP."CodigoReferencia"                 AS LP_CodigoReferencia,
       LP."MotivoApagado"                    AS LP_MotivoApagado,
       LP."SplitPai_Id"                      AS LP_SplitPai_Id,
       LP."NaoCobrarTaxas"                   AS LP_NaoCobrarTaxas
FROM financeiro.lancamentos."Lancamentos" as LC
         left join financeiro.lancamentos."Lancamentos" as LP on LC."Lancamento_Id" = LP."Id"
         left join financeiro.public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
         LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
         LEFT JOIN financeiro.public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
         LEFT JOIN dblink('dbname=identidades',
                          'SELECT Empresas."Id",Pessoas."Nome",Empresas.url from identidades.public."Pessoas" as Pessoas
                              left join identidades.franquias."Empresas" as Empresas on Empresas."Pessoa_Id" = Pessoas."Id"')
    AS FRANQUIA("EmpresaId" uuid, "PessoaNome" text, Empresa text)
                   ON LC."Franquia_Id" = FRANQUIA."EmpresaId"
WHERE LC.deleted_at is NULL;



-- Juntando 1 e 2 

SELECT
    PCI."Nome",
    MV."ValorPago",
    LC."Descricao" as DescricaoFilho,
    LP."Descricao" as DescricaoPai,
    CAST(MV."DataDePagamento" AS TIMESTAMP(0)) as MV_DataDePagamento,
    CAST(LC."Vencimento" AS TIMESTAMP(0))  as lc_Vencimento,
    CAST(LP."Vencimento" AS TIMESTAMP(0))  as lp_Vencimento
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON (LP."PlanoDeContaItem_Id" = PCI."Id" OR LC."PlanoDeContaItem_Id" = PCI."Id")
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."Vencimento" >= ('2023-06-01'::timestamptz) AND LC."Vencimento" <= ('2023-06-30'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'despesa'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = TRUE
    AND ((LC."Lancamento_Id" IS NOT NULL AND LC."ModalidadeDoLancamento_Id" = 'recorrente')
         OR (LC."Lancamento_Id" IS NULL AND (LC."ModalidadeDoLancamento_Id" <> 'recorrente' AND LC."TipoDoLancamento_Id" <> 'transferencia')));

-- Juntando 3 e 4

SELECT
    PCI."Nome",
    MV."ValorPago",
    LC."Descricao" as DescricaoFilho,
    LP."Descricao" as DescricaoPai,
    MV."DataDePagamento" as MV_DataDePagamento,
    LC."Vencimento" as lc_Vencimento,
    LP."Vencimento" as lp_Vencimento
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."Vencimento" >= ('2023-06-01'::timestamptz) AND LC."Vencimento" <= ('2023-06-30'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = TRUE
    AND LC."Lancamento_Id" IS NOT NULL
    AND LC."ModalidadeDoLancamento_Id" = 'recorrente'

UNION ALL
SELECT
    PCI."Nome",
    MV."ValorPago",
    LC."Descricao" as DescricaoFilho,
    LP."Descricao" as DescricaoPai,
    MV."DataDePagamento" as MV_DataDePagamento,
    LC."Vencimento" as lc_Vencimento,
    LP."Vencimento" as lp_Vencimento
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."Vencimento" >= ('2023-06-01'::timestamptz) AND LC."Vencimento" <= ('2023-06-30'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Pago" = TRUE
    AND LC."Lancamento_Id" IS NULL
    AND LC."ModalidadeDoLancamento_Id" <> 'recorrente'
    AND LC."TipoDoLancamento_Id" <> 'transferencia';


-- Dia 5 de setembro, estamos tentando trazer consultas para o data studio novamente : (

SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
 --   LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-06-30'::timestamptz) AND LC."DataDeCompetencia" < ('2023-08-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Lancamento_Id" IS NOT NULL
    AND LC."ModalidadeDoLancamento_Id" = 'recorrente'
group by PCI."Nome"

UNION ALL

SELECT
    PCI."Nome",
    (sum(LC."Valor")/100) as "Valor Total"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
 --   LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-06-30'::timestamptz) AND LC."DataDeCompetencia" < ('2023-08-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Lancamento_Id" IS NULL
    AND LC."ModalidadeDoLancamento_Id" <> 'recorrente'
    AND LC."TipoDoLancamento_Id" <> 'transferencia'
--     AND (MV."DataDePagamento" > LC."Vencimento" AND MV."DataDePagamento" >= ('2023-07-25'::timestamptz))
group by PCI."Nome";



SELECT
    PCI."Nome",
--    (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-06-30'::timestamptz) AND LC."DataDeCompetencia" < ('2023-08-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Lancamento_Id" IS NOT NULL
    AND LC."ModalidadeDoLancamento_Id" = 'recorrente'
--     AND (MV."DataDePagamento" > LC."Vencimento" AND MV."DataDePagamento" >= ('2023-07-25'::timestamptz))
group by PCI."Nome"

UNION ALL

SELECT
    PCI."Nome",
 --   (sum(LC."Valor")/100) as "Valor Total",
    (sum(MV."ValorPago")/100) as "Valor Pago",
    (sum(MV."JurosAplicado")/100) as "Juros",
    (sum(MV."Multa")/100) as "Multa",
    (sum(MV."ValorHonorario")/100) as "Honorários",
    (sum(MV."Desconto")/100) as "Desconto"
FROM
    financeiro.lancamentos."Lancamentos" AS LC
    LEFT JOIN financeiro.lancamentos."Lancamentos" AS LP ON LC."Lancamento_Id" = LP."Id"
    LEFT JOIN financeiro.public."Movimentacoes" AS MV ON MV."Lancamento_Id" = LC."Id"
    LEFT JOIN financeiro.public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN financeiro.public."PlanoDeContas" AS PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND (LC."DataDeCompetencia" > ('2023-06-30'::timestamptz) AND LC."DataDeCompetencia" < ('2023-08-01'::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND LC.deleted_at IS NULL
    AND LC."Lancamento_Id" IS NULL
    AND LC."ModalidadeDoLancamento_Id" <> 'recorrente'
    AND LC."TipoDoLancamento_Id" <> 'transferencia'
--     AND (MV."DataDePagamento" > LC."Vencimento" AND MV."DataDePagamento" >= ('2023-07-25'::timestamptz))
group by PCI."Nome";
