import psycopg2

conexao = psycopg2.connect(database = 'financeiro',
                           host='18.215.83.195',
                           user = "postgres",
                           password = "postgrespassword",
                           port = "5401")

# print(conexao.info)
# print(conexao.status)

cursor = conexao.cursor()
cursor.execute('SELECT * FROM financeiro.lancamentos."Lancamentos" as LC;')
resultado = cursor.fetchall()

for linha in resultado:
    lancamento_id = linha[0]  # Suponha que o primeiro campo seja o ID do lançamento
    consulta_sql = f"""
        SELECT *
        FROM financeiro.public."Movimentacoes" AS MV
        WHERE MV."Lancamento_Id" = '{lancamento_id}'
    """
    cursor.execute(consulta_sql)
    movimentacoes = cursor.fetchall()

    if len(movimentacoes)>1:  # Verifica se há movimentações para o lançamento
        print(f"Multiplas Movimentações do lançamento: {lancamento_id}")

cursor.close()
conexao.close()