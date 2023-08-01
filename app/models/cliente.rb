class Cliente < ApplicationRecord
  has_many :reservas

  validates :nome_completo, presence: true
  validates :data_nascimento, presence: true
  validates :cpf, presence: true, uniqueness: true,
            format: { with: /\A\d{11}\z/, message: 'deve conter 11 dígitos numéricos' }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

end
