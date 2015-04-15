
**PUC-Rio - Princípios de Engenharia de Software**  
**Trabalho 1 - 2015.1**  
Jéssica Thaisa Silva de Almeida  

# Snake2Love - Jogo da Cobrinha

## Introdução
Este trabalho compreende a criação de um jogo em Lua, suas funcionalidades e a documentação de tomadas de decisão, livro diário, arquitetura e assertivas.


## Arquivos

- README.md
- Livro Diário.txt
- Diagrama de Arquitetura.docx
- Diagrama de Arquitetura.pdf
- rascunhos > Dia03_01.jpg
- rascunhos > Dia05_01.jpg
- Snake2Love
	- images
		- fruit.png
		- scale.png
        - telaGanhou.png
        - telaInicial.png
        - telaPausou.png
        - telaPerdeu.png
        - wallpaper.jpg
	- conf.lua
	- Food.lua
	- Game.lua
	- main.lua
	- Snake.lua
	- Utils.lua
	- World.lua

### Descrição

| Arquivo           | Descrição  |
| ------------------|----------- |
| Diagrama de Arquitetura.docx | Diagrama de arquitetura do programa em formato WORD 2007+. |
| Diagrama de Arquitetura.pdf | Diagrama de arquitetura do programa em formato PDF. |
| Livro Diário.txt  | O livro diário contém as decisões e pensamentos do dia a dia do projeto.|
| 					| 			 |
| Dia03_01.jpg		| Rascunhos do dia 03. |
| Dia05_01.jpg		| Rascunhos do dia 05. |
| 					| 			 |
| fruit.png         | Imagem de fruta que aparece como comida para a cobrinha. |
| scale.png			| Textura de escama para a cobrinha. |
| telaGanhou.png	| Tela que aparece quando o jogador ganha o jogo. |
| telaInicial.png	| Tela que aparece quando o jogador inicia o jogo. |
| telaPausou.png	| Tela que aparece quando o jogador pausa o jogo. |
| telaPerdeu.png	| Tela que aparece quando o jogador perde o jogo. |
| wallpaper.jpg		| Imagem de fundo do jogo. |
| 					| 			 |
| conf.lua			| Arquivo de configuração do jogo. |
| Food.lua			| Arquivo com as funções referentes à comida da cobrinha. |
| Game.lua			| Arquivo com as funções referentes às chamadas básicas do jogo. |
| main.lua			| Arquivo principal com os callbacks do LÖVE. |
| Snake.lua			| Arquivo com as funções referentes à cobrinha. |
| Utils.lua			| Arquivo com as funções transversais mais gerais e pouco ligadas ao contexto. |
| World.lua			| Arquivo com as funções referentes ao mundo em que está localizada a cobrinha. |


## Requisitos do Jogo

 1. O jogo inicia com uma cobrinha de tamanho 3 andando pela tela a
    partir de uma posição aleatória em uma direção aleatória.
 2. Os movimentos permitidos são [cima], [baixo], [direita] e
    [esquerda].
 3. Os movimentos são controlados pelas setas do teclado.
 4. Uma ordem de movimento só é reconhecido após a próxima ter sido executada.
 4. Caso a cabeça da cobra encontre uma comida, ela a come, sua
    pontuação cresce  pontos e o tamanho da cobra cresce uma unidade.
 5. A cada comida que come, a cobra aumenta de velocidade.
 6. Caso a cabeça da cobra encontre uma parte de seu corpo é
    caracterizada uma colisão. Isso faz o jogador perder a partida.
 7. Se o jogador alcançar 1000 pontos vence a partida.
 8. Se o jogador pressionar a tecla [espaço] a qualquer momento do jogo, o jogo é pausado. Caso deseje voltar a jogar basta selecionar [espaço] novamente.

  
## Diagrama de Arquitetura

O diagrama de arquitetura representa a hierarquia de chamadas de função do programa.
Algumas informações importantes:

 - Outras funções do framework não estão sendo representadas neste diagrama:
	 - 	Funções de graphics (representaçao gráfica), chamadas nas funções draw (World.draw, Snake.draw e Food.draw).
	 - Callbacks load, update, draw e keypressed acionam as funções Load, Update, Draw e Controller, respectivamente, do modulo Game.
 - Entre <...> encontram-se os arquivos .lua em que estão as funções descritas. As cores no diagrama visam facilitar esta ligação graficamente.
 - As funções contidas no arquivo Utils são funções transversais.


### Outros:

Link para gerenciamento de versão: [https://github.com/jessicathaisa/Snake2Love](https://github.com/jessicathaisa/Snake2Love)