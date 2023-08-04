SELECT "Cliente_Id", CL.Nome FROM financeiro.lancamentos."Lancamentos" LC
        LEFT JOIN
        dblink('dbname=identidades','SELECT CLIENTES."Id", "Nome" FROM identidades.pessoas."Clientes" AS CLIENTES LEFT JOIN identidades.public."Pessoas" ON Clientes."Pessoa_Id" = "Pessoas"."Id"')
            AS CL ("Id" uuid, Nome text)
            ON LC."Cliente_Id" = CL."Id";


SELECT TECNICOS."Id", PESSOAS."Nome" FROM identidades.pessoas."Tecnicos" AS TECNICOS
            LEFT JOIN identidades.public."Pessoas" AS PESSOAS
            ON TECNICOS."Pessoa_Id" = PESSOAS."Id";


SELECT * FROM erprastreamento.ordemdeservico."OrdemDeServico" AS OS
    LEFT JOIN erprastreamento.ordemdeservicoagendamentos."Agendamentos" AS AG ON OS."Id" = AG."Id"
    LEFT JOIN dblink('dbname=identidades',
        'SELECT TECNICOS."Id", PESSOAS."Nome" FROM identidades.pessoas."Tecnicos" AS TECNICOS
            LEFT JOIN identidades.public."Pessoas" AS PESSOAS
            ON TECNICOS."Pessoa_Id" = PESSOAS."Id"'
    ) as TEC ("Id" uuid, "Nome" text)
        ON TEC."Id" = AG."Tecnico_Id";


SELECT
    TEC."Id",
    TEC."Nome",
    AG."OS_Id",
    OS."Id"
FROM
    erprastreamento.ordemdeservico."OrdemDeServico" AS OS
    LEFT JOIN erprastreamento.ordemdeservicoagendamentos. "Agendamentos" AS AG ON OS."Id" = AG."Id"
    LEFT JOIN dblink('dbname=identidades', 'SELECT TECNICOS."Id", PESSOAS."Nome" FROM identidades.pessoas."Tecnicos" AS TECNICOS
            LEFT JOIN identidades.public."Pessoas" AS PESSOAS
            ON TECNICOS."Pessoa_Id" = PESSOAS."Id"') AS TEC ("Id" uuid, "Nome" text)
        ON TEC."Id" = AG."Tecnico_Id";



