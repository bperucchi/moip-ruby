# encoding: utf-8
require "nokogiri"

module MoIP

  class MissingPaymentTypeError < StandardError ; end
  class MissingPayerError < StandardError ; end

  class SinglePayment
    class << self
      # Cria uma instrução de pagamento direto
      def body(attributes = {})
        raise(MissingPaymentTypeError, "É necessário informar a razão do pagamento") if attributes[:razao].nil?
        raise(MissingPayerError, "É obrigatório passar as informações do billing") if attributes[:billing].nil?

        builder = Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
          xml.EnviarInstrucao {
            xml.InstrucaoUnica {
              xml.Razao {
                xml.text attributes[:razao]
              }
              xml.IdProprio {
                xml.text attributes[:id_proprio]
              }
              xml.Valores {
                xml.Valor(:moeda => "BRL") {
                  xml.text attributes[:valor]
                }
              }
              xml.Pagador {
                xml.Nome { xml.text attributes[:billing][:nome] }
                xml.LoginMoIP { xml.text attributes[:billing][:login_moip] }
                xml.Email { xml.text attributes[:billing][:email] }
                xml.TelefoneCelular { xml.text attributes[:billing][:tel_cel] }
                xml.Apelido { xml.text attributes[:billing][:apelido] }
                xml.Identidade { xml.text attributes[:billing][:identidade] }
                xml.EnderecoCobranca {
                  xml.Logradouro { xml.text attributes[:billing][:logradouro] }
                  xml.Numero { xml.text attributes[:billing][:numero] }
                  xml.Complemento { xml.text attributes[:billing][:complemento] }
                  xml.Bairro { xml.text attributes[:billing][:bairro] }
                  xml.Cidade { xml.text attributes[:billing][:cidade] }
                  xml.Estado { xml.text attributes[:billing][:estado] }
                  xml.Pais { xml.text attributes[:billing][:pais] }
                  xml.CEP { xml.text attributes[:billing][:cep] }
                  xml.TelefoneFixo { xml.text attributes[:billing][:tel_fixo] }
                }
              }
              xml.Mensagens{
                attributes[:billing][:messages].each do |message|
                  xml.Mensagem { xml.text message[0] }
                end
              }
              xml.Entrega{
                xml.Destino { xml.text "PreEstabelecido" }
                xml.CalculoFrete {
                  xml.Tipo_ "Proprio"
                  xml.ValorFixo_ attributes[:shippingCost]
                }
              }
            }
          }
        end
        builder.to_xml
      end
    end
  end
end