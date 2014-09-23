class Acn::Role < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :users_acn_roles
  belongs_to :resource, polymorphic: true
  scopify

  counter_culture :resource
  structure do
    name       "", index: true #, validates: { uniqueness: { case_sensitive: true }}
    resource_type ""

    timestamps
  end
end
