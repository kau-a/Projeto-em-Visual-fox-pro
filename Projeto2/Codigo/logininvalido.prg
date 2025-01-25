* PRG para controle de erros de login

PARAMETERS cCpf, cSenha, qntacesso

lcCheckCpf = "SELECT Id_cliente FROM vip_clientes WHERE Cpf = '" + cCpf + "'"
lnResultadoCheck = SQLEXEC(nConnHandle, lcCheckCpf, "ResultadoCpf")

IF lnResultadoCheck < 0 OR EMPTY(ResultadoCpf.Id_cliente)
    MESSAGEBOX("CPF n�o encontrado ou inv�lido.")
    RETURN
ENDIF

lcClienteId = ResultadoCpf.Id_cliente

lcMotivoBloqueio = "Tentativa de login invalida. " + TRANSFORM(qntacesso) + " tentativa(s) restante(s)."

IF qntacesso <= 0
    lcMotivoBloqueio = "BLOQUEADO"
ENDIF

IF qntacesso <= 3
    MESSAGEBOX(+ TRANSFORM(qntacesso) + " Tentativas restantes, em caso de utiliza��o de todas as tentativas o usu�rio ser� bloqueado. ")
ENDIF

lcSqlInsert = ;
    "INSERT INTO vip_movcli (Id_cliente, Local, Dthrent, Dthrsai, Idstatus, Motbloqueio, Obsacesso) " + ;
    "VALUES (" + ;
        TRANSFORM(lcClienteId) + ", " + ;
        "'Login', NULL, NULL, -1, " + ;
        "'" + STRTRAN(lcMotivoBloqueio, "'", "''") + "', " + ;
        "'Tentativa de login invalida')"

lnResultadoInsert = SQLEXEC(nConnHandle, lcSqlInsert)

IF lnResultadoInsert < 0
    MESSAGEBOX("Erro ao registrar tentativa de login. C�digo de erro: " + TRANSFORM(lnResultadoInsert))
    RETURN
ENDIF



RETURN

