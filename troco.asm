; ==========================================================
; PROBLEMA 2 – TROCO
; ==========================================================

; Inicialização dos ponteiros e variáveis de controle
; Configuração dos registradores para manipulação dos vetores
main
	add a0, zr, valores		; a0 = &valores
	add a1, zr, resultado		; a1 = &resultado
	add v1, zr, 0			; v1 = indice
	ldw a2, zr, quantia		; a2 = *quantia
	ldw v2, zr, limite_vals		; v2 = *limite_vals
	add a3, zr, disponiveis		; a3 = &disponiveis
	add v3, zr, 0			; v3 = contador_usado
	ldw v4, zr, tam_resultado	; v4 = tam_resultado
	add v5, zr, 1			; v5 = constante_1
	add lr, zr, processar		; lr = &processar

; Validação do valor atual contra a denominação disponível
; Redireciona para próximo_valor se insuficiente
; Verifica disponibilidade de cédulas antes de processar
validacao
	ldw v6, a0			; v6 = *a0
	blt a2, v6, proximo_valor	; a2 < v6 -> proximo_valor
	ldw v7, a3			; v7 = *a3
	blt v7, v5, buscar_proximo	; v7 < v5 -> buscar_proximo
	beq zr, lr			; chama processar

; Avança para próxima denominação quando valor é muito grande
; Verifica se atingiu o final das denominações
; Atualiza ponteiros e continua validação ou retorna erro
proximo_valor
	add a0, a0, 2			; a0 = a0 + 2
	add v1, v1, 1			; v1 = v1 + 1
	blt v2, v1, erro_impossivel	; v2 < v1 -> erro_impossivel
	add a3, a3, 2			; a3 = a3 + 2
	ldw v6, a0			; v6 = *a0
	blt a2, v6, proximo_valor	; a2 < v6 -> proximo_valor
	ldw v7, a3			; v7 = *a3
	blt v7, v5, buscar_proximo	; v7 < v5 -> buscar_proximo

; Subtrai denominação do valor restante e registra uso
; Decrementa quantidade disponível da denominação
; Verifica conclusão ou continua processo
processar
	sub a2, v6			; a2 = a2 - v6
	stw v6, a1			; &a1 = v6
	sub v7, v7, 1			; v7 = v7 - 1
	stw v7, a3			; &a3 = v7
	add v3, v3, 1			; v3 = v3 + 1
	add a1, a1, 2			; a1 = a1 + 2
	beq a2, zr, preparar_saida	; a2 == 0 -> preparar_saida
	beq zr, zr, validacao		; 0 == 0 -> validacao

; Procura próxima denominação com disponibilidade
; Itera até encontrar ou chama processar
buscar_proximo
	add a0, a0, 2			; a0 = a0 + 2
	add a3, a3, 2			; a3 = a3 + 2
	ldw v7, a3			; v7 = *a3
	blt v7, v5, buscar_proximo	; v7 < v5 -> buscar_proximo
	ldw v6, a0			; v6 = *a0
	beq zr, lr			; chama processar

; Exibe mensagem de erro quando não há solução
erro_impossivel
	ldw a0, zr, codigo_erro		; a0 = *codigo_erro
	stw a0, zr, 0xf000		; printa -1
	hlt				; encerra o programa

; Prepara registradores para impressão dos resultados
preparar_saida
	add lr, zr, exibir		; lr = &exibir
	add v0, zr, resultado		; v0 = &resultado

; Iteração sobre resultados para exibição
exibir
	ldw v1, v0			; v1 = *v0
	beq v1, zr, terminar		; v1 == 0 -> terminar
	stw v1, zr, 0xf000		; printa *v1
	add v0, v0, 2			; v0 = v0 + 2
	beq zr, lr			; chama exibir

; Finalização do programa
terminar	
	hlt				; encerra o programa
	
; Declaração de dados e constantes
valores
	100 50 10 5 1
limite_vals
	5
disponiveis
	2 1 3 1 10
resultado
	0 0 0 0 0 0 0 0 0 0
tam_resultado
	10
quantia
	137
codigo_erro
	-1

