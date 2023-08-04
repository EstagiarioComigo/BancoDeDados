-- Receitas e despesas de cada mês manual
SELECT
    SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'despesa' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END) AS SomaDespesasJaneiro,
    SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'receita' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END) AS SomaReceitasJaneiro
FROM
    lancamentos."Lancamentos"
WHERE
    "Vencimento" >= '2023-01-01'::date
    AND "Vencimento" <= '2023-01-31'::date;

SELECT
    SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'despesa' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END) AS SomaDespesasFevereiro,
    SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'receita' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END) AS SomaReceitasFevereiro
FROM
    lancamentos."Lancamentos"
WHERE
    "Vencimento" >= '2023-02-01'::date
    AND "Vencimento" <= '2023-02-28'::date;

SELECT
    SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'despesa' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END) AS SomaDespesasMarço,
    SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'receita' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END) AS SomaReceitasMarço
FROM
    lancamentos."Lancamentos"
WHERE
    "Vencimento" >= '2023-03-01'::date
    AND "Vencimento" <= '2023-03-31'::date;

SELECT
    SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'despesa' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END) AS SomaDespesasAbril,
    SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'receita' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END) AS SomaReceitasAbril
FROM
    lancamentos."Lancamentos"
WHERE
    "Vencimento" >= '2023-04-01'::date
    AND "Vencimento" <= '2023-04-30'::date;

SELECT
    SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'despesa' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END) AS SomaDespesasMaio,
    SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'receita' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END) AS SomaReceitasMaio
FROM
    lancamentos."Lancamentos"
WHERE
    "Vencimento" >= '2023-05-01'::date
    AND "Vencimento" <= '2023-05-31'::date;

SELECT
    SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'despesa' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END) AS SomaDespesasJunho,
    SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'receita' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END) AS SomaReceitasJunho
FROM
    lancamentos."Lancamentos"
WHERE
    "Vencimento" >= '2023-06-01'::date
    AND "Vencimento" <= '2023-06-30'::date;
-- //////////////////////////////////////////////////////

-- Receitas e despesas de cada mes inteligente
SELECT
    EXTRACT(MONTH FROM "Vencimento") AS Mes,
    (SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'despesa' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END)/100) AS SomaDespesas,
    (SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'receita' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END)/100 )AS SomaReceitas
FROM
    lancamentos."Lancamentos"
WHERE
    EXTRACT(YEAR FROM "Vencimento") = 2023
    and "Franquia_Id"='c07e66d4-e4c2-4444-a047-e2952adcf663'
GROUP BY
    EXTRACT(MONTH FROM "Vencimento")
ORDER BY
    EXTRACT(MONTH FROM "Vencimento");

SELECT
    EXTRACT(MONTH FROM "Vencimento") AS Mes,
    (SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'despesa' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END)/100) AS SomaDespesas,
    (SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'receita' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END)/100 )AS SomaReceitas
FROM
    lancamentos."Lancamentos"
WHERE
    EXTRACT(YEAR FROM "Vencimento") = 2022
GROUP BY
    EXTRACT(MONTH FROM "Vencimento")
ORDER BY
    EXTRACT(MONTH FROM "Vencimento");

SELECT
    EXTRACT(MONTH FROM "Vencimento") AS Mes,
    (SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'despesa' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END)/100) AS SomaDespesas,
    (SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'receita' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END)/100 )AS SomaReceitas
FROM
    lancamentos."Lancamentos"
WHERE
    EXTRACT(YEAR FROM "Vencimento") = 2021
GROUP BY
    EXTRACT(MONTH FROM "Vencimento")
ORDER BY
    EXTRACT(MONTH FROM "Vencimento");

SELECT
    EXTRACT(MONTH FROM "Vencimento") AS Mes,
    (SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'despesa' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END)/100) AS SomaDespesas,
    (SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'receita' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END)/100 )AS SomaReceitas
FROM
    lancamentos."Lancamentos"
WHERE
    EXTRACT(YEAR FROM "Vencimento") = 2020
GROUP BY
    EXTRACT(MONTH FROM "Vencimento")
ORDER BY
    EXTRACT(MONTH FROM "Vencimento");

SELECT
    EXTRACT(MONTH FROM "Vencimento") AS Mes,
    (SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'despesa' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END)/100) AS SomaDespesas,
    (SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'receita' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END)/100 )AS SomaReceitas
FROM
    lancamentos."Lancamentos"
WHERE
    EXTRACT(YEAR FROM "Vencimento") = 2019
GROUP BY
    EXTRACT(MONTH FROM "Vencimento")
ORDER BY
    EXTRACT(MONTH FROM "Vencimento");

SELECT
    EXTRACT(MONTH FROM "Vencimento") AS Mes,
    (SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'despesa' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END)/100) AS SomaDespesas,
    (SUM(CASE WHEN lancamentos."Lancamentos"."TipoDoLancamento_Id" = 'receita' THEN lancamentos."Lancamentos"."Valor" ELSE 0 END)/100 )AS SomaReceitas
FROM
    lancamentos."Lancamentos"
WHERE
    EXTRACT(YEAR FROM "Vencimento") = 2018
GROUP BY
    EXTRACT(MONTH FROM "Vencimento")
ORDER BY
    EXTRACT(MONTH FROM "Vencimento");