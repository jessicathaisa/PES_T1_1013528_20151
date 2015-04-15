
**PUC-Rio - Princípios de Engenharia de Software
Trabalho 1 - 2015.1
Jéssica Thaisa Silva de Almeida**

# Snake2Love - Jogo da Cobrinha

## Introdução
Este trabalho compreende a criação de um jogo em Lua, suas funcionalidades e a documentação de tomadas de decisão, livro diário, arquitetura e assertivas.


## Arquivos

- README.md
- Livro Diário.txt
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