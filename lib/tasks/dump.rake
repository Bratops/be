task :dump => :environment do
  teachers = User.with_role :teacher
  teachers.each do |t|
    ug = Edu::Ugroup.with_role(:teacher, t).order(:school_id)
    sn = t.current_group ? t.current_group.school.name : "no school"
    tn = t.info ? t.info.name : "no name"
    tp = t.info ? t.info.phone : "no phone"
    puts "#{sn},#{tn}, #{t.email}, #{tp}, #{ug.size}, #{ug.sum(:enrollments_count)}"
  end
end
