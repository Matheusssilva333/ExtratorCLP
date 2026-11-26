REM ***************************************************************************
REM Programa:     Smartupload
REM Versao:       07
REM Revisao       00
REM Data:         23/04/2013
REM Autor:        Thiago La Pastina
REM Descricao:    Versao original
REM
REM ***************************************************************************

REM ***************************************************************************
REM Programa:     Smartupload
REM Versao:       07
REM Revisao       01
REM Data:         14/09/2013
REM Autor:        Fernando Branquinho
REM Descricao:    Adaptacao para geracao automatica do DEPLOY
REM
REM smartupV07R01 Eliminada a linha do SET da variavel PROGRAMA
REM ***************************************************************************

REM ***************************************************************************
REM Programa:     Smartupload
REM Versao:       07
REM Revisao       01
REM Data:         14/02/2014
REM Autor:        Thiago
REM Descricao:    Feito com que o SU identifique que nao ha software na pasta Branqs
REM
REM ***************************************************************************


REM smartupV07R01 SET PROGRAMA=90000200

IF NOT EXIST C:\UTIL\CHOICE.COM goto erro 1
IF NOT EXIST C:\UTIL\RAMDRIVE.SYS goto erro1
IF NOT EXIST C:\UTIL\CONFIG.SYS goto erro1
IF NOT EXIST E:\NUL goto erro1

REM ****************** LIMPEZA DE SEGURANCA
DELTREE /Y \%PROGRAMA%

REM ****************** SALVA AS RECEITAS
MD \RECEITAS
COPY \BRANQS\*.DAT \RECEITAS
COPY \BRANQS\*.PAR \RECEITAS
COPY \BRANQS\*.BAK \RECEITAS

REM ****************** SALVA RELAT
MD \RELAT
COPY \BRANQS\RELAT\*.* \RELAT

REM ****************** BACKUP DO SOFTWARE INSTALADO
XCOPY \BRANQS E:\RECUPERA\ /S/E/V

REM ****************** INSTALA NOVO PROGRAMA
DELTREE /Y \BRANQS
MD \BRANQS
XCOPY E:\BRANQS\%PROGRAMA% \BRANQS /S/E/V
COPY /Y E:\BRANQS\AUTOEXEC.BAT C:\

REM ****************** RECUPERA AS RECEITAS
COPY \RECEITAS\*.DAT \BRANQS
COPY \RECEITAS\*.PAR \BRANQS
COPY \RECEITAS\*.BAK \BRANQS

REM ****************** RECUPERA RELAT
MD \BRANQS\RELAT
COPY \RELAT\*.* \BRANQS\RELAT

REM ****************** ELIMINA PASTAS TEMPORARIAS
DELTREE /Y \RECEITAS
DELTREE /Y E:\%PROGRAMA%
DELTREE /Y \%PROGRAMA%
DELTREE /Y \RELAT
DELTREE /Y E:\BRANQS\%PROGRAMA%
REM **********************************************

IF EXIST C:\BRANQS\*.EXE GOTO INSTALA2

:erro1

DELTREE /Y \BRANQS
MD \BRANQS
XCOPY E:\RECUPERA \BRANQS /S/E/V
COPY /Y \RECUPERA\AUTOEXEC.BAT C:\
DELTREE /Y E:\RECUPERA
DELTREE /Y /RECUPERA
@ECHO OFF
CLS
ECHO *************************************************************
ECHO *                       SmartUpLoad 7                       *
ECHO *                                                           *
ECHO *                    MENSAGEM IMPORTANTE                    * 
ECHO *   O SOFTWARE NAO INSTALOU CORRETAMENTE OU E INCOMPATIVEL  *
ECHO * COM A VERSAO ATUAL DO SISTEMA. CONTATE O SUPORTE TECNICO. *
ECHO *************************************************************
PAUSE >NUL
GOTO FIM

:INSTALA2

DELTREE /Y \RECUPERA
DELTREE /Y E:\RECUPERA
REM ****************** EXECUTA PROGRAMA

:FIM

CD \BRANQS
tpanel -1
%PROGRAMA%



