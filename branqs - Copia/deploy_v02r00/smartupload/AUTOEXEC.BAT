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

REM smartupV07R01 SET PROGRAMA=90000200

echo y > resp.txt
lock c: < resp.txt
C:\UTIL\SMARTDRV.EXE /X
PROMPT $p$g
PATH C:\UTIL;C:\TOUCHKIT
SET TEMP=C:\UTIL
IF NOT EXIST D:\BRANQS\NUL GOTO cancela

REM *****************************************
REM Realiza pergunta
REM *****************************************

:inicio
@echo off
cls
echo *********************************************************************   
echo *                       BRANQS AUTOMACAO                            *
echo *                                                                   *
echo *             Branqs SmartUpload 7 - Escolha sua opcao              *
echo *                                                                   *
echo * 0) Para cancelar esta etapa, digite 0                             *
echo * 1) Para instalar o software que esta no pendrive, DIGITE 1        *
echo * 2) Para copiar receitas da IHM p/ o PENDRIVE, DIGITE 2            *
echo * 3) Para copiar receitas do PENDRIVE p/ a IHM, DIGITE 3            *
echo * 4) Para copiar config.internas da IHM p/ o PENDRIVE, DIGITE 4     *
echo * 5) Para copiar config.internas do PENDRIVE p/ a IHM, DIGITE 5     *
echo *                                                                   *
echo *********************************************************************
choice /c:012345 Escolha a opcao desejada

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
MD C:\RECUPERA
COPY C:\AUTOEXEC.BAT C:\RECUPERA
PKUNZIP -D -O D:\BRANQS\*.ZIP EXECPROG.BAT
MD E:\BRANQS
PKUNZIP -D -O D:\BRANQS\*.ZIP E:\BRANQS 

execprog

REM ************************************************
REM Execucao normal do software ja instalado na IHM
REM ************************************************

:cancela
CD \BRANQS
tpanel -1
%PROGRAMA%
