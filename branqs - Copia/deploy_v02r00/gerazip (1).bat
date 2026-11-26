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
REM Importante:
REM As variaveis %PROGRAMA% e "%versaoDeploy%" sao criadas pelo programa
REM executavel do deploy
REM ***************************************************************************

del "%homepath%\Desktop\%PROGRAMA%.zip"
md "tmp"
md "tmp\%PROGRAMA%"
copy *.exe "tmp\%PROGRAMA%"
copy *.wfn "tmp\%PROGRAMA%"
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


