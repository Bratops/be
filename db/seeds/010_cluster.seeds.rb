dc = [ "其他(請註記)",
       "普通班未分組", "自然組",
       "社會組", "人文社會資優班",
       "數理資優班", "資訊相關科別",
       "其他技職科別" ]

Edu::Cluster.delete_all
dc.each_with_index do |clu, i|
  ec = Edu::Cluster.new(id: i, name: clu, ugroups_count: 0)
  ec.save
end
