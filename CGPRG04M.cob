       IDENTIFICATION DIVISION.
      *=======================*
       PROGRAM-ID.   RSPRG002.
      *AUTHOR.       ALVARO PEREIRA DO NASCIMENTO.
      *DATE-WRITTEN. 26/03/2019.
      *--------------------------------------------------------------*
      * DISCIPLINA PROGRAMACAO MAINFRAME
      *--------------------------------------------------------------*
      * OBJETIVO: RECEBER DADOS DA SYSIN(ACCEPT)
      *           CALCULAR A MEDIA ARITMETICA BIMESTRAL
      *--------------------------------------------------------------*
      *------------------> HISTORICO - MANUTENCAO <------------------*
      * VERSAO  MES/ANO  NR.DOC  IDENT.  DESCRICAO
      * ------  -------  ------  ------  -------------------------   *
      *  V01    03/2019  010001  SISTEMA MOSTRA SYSOUT
      *--------------------------------------------------------------*
       ENVIRONMENT DIVISION.
      *====================*
       CONFIGURATION SECTION.
      *---------------------*
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA
           CURRENCY SIGN IS "R$ " WITH PICTURE SYMBOL "$"
           .
       INPUT-OUTPUT SECTION.
      *---------------------*
       DATA DIVISION.
      *=============*
       FILE SECTION.
      *------------*
       WORKING-STORAGE SECTION.
      *-----------------------*
       01  FILLER                 PIC X(35)        VALUE
           '**** INICIO DA WORKING-STORAGE ****'.

      *-----> VARIAVEIS AUXILIARES UTILIZADA NO PROCESSAMENTO
       01  WS-AREA-AUX.
           05  WS-FIM                 PIC X(01).
           05  AS-NUMERO-IN           PIC 9(04).
           05  AS-MEDIA               PIC 9(02)V99.
           05  AS-SEXO-IN             PIC X(01).
           05  AS-IDADE-IN            PIC 9(02).
           05  AS-CURSO-IN            PIC X(12).
           05  AS-NOTAA1-IN           PIC 9(02)V99.
           05  AS-NOTAA2-IN           PIC 9(02)V99.
           05  AS-RESGISTRO           PIC 9(02).
           05  AS-SEXM                PIC X(01).

      *-----> ENTRADA - DADOS VIA SYSIN (NO JCL DE EXECUCAO)

       01  WS-REG-SYSOUT.
           05 WS-NUM              PIC 9(04).
           FILLER                 PIC X(01).
           05 WS-NOM              PIC X(20).
           FILLER                 PIC X(01).
           05 WS-SEX              PIC X(01).
           FILLER                 PIC X(01).
           05 WS-IDA              PIC 9(02).
           FILLER                 PIC X(01).
           05 WS-CUR              PIC X(12).
           FILLER                 PIC X(01).
           05 WS-NOT1-IN          PIC Z9V99.
           FILLER                 PIC X(01).
           05 WS-NOT2-IN          PIC Z9V99.
           FILLER                 PIC X(01).
           WS-MED                 PIC Z9V99.

       01  FILLER                 PIC X(35)        VALUE
           '****** FIM DA WORKING-STORAGE *****'.
      *
       PROCEDURE DIVISION.
      *==================*
      *--------------------------------------------------------------*
      *    PROCESSO PRINCIPAL
      *--------------------------------------------------------------*
       000-RSPRG002.

           PERFORM 010-INICIAR
           PERFORM 030-PROCESSAR UNTIL WS-FIM = 'S'
           PERFORM 090-TERMINAR
           STOP RUN
           .
      *--------------------------------------------------------------*
      *    PROCEDIMENTOS INICIAIS
      *--------------------------------------------------------------*
       010-INICIAR.

           PERFORM 025-LER-SYSIN
           .
      *--------------------------------------------------------------*
      *    LEITURA DADOS DA SYSIN
      *--------------------------------------------------------------*
       025-LER-SYSIN.

           ACCEPT WS-REG-SYSIN  FROM SYSIN

           IF WS-REG-SYSIN = ALL '9'
              MOVE   'S'     TO  WS-FIM
           ELSE
              ADD 1  TO WS-CTLIDO
           END-IF
           .
      *--------------------------------------------------------------*
      *    PROCESSAR DADOS RECEBIDOS DA SYSIN ATE FIM DOS REGISTROS
      *--------------------------------------------------------------*
       030-PROCESSAR.

           COMPUTE WS-MED = (AS-NOTAA1 + WS-NOTAA2) / 2
           DISPLAY WS-REG-SYSOUT
           DISPLAY WS-MEDIA
           ADD 1  TO AS-REGISTRO
           IF   AS-SEXO-IN  = 'M'
             ADD 1 TO AS-SEXM
           PERFORM 025-LER-SYSIN
           .
      *--------------------------------------------------------------*
      *    PROCEDIMENTOS FINAIS
      *--------------------------------------------------------------*
       090-TERMINAR.

           DISPLAY ' *========================================*'
           DISPLAY ' *   TOTAIS DE CONTROLE - RSPRG002        *'
           DISPLAY ' *----------------------------------------*'
           DISPLAY ' * REGISTROS LIDOS    - SYSIN  = ' WS-CTLIDO
           DISPLAY ' *========================================*'
           DISPLAY ' *----------------------------------------*'
           DISPLAY ' *      TERMINO NORMAL DO RSPRG002        *'
           DISPLAY ' *----------------------------------------*'
           .
      *---------------> FIM DO PROGRAMA RSPRG002 <-------------------*
