
Select SUM(lancamentos."Lancamentos"."Valor")as SomaDasDespesas from lancamentos."Lancamentos" where lancamentos."Lancamentos"."TipoDoLancamento_Id"='despesa';

Select * from lancamentos."Lancamentos";

-- Primeiro registro no banco de dados(usando o created at)
Select * from lancamentos."Lancamentos" order by created_at asc limit 1;
select * from lancamentos."Lancamentos" order by "created_at" asc fetch first 10 rows only;

-- Lançamento mais antigo no banco de dados(o correto é usar o campo vencimento)
Select * from lancamentos."Lancamentos";
select * from lancamentos."Lancamentos" order by "Vencimento" asc fetch first 5 rows only;


-- left join com 3 tabelas
select "Lancamentos"."Descricao",CCI."Nome","CentroDeCustos"."Nome","Lancamentos"."Valor","Movimentacoes"."ValorPago",public."Movimentacoes"."DataDePagamento" from lancamentos."Lancamentos"
    left join public."CentroDeCustos_Itens" as CCI
        on "Lancamentos"."CentroDeCustoItem_Id" = CCI."Id"
    left join public."CentroDeCustos"
        on CCI."CentroDeCustos_Id" = public."CentroDeCustos"."Id"
    left join public."Movimentacoes"
        on public."Movimentacoes"."Lancamento_Id"="Lancamentos"."Id";