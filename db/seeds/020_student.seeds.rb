class << self
  def load_users
    file = File.open("db/seeds/data/bebras/students.txt")
    ta = nil; ug = nil;
    file.each_line do |fl|
      if fl.start_with?("    ")
        ha = fl.split("$$$")
        uh = eval(ha[0])
        epass = uh.delete :encrypted_password
        user = User.new(uh)
        ai = Acn::Info.new(eval(ha[1]))
        user.info = ai
        if user.save
          user.encrypted_password = epass
          user.save
          puts "enroll failed: #{user.errors.messages}, \n#{fl}" unless ug.enroll_new user
        else
          puts "wrong user: #{user.errors.messages}, \n#{fl}"
          break
        end
      elsif fl.start_with?("{email")
        puts fl
        hv = eval(fl)
        ta = User.find_by(hv)
        next if ta.nil?
        if ta.current_group.nil? || ta.current_group.school.nil?
          puts "Nogroup: #{ta.inspect}"
        end
      elsif fl.start_with?("  {grade")
        hv = eval(fl)
        ug = Edu::Ugroup.new(hv)
        ug.school = ta.current_group.school
        if ug.save
          ta.add_role :teacher, ug
        else
          puts "error: #{ ug.inspect }"
        end
      end
    end
  end
end


load_users
