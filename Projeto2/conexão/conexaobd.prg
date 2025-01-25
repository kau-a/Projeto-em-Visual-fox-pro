cIP = "186.202.152.106"   
cUsuario = "ornatustst"       
cSenha = "Orn@170621"        
cBanco = "ornatustst"         


PUBLIC nConnHandle 
nConnHandle = SQLSTRINGCONNECT("Driver={MySQL ODBC 5.2 Unicode Driver};Server=" + cIP + ";UID=" + cUsuario + ";PWD=" + cSenha + ";DATABASE=" + cBanco + ";")


IF nConnHandle > 0
    MESSAGEBOX("Conexão bem-sucedida!")

  
    cSQL = "SELECT * FROM vip_clientes"
    nResult = SQLEXEC(nConnHandle, cSQL, "ResultadoCursor")

    IF nResult > 0
        MESSAGEBOX("Acessando formulario")
    ELSE
        MESSAGEBOX("Erro na execução da consulta.")
    ENDIF
ENDIF


DO FORM 'Projeto2\Formulario\formval'