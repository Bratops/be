class << self
  def clear_user_info
    UserInfo.all.each do |ui|
      if ui.user.nil?
        ui.delete
      end
    end
  end

  def update_pw
    file = "db/seeds/data/bebras/tpw.csv"
    CSV.read(file, headers: false, col_sep: ",").each do |row|
      ui = UserInfo.find_by(name: row[0])
      if ui
        u = ui.user
        u.encrypted_password = row[1]
        u.save
      end
    end
  end
end

clear_user_info
update_pw
