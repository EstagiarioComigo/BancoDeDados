SELECT "Cliente_Id", CL.Nome FROM financeiro.lancamentos."Lancamentos" LC
        LEFT JOIN
        dblink('dbname=identidades','SELECT CLIENTES."Id", "Nome" FROM identidades.pessoas."Clientes" AS CLIENTES LEFT JOIN identidades.public."Pessoas" ON Clientes."Pessoa_Id" = "Pessoas"."Id"')
            AS CL ("Id" uuid, Nome text)
            ON LC."Cliente_Id" = CL."Id";