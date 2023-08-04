-- Consulta de gilvan
SELECT
    gen_random_uuid (),-- Cada vez que você executar essa consulta, um novo UUID exclusivo será gerado.
    (
        SELECT
            (SUM("M"."ValorPago") / 100) AS "Total De Maio"
        FROM
            lancamentos."Lancamentos" AS "L"
        LEFT JOIN financeiro.public. "Movimentacoes" AS "M" ON "M"."Lancamento_Id" = "L"."Id"
    WHERE
        "L"."TipoDoLancamento_Id" = 'receita'
        AND "L"."Franquia_Id" = '70791887-a5c9-41ec-9dd1-fd56c5eb2f81'
        AND "L"."deleted_at" IS NULL
        AND "L"."Pago" = TRUE
        AND ("L"."Vencimento" >= (('2023/06/01')::timestamptz)
            AND "L"."Vencimento" <= (('2023/06/30')::timestamptz))
        AND (("L"."Lancamento_Id" IS NOT NULL
                AND "L"."ModalidadeDoLancamento_Id" = 'recorrente')
            OR ("L"."Lancamento_Id" IS NULL
                AND ("L"."ModalidadeDoLancamento_Id" <> 'recorrente'
                    AND "L"."TipoDoLancamento_Id" <> 'transferencia')))) AS "Receitas",
(
    SELECT
        (SUM("M"."ValorPago") / 100) AS "Total De Maio"
    FROM
        lancamentos."Lancamentos" AS "L"
    LEFT JOIN financeiro.public. "Movimentacoes" AS "M" ON "M"."Lancamento_Id" = "L"."Id"
WHERE
    "L"."TipoDoLancamento_Id" = 'despesa'
    AND "L"."Franquia_Id" = '70791887-a5c9-41ec-9dd1-fd56c5eb2f81'
    AND "L"."deleted_at" IS NULL
    AND "L"."Pago" = TRUE
    AND ("L"."Vencimento" >= (('2023/06/01')::timestamptz)
        AND "L"."Vencimento" <= (('2023/06/30')::timestamptz))
    AND (("L"."Lancamento_Id" IS NOT NULL
            AND "L"."ModalidadeDoLancamento_Id" = 'recorrente')
        OR ("L"."Lancamento_Id" IS NULL
            AND ("L"."ModalidadeDoLancamento_Id" <> 'recorrente'
                AND "L"."TipoDoLancamento_Id" <> 'transferencia')))) AS "Despesas";

SELECT
    "Id" as PlanoDeContaId,
    "Nome" as PlanoDeContaNome,
    "Franquia_Id" as PlanoDeContaFranquia,
    (
        SELECT
            SUM(CASE WHEN "L"."TipoDoLancamento_Id" = 'receita' THEN "M"."ValorPago" ELSE 0 END) / 100
        FROM
            lancamentos."Lancamentos" AS "L"
        LEFT JOIN financeiro.public."Movimentacoes" AS "M" ON "M"."Lancamento_Id" = "L"."Id"
        WHERE
            "L"."Franquia_Id" = '70791887-a5c9-41ec-9dd1-fd56c5eb2f81'
            AND "L"."deleted_at" IS NULL
            AND "L"."Pago" = TRUE
            AND ("L"."Vencimento" >= (('2023/06/01')::timestamptz)
                AND "L"."Vencimento" <= (('2023/06/30')::timestamptz))
            AND (("L"."Lancamento_Id" IS NOT NULL
                    AND "L"."ModalidadeDoLancamento_Id" = 'recorrente')
                OR ("L"."Lancamento_Id" IS NULL
                    AND ("L"."ModalidadeDoLancamento_Id" <> 'recorrente'
                        AND "L"."TipoDoLancamento_Id" <> 'transferencia')))
    ) AS "Receitas",
    (
        SELECT
            SUM(CASE WHEN "L"."TipoDoLancamento_Id" = 'despesa' THEN "M"."ValorPago" ELSE 0 END) / 100
        FROM
            lancamentos."Lancamentos" AS "L"
        LEFT JOIN financeiro.public."Movimentacoes" AS "M" ON "M"."Lancamento_Id" = "L"."Id"
        WHERE
            "L"."Franquia_Id" = '70791887-a5c9-41ec-9dd1-fd56c5eb2f81'
            AND "L"."deleted_at" IS NULL
            AND "L"."Pago" = TRUE
            AND ("L"."Vencimento" >= (('2023/06/01')::timestamptz)
                AND "L"."Vencimento" <= (('2023/06/30')::timestamptz))
            AND (("L"."Lancamento_Id" IS NOT NULL
                    AND "L"."ModalidadeDoLancamento_Id" = 'recorrente')
                OR ("L"."Lancamento_Id" IS NULL
                    AND ("L"."ModalidadeDoLancamento_Id" <> 'recorrente'
                        AND "L"."TipoDoLancamento_Id" <> 'transferencia')))
    ) AS "Despesas"
FROM
    public."PlanoDeContas"
GROUP BY
    "Id",
    "Nome",
    "Franquia_Id";


SELECT
    public."CentroDeCustos"."Id" as CentroDeCustosId,
    public."CentroDeCustos"."Nome"  as CentroDeCustosNome,
    public."CentroDeCustos"."Franquia_Id" as CentroDeCustosFranquia,

    (
        SELECT
            SUM(CASE WHEN "L"."TipoDoLancamento_Id" = 'receita' THEN "M"."ValorPago" ELSE 0 END) / 100
        FROM
            lancamentos."Lancamentos" AS "L"
        LEFT JOIN financeiro.public."Movimentacoes" AS "M" ON "M"."Lancamento_Id" = "L"."Id"
        WHERE
            "L"."Franquia_Id" = '70791887-a5c9-41ec-9dd1-fd56c5eb2f81'
            AND "L"."deleted_at" IS NULL
            AND "L"."Pago" = TRUE
            AND ("L"."Vencimento" >= (('2023/06/01')::timestamptz)
                AND "L"."Vencimento" <= (('2023/06/30')::timestamptz))
            AND (("L"."Lancamento_Id" IS NOT NULL
                    AND "L"."ModalidadeDoLancamento_Id" = 'recorrente')
                OR ("L"."Lancamento_Id" IS NULL
                    AND ("L"."ModalidadeDoLancamento_Id" <> 'recorrente'
                        AND "L"."TipoDoLancamento_Id" <> 'transferencia')))
    ) AS "Receitas",
    (
        SELECT
            SUM(CASE WHEN "L"."TipoDoLancamento_Id" = 'despesa' THEN "M"."ValorPago" ELSE 0 END) / 100
        FROM
            lancamentos."Lancamentos" AS "L"
        LEFT JOIN financeiro.public."Movimentacoes" AS "M" ON "M"."Lancamento_Id" = "L"."Id"
        WHERE
            "L"."Franquia_Id" = '70791887-a5c9-41ec-9dd1-fd56c5eb2f81'
            AND "L"."deleted_at" IS NULL
            AND "L"."Pago" = TRUE
            AND ("L"."Vencimento" >= (('2023/06/01')::timestamptz)
                AND "L"."Vencimento" <= (('2023/06/30')::timestamptz))
            AND (("L"."Lancamento_Id" IS NOT NULL
                    AND "L"."ModalidadeDoLancamento_Id" = 'recorrente')
                OR ("L"."Lancamento_Id" IS NULL
                    AND ("L"."ModalidadeDoLancamento_Id" <> 'recorrente'
                        AND "L"."TipoDoLancamento_Id" <> 'transferencia')))
    ) AS "Despesas"
FROM
    public."CentroDeCustos"
GROUP BY
    "Id",
    "Nome",
    "Franquia_Id";

 --select * from identidades.franquias."Empresas"; usamos essa parte aqui para ver as URLs

SELECT
    "Lancamentos"."Id",
    "Lancamentos"."Valor",
    "Lancamentos"."ModalidadeDoLancamento_Id",
    "Lancamentos"."TipoDoLancamento_Id",
    "Lancamentos"."Descricao",
    CCI."Nome",
    "CentroDeCustos"."Franquia_Id",
    "CentroDeCustos"."Nome"
FROM
    lancamentos."Lancamentos"
    LEFT JOIN public."CentroDeCustos_Itens" AS CCI ON "Lancamentos"."CentroDeCustoItem_Id" = CCI."Id"
    LEFT JOIN public."CentroDeCustos" ON CCI."CentroDeCustos_Id" = public."CentroDeCustos"."Id"
WHERE
    "CentroDeCustos"."Id" = 'b1460dbd-5054-415a-a55d-f116d705d7ef'
    AND "Lancamentos"."TipoDoLancamento_Id" = 'despesa'
GROUP BY
    "Lancamentos"."Id",
    "Lancamentos"."Valor",
    "Lancamentos"."ModalidadeDoLancamento_Id",
    "Lancamentos"."TipoDoLancamento_Id",
    "Lancamentos"."Descricao",
    CCI."Nome",
    "CentroDeCustos"."Franquia_Id",
    "CentroDeCustos"."Nome";

-- Por Plano de Contas das despesas
SELECT
    PCI."Nome",
    LC."Valor",
    (sum(MV."ValorPago")/100) as SomaValor
FROM
    lancamentos."Lancamentos" as LC
    left join public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id"='c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND PC."Id" = '707c6484-dacd-43c9-adea-7d3045e32843'
    AND (LC."Vencimento" >= (('2023/01/01')::timestamptz) AND LC."Vencimento" <= (('2023/01/31')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'despesa'
group by PCI."Nome",LC."Valor";

SELECT
    PCI."Nome",
    LC."Valor",
    (sum(MV."ValorPago")/100) as SomaValor
FROM
    lancamentos."Lancamentos" as LC
    left join public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id"='c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND PC."Id" = '707c6484-dacd-43c9-adea-7d3045e32843'
    AND (LC."Vencimento" >= (('2023/06/01')::timestamptz) AND LC."Vencimento" <= (('2023/06/30')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'despesa'
group by PCI."Nome",LC."Valor";

-- Por Plano de Contas das receitas
SELECT
    PCI."Nome",

    (sum(MV."ValorPago")/100) as SomaValor
FROM
    lancamentos."Lancamentos" as LC
    left join public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    LC."Franquia_Id"='c07e66d4-e4c2-4444-a047-e2952adcf663'
--    AND PC."Id" = '707c6484-dacd-43c9-adea-7d3045e32843'
    AND (LC."Vencimento" >= (('2023/05/01')::timestamptz) AND LC."Vencimento" <= (('2023/05/31')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
group by PCI."Nome";



-- Buscando pela ID
SELECT *
FROM
    lancamentos."Lancamentos" as LC
    left join public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    PC."Id" = '707c6484-dacd-43c9-adea-7d3045e32843'
    AND LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND LC."TipoDoLancamento_Id" = 'receita'
    AND "Vencimento" BETWEEN '2023-01-01' AND '2023-01-31 03:00:00.000000 +00:00';

SELECT *
FROM
    lancamentos."Lancamentos" as LC
    left join public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    PC."Id" = '707c6484-dacd-43c9-adea-7d3045e32843'
    and LC."Franquia_Id" = 'c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND LC."TipoDoLancamento_Id" = 'despesa'
    AND "Vencimento" BETWEEN '2023-06-01' AND '2023-06-30 03:00:00.000000 +00:00';

-- Manualmente ID do plano de contas e buscar todos os itens na outra tabela
SELECT *
FROM
    public."PlanoDeContas_Itens" as PCI
    left join public."PlanoDeContas" as PC on PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    PC."Id" = '707c6484-dacd-43c9-adea-7d3045e32843';

SELECT *
FROM
    public."PlanoDeContas_Itens" as PCI
    left join public."PlanoDeContas" as PC on PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    PCI."Pai_Id" = '9a8a42d9-99c5-4141-a3d0-ffb18aba7cd2';


SELECT
    (SUM(LC."Valor")/100)
FROM
    lancamentos."Lancamentos" as LC
    left join public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN public."PlanoDeContas_Itens" AS PCI ON LC."PlanoDeContaItem_Id" = PCI."Id"
    LEFT JOIN public."PlanoDeContas" as PC ON PCI."PlanoDeContas_Id" = PC."Id"
WHERE
    PCI."Pai_Id"='72ab5da6-7276-46b7-9224-03ef3094a907';



-- Por centro de custo
SELECT
    CCI."Nome",
    (sum("Lancamentos"."Valor")/100) as SomaValor
FROM
    lancamentos."Lancamentos"
    LEFT JOIN public."CentroDeCustos_Itens" AS CCI ON "Lancamentos"."CentroDeCustoItem_Id" = CCI."Id"
    LEFT JOIN public."CentroDeCustos" ON CCI."CentroDeCustos_Id" = public."CentroDeCustos"."Id"
WHERE
    "Lancamentos"."Franquia_Id"='c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND "CentroDeCustos"."Id" = 'b1460dbd-5054-415a-a55d-f116d705d7ef'
    AND "Lancamentos"."TipoDoLancamento_Id" = 'despesa'
    AND ("Lancamentos"."Vencimento" >= (('2023/05/01')::timestamptz) AND "Lancamentos"."Vencimento" <= (('2023/05/31')::timestamptz))
GROUP BY
    CCI."Nome";
