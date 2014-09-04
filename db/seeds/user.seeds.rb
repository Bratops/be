class << self
  def add_user role, name=nil
    name = name || "#{role}_beaver"
    pass = "#{name}#1234"
    email = "#{name}@bebras.tw.dev"
    u = User.mock(reset_password_sent_at: nil, reset_password_token: nil,
                  email: email, password: pass, password_confirmation: pass)
    ui = UserInfo.mock(name: name)
    u.user_info = ui
    u.add_role role
    u.save
    puts u.errors.messages
  end

  def add_users role, count=3
    (0..count).each do |i|
      add_user(role, "#{role}#{i}")
    end
  end

  def create_teacher row
    sc = School.find_by(name: row["school"])
    puts sc.name, sc.id, "--"
    if sc.present?
      pw = Devise.friendly_token[3,24]
      us = User.mock(
        created_at: row["date"],
        email: row["email"], reset_password_token: nil,
        password: pw, password_confirmation: pw)
      us.user_info = UserInfo.mock(name: row["name"], phone: row["phone"])
      us.save
      us.add_role :teacher
      sc.add_teacher us
    else
      puts "cant find school at #{row}"
    end
    us
  end

  def print_error row, obj
    if obj.errors
      puts "---> #{row["school"]}:#{row["name"]}- #{obj.errors.messages}"
    end
  end

  def add_teachers
    file = "db/seeds/data/bebras/teachers.csv"
    CSV.read(file, headers: true, col_sep: ", ").each do |row|
      st = create_teacher row
      print_error row, st
    end
  end
end

User.where("id != 76").delete_all
Enrollment.delete_all
Ugroup.delete_all
#add_user "admin"
#add_users "manager", 3
add_teachers
