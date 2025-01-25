cIP = "186.202.152.106"           && IP do servidor MySQL
cUsuario = "ornatustst"           && Nome de usuário do banco de dados
cSenha = "Orn@170621"             && Senha do banco de dados
cBanco = "ornatustst"     && Nome do banco de dados que deseja acessar (substitua pelo real)

* Estabelece a conexão usando ODBC sem DSN (conexão DSN-less)
nConnHandle = SQLSTRINGCONNECT("Driver={MySQL ODBC 8.0 Unicode Driver};Server=" + cIP + ";UID=" + cUsuario + ";PWD=" + cSenha + ";DATABASE=" + cBanco + ";")

* Verifica se a conexão foi bem-sucedida
IF nConnHandle > 0
    MESSAGEBOX("Conexão bem-sucedida!")
    
    * Exemplo de consulta
    cSQL = "SELECT * FROM vip_clientes LIMIT 10"  && Substitua "sua_tabela" pela tabela desejada
    nResult = SQLEXEC(nConnHandle, cSQL, "ResultadoCursor")

    IF nResult > 0
        BROWSE && Mostra os dados no Visual FoxPro
    ELSE
        MESSAGEBOX("Erro na execução da consulta.")
    ENDIF
ELSE
    MESSAGEBOX("Falha ao conectar com o banco de dados.")
ENDIF

* Fecha a conexão (sempre finalize a conexão após o uso)
SQLDISCONNECT(nConnHandle)
