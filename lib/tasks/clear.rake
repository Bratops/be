task :clear => :environment do
  cnt = Acn::Info.where(user: nil).destroy_all
  puts "--> #{cnt} Acn::Info removed."
  Edu::Ugroup.counter_culture_fix_counts
  Acn::Enrollment.counter_culture_fix_counts
  Acn::Enrollment.where.not(ugroup: Edu::Ugroup.ids).destroy_all
end
