class Cliente < ApplicationRecord
  has_many :reservas, dependent: :destroy, inverse_of: :cliente
  has_many :quartos, through: :reservas

  validates :nome_completo,
            presence: true,
            length: { minimum: 5, maximum: 250},
            format: {
              with: /\A[a-zA-Záàâãéèêíïóôõöúçñ ]+\z/i,
              message: "deve conter apenas letras"
            }
  validates :data_nascimento,
            presence: true
  validates :cpf,
            presence: true,
            uniqueness: true
  validates :email,
            presence: true,
            format: {
              with: URI::MailTo::EMAIL_REGEXP
            }
 
  validate :data_nascimento_valida
  validate :cpf_valido

  def cpf_valido
    errors.add(:cpf, :invalid) unless cpf.blank? or CPF.valid?(cpf)
  end

  def data_nascimento_valida
    if data_nascimento.present? && data_nascimento > Time.zone.today
      errors.add(:data_nascimento, 'deve ser anterior ou igual a hoje')
    end
  end

  scope :busca_por_termo, -> (termo) do
    where("nome_completo LIKE ? OR cpf = ? OR email = ?", "%#{termo}%", termo, termo)
  end

end
