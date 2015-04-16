
function love.conf(v)
	--configure game
	v.title = "Snake2Love"
	v.author = "Jéssica Thaisa Almeida"
	v.console = false
	
	v.window.width = 32 * 40
	v.window.height = 32 * 20
	v.window.fullscreen = false
	io.stdout:setvbuf("no")
end