require 'net/http'
require 'uri'
require 'json'

class Traduzir
    def tradutor(mensagem, idioma_atual, idioma_traduz)
        uri = URI.parse("https://api.gotit.ai/Translation/v1.1/Translate")
        request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
        request.basic_auth("1989-ig1p4g5l", "rfNFuAOLnwX+VREC16Yp3Pp9E4/LmWT0tPwm/J0x") 
        request.body = {T: mensagem, SL: idioma_atual, TL: idioma_traduz}.to_json
        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
            http.request(request)
        end
        requisicao = JSON.parse(request.body)
        resposta = JSON.parse(response.body)
        return resposta["result"]
    end
end
