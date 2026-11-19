// EXTRATOR


SINAL_DIGITAL(autoExtratorRecuo)
SINAL_DIGITAL(autoAvancaExtrator)
SINAL_DIGITAL(autoMoldeAberto)
SINAL_DIGITAL(autoMotorLigado)
SINAL_DIGITAL(autoFechamentoMolde)
SINAL_DIGITAL(autoMotorDesligado)


//  CAMPOS DE SINALIZAÇÃO DO CICLO AUTOMÁTICO


CAMPO_SINAL_DIGITAL(autoEsperandoInicioCiclo)
CAMPO_SINAL_DIGITAL(autoAvancoExtrator)
CAMPO_SINAL_DIGITAL(autoMoldeAberto)
CAMPO_SINAL_DIGITAL(autoMotorLigado)
CAMPO_SINAL_DIGITAL(autoFechamentoMolde)
CAMPO_SINAL_DIGITAL(autoDosagem)
CAMPO_SINAL_DIGITAL(autoResfriamento)
CAMPO_SINAL_DIGITAL(autoExtratorRecuo)
CAMPO_SINAL_DIGITAL(autoMotorDesligado)
CAMPO_SINAL_DIGITAL(autoFechamentoCiclo)


//  COMANDO LIGA/DESLIGA MOTOR


MEMO(auxBotaoLigaMotor)

// Liga motor
SEL(auxBotaoLigaMotor)
SUBIDA
EN(comandoLigaMotor)
MEMO(solicLigaMotor)

// Desliga motor
SEL(auxBotaoLigaMotor)
SUBIDA
E(comandoLigaMotor)
MEMO(solicDesligaMotor)


// COMANDO DE AVANÇO DO EXTRATOR


SEL(botaoAvancaExtrator)
E(manual)
OU(autoAvancaExtrator)
MEMO(solicAvancaExtrator)


//  ALARMES E RESET


// Reset de alarmes
SEL(auxBotaoSelecaoMoldeManual)
SUBIDA
MEMO(resetAlarme)

// Alarme: molde aberto durante solicitação
// de avanço do extrator

SEL(solicAvancaExtrator)
EN(moldeAberto)
MEMO(alarmeMoldeAberto)


//Supervisao de movimentos
//////////////////////////

        CAMPO_CHAR_CONFINT(habSupervisaoMovimentos)
 
////////////////////////////////////////////////////////////////////////////////////////////////
// Declaracao Entradas digitais virtuais
////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////
// Declaracao Sequenciamento automatico
////////////////////////////////////////////////////////////////////////////////////////////////

        CAMPO_SINAL_DIGITAL(autoEsperandoInicioCiclo)
        CAMPO_SINAL_DIGITAL(autoFechamentoMolde)
        CAMPO_SINAL_DIGITAL(autoIntrusao)
        CAMPO_SINAL_DIGITAL(autoPreenchimento)
        CAMPO_SINAL_DIGITAL(autoRecalque)
        CAMPO_SINAL_DIGITAL(autoDosagem)
        CAMPO_SINAL_DIGITAL(autoResfriamento)
        CAMPO_SINAL_DIGITAL(autoAberturaMolde)
        CAMPO_SINAL_DIGITAL(autoPreAvancamento)
        CAMPO_SINAL_DIGITAL(autoFimCiclo)

////////////////////////////////////////////////////////////////////////////////////////////////
// Declaracao Alarmes
////////////////////////////////////////////////////////////////////////////////////////////////

         CAMPO_ALARME(alarmeProtetorDiantAberto,"Protetor dianteiro aberto")
         CAMPO_ALARME(alarmeMoldeNaoFechado,"Molde nao fechado")
         CAMPO_ALARME(alarmeDestravouDuranteInjecao,"Destravou fechamento do molde durante injecao")
         CAMPO_ALARME(alarmeIncongruenciaFCsMolde,"Problema nos fins de curso do Molde")
         CAMPO_ALARME(alarmeFechamentoMoldeNaoCompletado,"Fechamento do Molde nao completado")
         CAMPO_ALARME(alarmeAberturaMoldeNaoCompletada,"Abertura do molde nao completada")
         CAMPO_ALARME(alarmeDosagemNaoCompletada,"Dosagem nao completada")
         CAMPO_ALARME(alarmeTempoMaxDeCiclo,"Tempo maximo de ciclo excedido")
         CAMPO_ALARME(alarmeCompletarDosagem,"Completar curso de dosagem manualmente");
         CAMPO_ALARME(alarmeControleProducao,"Producao atingida");     
         CAMPO_ALARME(alarmeMotorDesligado,"Motor desligado")              

        //Niveis de alarme

        SINAL_DIGITAL(alarmeNivel1)         //Informativo
        SINAL_DIGITAL(alarmeNivel2)         //Impede inicio do ciclo em automatico
        SINAL_DIGITAL(alarmeNivel3)         //Interrompe todos os movimentos
        SINAL_DIGITAL(alarmeNivel4)         //Desliga motor
