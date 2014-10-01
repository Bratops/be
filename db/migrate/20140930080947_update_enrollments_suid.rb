class UpdateEnrollmentsSuid < ActiveRecord::Migration
  def change
    Acn::Enrollment.all.each do |en|
      os = en.suid
      oss = en.status
      if en.suid && en.suid.include?("-")
        en.suid = en.suid.split("-")[1]
        en.save
      end
      if en.user && en.status == "added"
        en.status = "joined"
        en.save
      end
      puts "#{en.id} - from: #{os} to: #{en.suid}, #{oss} -> #{en.status}"
    end
  end
end
