class User < ApplicationRecord
  validates :nome_completo, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness:true
  validates :senha, presence: true, length: { in: 6..20,
            message: "A senha precisa ter entre 6 e 20 caracteres" }
  validates :user_type, presence: true, inclusion: { in: %w(comum lojista) }

  has_many :transfers
end
