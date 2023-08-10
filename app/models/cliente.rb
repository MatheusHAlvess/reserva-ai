class Cliente < ApplicationRecord
  has_many :reservas, dependent: :destroy, inverse_of: :cliente

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
            uniqueness: true,
            format: {
              with: /\A\d{11}\z/,
              message: 'deve conter 11 dígitos numéricos'
            }
  validates :email,
            presence: true,
            format: {
              with: URI::MailTo::EMAIL_REGEXP
            }

  validate :data_nascimento_valida

  def data_nascimento_valida
    if data_nascimento.present? && data_nascimento > Date.today
      errors.add(:data_nascimento, 'deve ser anterior ou igual a hoje')
    end
  end
  scope :busca_por_termo, -> (termo) {
    where("nome_completo LIKE ? OR cpf = ? OR email = ?", "%#{termo}%", termo, termo)
  }
end
