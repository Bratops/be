# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `integer`          | `not null, primary key`
# **`email`**                   | `string(255)`      | `default(""), not null`
# **`encrypted_password`**      | `string(255)`      | `default(""), not null`
# **`reset_password_token`**    | `string(255)`      |
# **`reset_password_sent_at`**  | `datetime`         |
# **`remember_created_at`**     | `datetime`         |
# **`sign_in_count`**           | `integer`          | `default(0), not null`
# **`current_sign_in_at`**      | `datetime`         |
# **`last_sign_in_at`**         | `datetime`         |
# **`current_sign_in_ip`**      | `string(255)`      |
# **`last_sign_in_ip`**         | `string(255)`      |
# **`created_at`**              | `datetime`         |
# **`updated_at`**              | `datetime`         |
# **`authentication_token`**    | `string(255)`      |
# **`login_alias`**             | `string(255)`      |
# **`name`**                    | `string(255)`      |
# **`suid`**                    | `string(255)`      |
# **`group_id`**                | `integer`          |
#

class User < ActiveRecord::Base
  rolify
  include Concerns::TokenAuthenticable
  before_save :ensure_login_alias!

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         #:timeoutable, :omniauthable

  has_one :user_info
  belongs_to :group
  delegate :school, to: :group, allow_nil: true
  counter_culture [:group, :school, :location]
  counter_culture [:group, :school, :holder]
  counter_culture [:group, :school, :age_level]
  counter_culture [:group, :school]
  counter_culture [:group]
  structure do
    encrypted_password ""
    reset_password_token ""
    reset_password_sent_at :datetime
    remember_created_at :datetime
    current_sign_in_at :datetime
    last_sign_in_at :datetime
    current_sign_in_ip ""
    last_sign_in_ip ""
    sign_in_count 0
    timestamps

    email "", index: true,
      validates: { format: /\A[^@]+@[^@]+\z/,
                   uniqueness: { :case_sensitive => false } }
    suid "", index: true,
      validates: { allow_blank: true, unless: :suid_blank?,
                   format: /\A\w+-{1}\w+\z/,
                   uniqueness: { case_sensitive: false } }
    login_alias "", index: true,
      validates: { allow_blank: false,
                   uniqueness: { :case_sensitive => false } }
    authentication_token "", index: true
  end

  def suid_blank?
    self.suid.blank?
  end

  def ensure_login_alias!
    if self.login_alias.blank?
      self.login_alias = (self.suid.presence || self.email)
    end
  end
end
