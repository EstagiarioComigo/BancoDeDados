--Filtrando por data
select * from lancamentos."Lancamentos"
WHERE
    "TipoDoLancamento_Id"='receita'
    AND "Vencimento" >= '2023-02-01'
    AND "Vencimento" <= '2023-02-28'
    and deleted_at is null;
--Assim vai dar errado por causa do formato da data(962 resultados) use o between

-- Usar o Between
select * from lancamentos."Lancamentos"
WHERE
    lancamentos."Lancamentos"."Id"='1b3e4b2b-d894-457e-930f-2147de328ae5'
    AND "Vencimento" BETWEEN '2023-02-01' AND '2023-02-28 03:00:00.000000 +00:00';

select (SUM(lancamentos."Lancamentos"."Valor")/100) from lancamentos."Lancamentos"
WHERE
    "TipoDoLancamento_Id"='receita'
    AND "Vencimento" BETWEEN '2023-02-01' AND '2023-02-28 03:00:00.000000 +00:00';

select * from lancamentos."Lancamentos"
WHERE
    "TipoDoLancamento_Id"='receita'
    AND "Vencimento" BETWEEN '2023-02-01' AND '2023-02-28 03:00:00.000000 +00:00';

select (SUM(lancamentos."Lancamentos"."Valor")/100) from lancamentos."Lancamentos"
WHERE
    "TipoDoLancamento_Id"='despesa'
    AND "Vencimento" BETWEEN '2023-02-01' AND '2023-02-28 03:00:00.000000 +00:00';