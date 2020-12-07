require_relative "traducao"

## lista de idiomas disponibilizados pela API
list_idioma = {1 => 'PtBr', 2 => 'EnUs', 3 => 'ZhCh', 4 => 'DeAl'}

## Menu 
puts('---- Menu ----')
puts('1 - Traduzir')
puts('2 - Sair')

option = gets.chomp.to_i

## If para pegar os dados para o metodo "Traduzir"
if option == 1
    puts('Lista de Idiomas:')
    puts('1 - Português do Brasil')
    puts('2 - Inglês (Estados Unidos / Internacional)')
    puts('3 - Chinês (Simplificado)')
    puts('4 - Alemão')

    print("Qual o idioma que você deseja escrever sua mensagem?: ")
    numero_atual = gets.chomp.to_i
    idioma_atual = list_idioma[numero_atual]

    print("Digite a mensagem: ")
    mensagem = gets.chomp.to_s

    print("Traduzir para: ")
    numero_traduz = gets.chomp.to_i
    idioma_traduz = list_idioma[numero_traduz]

    tradutor = Traducao.new
    resultado = tradutor.traduzir(mensagem, idioma_atual, idioma_traduz)

    puts "Traduçao: "
    puts mensagem
    puts resultado

else
    puts "Volte sempre!"
end