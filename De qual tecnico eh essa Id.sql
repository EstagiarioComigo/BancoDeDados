select * from identidades.public."Pessoas" as Pessoas
   left join identidades.pessoas."Colaboradores" as Colaboradores on Colaboradores."Pessoa_Id"= Pessoas."Id"
         left join identidades.pessoas."Tecnicos" as Tecnicos on Tecnicos."TipoPessoa_Id"=Colaboradores."Id"
   where Tecnicos."Id"='b9a77824-d64c-491f-a95a-071d7f7cf9de';