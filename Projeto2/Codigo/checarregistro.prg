PARAMETERS cCpf, cSenha, cSql, nResult, cNome, cFoto, randomNum, lcClienteId, lcStatus, lcMotivoBloqueio, lcObsAcesso

lccheckid = "SELECT Id_cliente, Dtnasc FROM vip_clientes WHERE Cpf = " + cCpf + ""
lnResultadoCheck = SQLEXEC(nConnHandle, lccheckid, "resultadoID")

lcClienteId = resultadoID.id_cliente

lcCheckSql = "SELECT dthrent, dthrsai FROM vip_movcli WHERE Id_cliente = " + TRANSFORM(lcClienteId) + " ORDER BY Idmov DESC"
lnResultadoCheck = SQLEXEC(nConnHandle, lcCheckSql, "ResultadoCheck")

IF lnResultadoCheck < 0
    MESSAGEBOX("Erro ao verificar registros existentes. C�digo de erro: " + TRANSFORM(lnResultadoCheck))
    RETURN
ENDIF

IF RECCOUNT("ResultadoCheck") > 0
    SELECT ResultadoCheck
    
    cDthRent = IIF(ISNULL(dthrent), "", dthrent)
    cDthRSai = IIF(ISNULL(dthrsai), "", dthrsai)
  
    IF !EMPTY(cDthRent) AND EMPTY(cDthRSai)
        MESSAGEBOX("Registro encontrado com acesso ativo. Abrindo formul�rio para registrar sa�da.")
        
        cSql = "SELECT id_cliente, nome, foto, HrIniAcesso, HrFimAcesso FROM vip_clientes WHERE cpf = '"+cCpf+"' AND senha = '"+cSenha+"'"
        SQLEXEC(nConnHandle, cSql, "resultado")
        SELECT Resultado
        
        DO FORM 'Projeto2\Formulario\formacesso'
    
  
    ELSE
        IF EMPTY(cDthRent) AND EMPTY(cDthRSai)
            MESSAGEBOX("Nenhum acesso ativo encontrado. Criando novo registro.")
            
            IF TYPE("lnStatus") <> "N"
                lnStatus = 1 
            ENDIF

            lcLocal = IIF(TYPE("lcLocal") = "C", STRTRAN(lcLocal, "'", "''"), "NULL")
            lcObsAcesso = "login realizado com sucesso"

            lcSqlInsert = ;
                "INSERT INTO vip_movcli (Id_cliente, Local, Dthrent, Dthrsai, Idstatus, Obsacesso) " + ;
                "VALUES (" + ;
                    TRANSFORM(lcClienteId) + ", " + ;
                    IIF(!EMPTY(lcLocal), "'" + lcLocal + "'", "NULL") + ", " + ;
                    "NULL, NULL, " + ;
                    TRANSFORM(lnStatus) + ", " + ;
                    IIF(!EMPTY(lcObsAcesso), "'" + lcObsAcesso + "'", "NULL") + ;
                ")"

            lnResultadoInsert = SQLEXEC(nConnHandle, lcSqlInsert)

            IF lnResultadoInsert < 0
                MESSAGEBOX("Erro ao criar novo registro. C�digo de erro: " + TRANSFORM(lnResultadoInsert) + CHR(13) + "Consulta SQL: " + lcSqlInsert)
                RETURN
            ENDIF

            MESSAGEBOX("Novo registro criado com sucesso.")

            cSql = "SELECT id_cliente, nome, foto, HrIniAcesso, HrFimAcesso FROM vip_clientes WHERE cpf = '"+cCpf+"' AND senha = '"+cSenha+"'"
            SQLEXEC(nConnHandle, cSql, "resultado")
            SELECT Resultado

            DO FORM 'Projeto2\Formulario\formacesso'

       
        ELSE
            MESSAGEBOX("Nenhum acesso ativo encontrado. Criando novo registro.")
            
            IF TYPE("lnStatus") <> "N"
                lnStatus = 1 
            ENDIF

            lcLocal = IIF(TYPE("lcLocal") = "C", STRTRAN(lcLocal, "'", "''"), "NULL")
            lcMotivoBloqueio = IIF(TYPE("lcMotivoBloqueio") = "C", STRTRAN(lcMotivoBloqueio, "'", "''"), "NULL")
            lcObsAcesso = "login realizado com sucesso"

            lcSqlInsert = ;
                "INSERT INTO vip_movcli (Id_cliente, Local, Dthrent, Dthrsai, Idstatus, Motbloqueio, Obsacesso) " + ;
                "VALUES (" + ;
                    TRANSFORM(lcClienteId) + ", " + ;
                    IIF(!EMPTY(lcLocal), "'" + lcLocal + "'", "NULL") + ", " + ;
                    "NULL, NULL, " + ;
                    TRANSFORM(lnStatus) + ", " + ;
                    IIF(!EMPTY(lcMotivoBloqueio), "'" + lcMotivoBloqueio + "'", "NULL") + ", " + ;
                    IIF(!EMPTY(lcObsAcesso), "'" + lcObsAcesso + "'", "NULL") + ;
                ")"

            lnResultadoInsert = SQLEXEC(nConnHandle, lcSqlInsert)

            IF lnResultadoInsert < 0
                MESSAGEBOX("Erro ao criar novo registro. C�digo de erro: " + TRANSFORM(lnResultadoInsert) + CHR(13) + "Consulta SQL: " + lcSqlInsert)
                RETURN
            ENDIF

            MESSAGEBOX("Novo registro criado com sucesso.")

            cSql = "SELECT id_cliente, nome, foto, HrIniAcesso, HrFimAcesso FROM vip_clientes WHERE cpf = '"+cCpf+"' AND senha = '"+cSenha+"'"
            SQLEXEC(nConnHandle, cSql, "resultado")
            SELECT Resultado

            DO FORM 'Projeto2\Formulario\formacesso'
        ENDIF
        ENDIF 
ENDIF