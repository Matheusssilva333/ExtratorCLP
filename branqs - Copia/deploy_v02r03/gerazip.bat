REM ***************************************************************************
REM Programa:     Gerazip (Parte integrante do DEPLOY)
REM Versao:       01
REM Revisao       00
REM Data:         14/09/2013
REM Autor:        Fernando Branquinho
REM Descricao:    Versao original
REM
REM ***************************************************************************

REM ***************************************************************************
REM Programa:     Gerazip (Parte integrante do DEPLOY)
REM Versao:       01
REM Revisao       01
REM Data:         29/09/2013
REM Autor:        Fernando Branquinho
REM Descricao:    Inseridos os arquivos tectouch.cmp e tectouch.bmp
REM
REM ***************************************************************************

REM ***************************************************************************
REM Programa:     Gerazip (Parte integrante do DEPLOY)
REM Versao:       01
REM Revisao       02
REM Data:         21/07/2015
REM Autor:        Fernando Branquinho
REM Descricao:    Atualizado com o smartupload 7.4
REM
REM ***************************************************************************

REM ***************************************************************************
REM Programa:     Gerazip (Parte integrante do DEPLOY)
REM Versao:       01
REM Revisao       03
REM Data:         23/11/2017
REM Autor:        Fernando Branquinho
REM Descricao:    Alteracoes para contemplar o teclado Alfanumerico Touch
REM
REM ***************************************************************************


REM ***************************************************************************
REM Importante:
REM As variaveis %PROGRAMA% e "%versaoDeploy%" sao criadas pelo programa
REM executavel do deploy
REM ***************************************************************************

del "%homepath%\Desktop\%PROGRAMA%.zip"
md "tmp"
md "tmp\%PROGRAMA%"
copy *.exe "tmp\%PROGRAMA%"
copy *.wfn "tmp\%PROGRAMA%"
copy *.cmp "tmp\%PROGRAMA%"
copy *.bmp "tmp\%PROGRAMA%"
copy SVGACURS.SPR "tmp\%PROGRAMA%"
copy util\*.bat "tmp\%PROGRAMA%"
echo SET PROGRAMA=%PROGRAMA% > "tmp\AUTOEXEC.BAT"
type "%ProgramFiles%\branqs\%versaoDeploy%\smartupload\autoexec.bat" >> "tmp\AUTOEXEC.BAT"
echo SET PROGRAMA=%PROGRAMA% > "tmp\EXECPROG.BAT"
type "%ProgramFiles%\branqs\%versaoDeploy%\smartupload\execprog.bat" >> "tmp\EXECPROG.BAT"
md "tmp\%PROGRAMA%\paginas"
copy paginas\*.cmp "tmp\%PROGRAMA%\paginas"
copy paginas\*.bmp "tmp\%PROGRAMA%\paginas"
copy paginas\paginas.lst "tmp\%PROGRAMA%\paginas"
"%ProgramFiles%\branqs\%versaoDeploy%\7za" a -r -tZIP "%homepath%\Desktop\%PROGRAMA%" ".\tmp\*.*"
rd "tmp" /S /Q


