import requests
import json
import pandas as pd
import psycopg2

# Função para conectar ao banco de dados
def conectar_db():
    conexao = psycopg2.connect(database='meufinanceiro',
                               host='localhost',
                               user='postgres',
                               password='postgrespassword',
                               port='5401')  # Porta do PostgreSQL
    return conexao

# Função para consultas no banco de dados e contar registros
def consultar_db(sql):
    con = conectar_db()
    cur = con.cursor()
    cur.execute(sql)
    recset = cur.fetchall()
    registros = []
    for rec in recset:
        registros.append(rec)
    con.close()
    return registros

# Função para criar tabela no banco
def criar_db(sql):
    con = conectar_db()
    cur = con.cursor()
    cur.execute(sql)
    con.commit()
    con.close()

# Função para inserir dados no banco
def inserir_db(sql):
    con = conectar_db()
    cur = con.cursor()
    try: 
        cur.execute(sql)
        con.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print("Error: %s" % error)
        con.rollback()
        cur.close()
        return 1
    cur.close()

# Dropando a tabela caso ela já exista
sql = 'DROP TABLE IF EXISTS public.lancamentos'
criar_db(sql)

# Criando a tabela dos Lancamentos
sql = '''CREATE TABLE public.lancamentos (
    id serial PRIMARY KEY,
    ValorPago NUMERIC(10, 2)
)'''
criar_db(sql)

# Inserindo dados na tabela
inserir_db("INSERT INTO public.lancamentos (ValorPago) VALUES (100.50)")
inserir_db("INSERT INTO public.lancamentos (ValorPago) VALUES (200.75)")

# Realizando a consulta no PostgreSQL
sql = 'SELECT * FROM public.lancamentos'
registros = consultar_db(sql)

# Transformando os dados da consulta em um DataFrame
df_bd = pd.DataFrame(registros, columns=['id', 'ValorPago'])

# Imprimindo o DataFrame
print(df_bd.head())

# Imprimindo cada registro em um laço for 
# Iterando pelo DataFrame e imprimindo os valores
for i, row in df_bd.iterrows():
    print(f"ID: {row['id']}, ValorPago: {row['ValorPago']}")
