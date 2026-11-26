REM ***************************************************************************
REM Programa:     Smartupload
REM Versao:       07
REM Revisao       00
REM Data:         23/04/2013
REM Autor:        Thiago La Pastina
REM Descricao:    Versao original

REM ***************************************************************************
REM Programa:     Smartupload
REM Versao:       07
REM Revisao       01
REM Data:         14/09/2013
REM Autor:        Fernando Branquinho
REM Descricao:    Adaptacao para geracao automatica do DEPLOY
REM smartupV07R01 Eliminada a linha do SET da variavel PROGRAMA

REM ***************************************************************************
REM Programa:     Smartupload
REM Versao:       07
REM Revisao       01
REM Data:         14/02/2014
REM Autor:        Thiago
REM Descricao:    Feito com que o SU identifique que nao ha software na pasta Branqs

REM ***************************************************************************
REM Programa:   Smartupload
REM Versao:     07
REM Revisao     03
REM Data:       02/10/2014
REM Autor:      Branquinho
REM Descricao:  Adaptacao para utilizar IHM Touch sem teclado
REM 90400703.1	Substituido o "menu texto" pelo menu oferecido pelo programa 90560100
REM 90400703.2	Modificado o momento de inicializacao do driver do mouse, permitindo assim o uso do touch pelo menu touch

REM smartupV07R01 SET PROGRAMA=90000200

echo y > resp.txt
lock c: < resp.txt
C:\UTIL\SMARTDRV.EXE /X
PROMPT $p$g
PATH C:\UTIL;C:\TOUCHKIT
SET TEMP=C:\UTIL

REM 90400703.2 - Inicio do bloco inserido
tpanel -1
REM 90400703.2 - Fim do bloco inserido

IF NOT EXIST D:\BRANQS\NUL GOTO cancela

REM *****************************************
REM Realiza pergunta
REM *****************************************

:inicio
@echo off
REM 90400703.1 cls
REM 90400703.1 echo *********************************************************************   
REM 90400703.1 echo *                       BRANQS AUTOMACAO                            *
REM 90400703.1 echo *                                                                   *
REM 90400703.1 echo *             Branqs SmartUpload 7 - Escolha sua opcao              *
REM 90400703.1 echo *                                                                   *
REM 90400703.1 echo * 0) Para cancelar esta etapa, digite 0                             *
REM 90400703.1 echo * 1) Para instalar o software que esta no pendrive, DIGITE 1        *
REM 90400703.1 echo * 2) Para copiar receitas da IHM p/ o PENDRIVE, DIGITE 2            *
REM 90400703.1 echo * 3) Para copiar receitas do PENDRIVE p/ a IHM, DIGITE 3            *
REM 90400703.1 echo * 4) Para copiar config.internas da IHM p/ o PENDRIVE, DIGITE 4     *
REM 90400703.1 echo * 5) Para copiar config.internas do PENDRIVE p/ a IHM, DIGITE 5     *
REM 90400703.1 echo *                                                                   *
REM 90400703.1 echo *********************************************************************
REM 90400703.1 choice /c:012345 Escolha a opcao desejada

REM 90400703.1 - Inicio do bloco acrescentado
cd \util\90560100
90560100
cd \
REM 90400703.1 - Final do bloco acrescentado

if errorlevel 6 goto cfgPnIhm
if errorlevel 5 goto cfgIhmPn
if errorlevel 4 goto copPnIhm
if errorlevel 3 goto parIhmPn
if errorLevel 2 goto instalar
if errorlevel 1 goto cancela

REM *****************************************
REM Copia de receitas da IHM para o Pendrive
REM *****************************************

:parIhmPn
IF NOT EXIST C:\BRANQS\*.PAR GOTO sempar1

:copIhmPn
COPY /Y/V C:\BRANQS\*.PAR D:\BRANQS
MD D:\BRANQS\RELAT
XCOPY \RELAT D:\BRANQS\RELAT /S  
echo Arquivo(s) copiado(s) com sucesso
echo Pressione qualquer tecla para continuar
pause > nul
GOTO inicio

:sempar1
echo Nao ha receitas ou registros gravados na IHM
echo Pressione qualquer tecla para continuar
pause > nul
GOTO inicio

REM *****************************************
REM Copia de receitas do Pendrive para a IHM
REM *****************************************

:copPnIhm
IF NOT EXIST D:\BRANQS\*.PAR GOTO sempar2

COPY /Y/V D:\BRANQS\*.PAR C:\BRANQS  
echo Arquivo copiado com sucesso
echo Pressione qualquer tecla para continuar
pause > nul
GOTO inicio

:sempar2
echo Nao ha receitas gravadas no PENDRIVE
echo Pressione qualquer tecla para continuar
pause > nul
GOTO inicio


REM *******************************************************
REM Copia de configuracoes internas da IHM para o Pendrive
REM *******************************************************

:cfgIhmPn
IF EXIST C:\BRANQS\CONFINT.DAT GOTO ccfIhmPn

GOTO semconf1

:ccfIhmPn
COPY /Y/V C:\BRANQS\CONFINT.DAT D:\BRANQS
echo Arquivo(s) copiado(s) com sucesso
echo Pressione qualquer tecla para continuar
pause > nul
GOTO inicio

:semconf1
echo Nao ha arquivos de configuracoes gravados na IHM
echo Pressione qualquer tecla para continuar
pause > nul

GOTO inicio

REM *******************************************************
REM Copia de configuracoes internas do pendrive para a IHM
REM *******************************************************

:cfgPnIhm
IF EXIST D:\BRANQS\CONFINT.DAT GOTO ccfPnIhm

GOTO semconf2

:ccfPnIhm
COPY /Y/V D:\BRANQS\CONFINT.DAT C:\BRANQS
echo Arquivo(s) copiado(s) com sucesso
echo Pressione qualquer tecla para continuar
pause > nul
GOTO inicio

:semconf2
echo Nao ha arquivos de configuracoes gravados no PenDrive
echo Pressione qualquer tecla para continuar
pause > nul
GOTO inicio


REM ********************************
REM Inicio da instalacao do software
REM ********************************

:instalar
IF NOT EXIST D:\BRANQS\*.ZIP GOTO semzip

MD C:\RECUPERA
COPY C:\AUTOEXEC.BAT C:\RECUPERA
PKUNZIP -D -O D:\BRANQS\*.ZIP EXECPROG.BAT
MD E:\BRANQS
PKUNZIP -D -O D:\BRANQS\*.ZIP E:\BRANQS 

execprog

REM ************************************************
REM Execucao normal do software ja instalado na IHM
REM ************************************************

:semzip

@ECHO OFF
CLS
ECHO *************************************************************
ECHO *                       SmartUpLoad 7                       *
ECHO *                                                           *
ECHO *                    MENSAGEM IMPORTANTE                    * 
ECHO *   NENHUM ARQUIVO DE INSTALACAO DE SOFTWARE FOI ENCONTRADO *
ECHO *            DENTRO DA PASTA BRANQS DO PENDRIVE.            *
ECHO *                                                           *
ECHO *     PRESSIONE QUALQUER TECLA PARA EXECUTAR O SOFTWARE     *
ECHO *              ANTERIORMENTE INSTALADO NA IHM.              *
ECHO *************************************************************
PAUSE >NUL


:cancela
CD \BRANQS
REM 90400703.2 tpanel -1
%PROGRAMA%
