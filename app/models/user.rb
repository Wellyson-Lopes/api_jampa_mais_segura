class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :cpf, presence: true, uniqueness: { message: "indisponível" }, on: :create
  validate :valid_cpf_format
  before_validation :normalize_cpf

  private

  def valid_cpf_format
    return if cpf_valido?(cpf)

    errors.add(:cpf, "inválido")
  end

  def cpf_valido?(cpf)
    cpf = cpf.gsub(/\D/, '')

    return false unless cpf.size == 11 && cpf.scan(/\d/).uniq.size > 1

    digito_verificador(cpf, 9) == cpf[9].to_i && digito_verificador(cpf, 10) == cpf[10].to_i
  end

  def digito_verificador(cpf, posicao)
    multiplicadores = (2..posicao + 1).to_a.reverse
    soma = cpf[0...posicao].chars.map(&:to_i).zip(multiplicadores).map { |a, b| a * b }.sum
    resultado = 11 - (soma % 11)
    resultado >= 10 ? 0 : resultado
  end

  def normalize_cpf
    self.cpf = cpf.gsub(/\D/, '') if cpf.present?
  end
end
