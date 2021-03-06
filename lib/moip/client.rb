# encoding: utf-8
require 'httparty'

module MoIP
  class WebServerResponseError < StandardError ; end
  class MissingTokenError < StandardError ; end

  class Client
    include HTTParty

    base_uri "#{MoIP.uri}/ws/alpha"
    basic_auth MoIP.token, MoIP.key

    class << self

      # Envia uma instrução para pagamento único
      def checkout(attributes = {})
        full_data = peform_action!(:post, 'EnviarInstrucao/Unica', :body => SinglePayment.body(attributes))
        get_response!(full_data["EnviarInstrucaoUnicaResponse"]["Resposta"])
      end

      # Consulta dos dados das autorizações e pagamentos associados à Instrução
      def query(token)
        full_data = peform_action!(:get, "ConsultarInstrucao/#{token}")

        get_response!(full_data["ConsultarTokenResponse"]["RespostaConsultar"])
      end

      # Retorna a URL de acesso ao MoIP
      def moip_page(token)
        raise(MissingTokenError, "É necessário informar um token para retornar os dados da transação") if token.nil?
        "#{MoIP.uri}/Instrucao.do?token=#{token}"
      end

      # Monta o NASP
      def notification(params)
        notification = {}
        notification[:transaction_id] = params["id_transacao"]
        notification[:amount]         = params["valor"]
        notification[:status]         = MoIP::STATUS[params["status_pagamento"].to_i]
        notification[:code]           = params["cod_moip"]
        notification[:payment_type]   = params["tipo_pagamento"]
        notification[:email]          = params["email_consumidor"]
        notification
      end

      private

      def peform_action!(action_name, url, options = {})
        response = self.send(action_name, url, options)
        raise(WebServerResponseError, "Ocorreu um erro ao chamar o webservice") if response.nil?
        response
      end

      def get_response!(data)
        raise(WebServerResponseError, data["Erro"]) if data["Status"] == "Falha"
        data
      end
    end
  end
end
