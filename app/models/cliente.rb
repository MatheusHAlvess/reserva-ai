class Cliente < ApplicationRecord
  has_many :reservas, dependent: :destroy, inverse_of: :cliente
  has_many :quartos, through: :reservas

  validates :nome_completo,
            presence: true
  validates :data_nascimento,
            presence: true
  validates :cpf,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A\d{11}\z/,
              message: 'deve conter 11 digitos numericos'
            }
  validates :email,
            presence: true,
            format: {
              with: URI::MailTo::EMAIL_REGEXP
            }
  validate :data_nascimento_valida

  def data_nascimento_valida
    if data_nascimento.present? && data_nascimento > Time.zone.today
      errors.add(:data_nascimento, 'deve ser anterior ou igual a hoje')
    end
  end
end
