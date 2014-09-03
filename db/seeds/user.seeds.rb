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
end

add_user "admin"
add_users "manager", 3
