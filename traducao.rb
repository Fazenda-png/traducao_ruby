require 'net/http'
require 'uri'
require 'json'

class Traducao
    ##Class com as instansias para acessar a api
    def initialize
        @uri = URI.parse("https://api.gotit.ai/Translation/v1.1/Translate")
        @request = Net::HTTP::Post.new(@uri, 'Content-Type' => 'application/json')
        @request.basic_auth("1989-ig1p4g5l", "rfNFuAOLnwX+VREC16Yp3Pp9E4/LmWT0tPwm/J0x")
    end
    ## Metodo que recebe os dados do usuario para realizar a tradução
    def traduzir(mensagem, idioma_atual, idioma_traduz)
        @request.body = {T: mensagem, SL: idioma_atual, TL: idioma_traduz}.to_json
        response = Net::HTTP.start(@uri.hostname, @uri.port, use_ssl: @uri.scheme == "https") do |http|
            http.request(@request)
        end
    ## analisa o conteúdo com formato JSON
        requisicao = JSON.parse(@request.body)
        resposta = JSON.parse(response.body)
        resposta["result"]
    ## Formato em que o JSON vai ficar
        time = Time.new
        idioma_atual = requisicao["SL"]
        mensagem = requisicao["T"]
        idioma_traduz = requisicao["TL"]
        traducao = resposta["result"]

        file = File.open(time.strftime("#{traducao}--%m-%d-%Y.%H.%M.%S") + ".txt", 'w') do |linearq|
            linearq.puts "Idioma da mensagem: #{idioma_atual}"
            linearq.puts "Mensagem: #{mensagem}"
            linearq.puts "Idioma para tradução: #{idioma_traduz}"
            linearq.puts "Tradução: #{traducao}"
        end
    end
end
 
