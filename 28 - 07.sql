-- Dia 28/07
-- Por centro de custo
SELECT
    CCI."Nome",
    (sum(MV."ValorPago")/100) as SomaValor
FROM
    lancamentos."Lancamentos" as LC
    left join public."Movimentacoes" as MV on MV."Lancamento_Id" = LC."Id"
    LEFT JOIN public."CentroDeCustos_Itens" AS CCI ON CCI."Id"= LC."CentroDeCustoItem_Id"
    LEFT JOIN public."CentroDeCustos" as CC ON CCI."CentroDeCustos_Id" = CC."Id"
WHERE
    LC."Franquia_Id"='c07e66d4-e4c2-4444-a047-e2952adcf663'
    AND CC."Id" = 'b1460dbd-5054-415a-a55d-f116d705d7ef'
    AND LC."TipoDoLancamento_Id" = 'despesa'
    AND (LC."Vencimento" >= (('2023/06/01')::timestamptz) AND LC."Vencimento" < (('2023/07/01')::timestamptz))
GROUP BY
    CCI."Nome";

-- Por plano de contas de despesa
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
    AND (LC."Vencimento" >= (('2023/06/01')::timestamptz) AND LC."Vencimento" <= (('2023/06/30')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'despesa'
group by PCI."Nome";


-- Por plano de contas de receita
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
    AND (LC."Vencimento" >= (('2023/06/01')::timestamptz) AND LC."Vencimento" <= (('2023/06/30')::timestamptz))
    AND LC."TipoDoLancamento_Id" = 'receita'
group by PCI."Nome";