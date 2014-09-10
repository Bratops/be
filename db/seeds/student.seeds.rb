class << self
  def fake_user sid=""
    u = User.new(email: "#{sid}@email.dev")
    u.password = "aabbaabb"
    u.user_info = UserInfo.new(name: "fake_std_#{sid}")
    u.save
    u.make_user!
  end

  def fake_users
    (1..20).each do |i|
      fake_user "00#{i.to_s.rjust(2, '0')}"
    end
  end
end

puts User.where("email like '%email.dev'").delete_all
fake_users
