require 'net/http'
require 'uri'
require 'json'

class Traducao
    def initialize
        @uri = URI.parse("https://api.gotit.ai/Translation/v1.1/Translate")
        @request = Net::HTTP::Post.new(@uri, 'Content-Type' => 'application/json')
        @request.basic_auth("1989-ig1p4g5l", "rfNFuAOLnwX+VREC16Yp3Pp9E4/LmWT0tPwm/J0x")
    end

    def traduzir(mensagem, idioma_atual, idioma_traduz)
        @request.body = {T: mensagem, SL: idioma_atual, TL: idioma_traduz}.to_json
        response = Net::HTTP.start(@uri.hostname, @uri.port, use_ssl: @uri.scheme == "https") do |http|
            http.request(@request)
        end

        requisicao = JSON.parse(@request.body)
        resposta = JSON.parse(response.body)
        save(requisicao, resposta)
        
        return resposta["result"]
        
    end

    def save(request, response)
        time = Time.new
        idioma_atual = request["SL"]
        mensagem = request["T"]
        idioma_traduz = request["TL"]
        traducao = response["result"]

        file = File.open(time.strftime("%m-%d-%Y.%H.%M.%S") + ".txt", 'w') do |linearq|
            linearq.puts ("Idioma da mensagem: #{idioma_atual}")
            linearq.puts ("Mensagem: #{mensagem}")
            linearq.puts ("Idioma para tradução: #{idioma_traduz}")
            linearq.puts ("Tradução: #{traducao}")
        end
    end
end
 
