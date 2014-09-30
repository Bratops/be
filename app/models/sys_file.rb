class SysFile < ActiveRecord::Base
  mount_uploader :share, ::ShareUploader

  structure do
    name ""
    share ""
    fcode "", validates: { uniqueness: { case_sensitive: true }}
    down_count 0
  end

  before_create :ensure_fcode
  def ensure_fcode
    # start from 3, with 6 chars
    self.fcode = Devise.friendly_token[3,6]
  end
end
