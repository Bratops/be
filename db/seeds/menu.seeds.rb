Menu.delete_all
root = Menu.create!(name: "root", desc: "System available menu items")
adm = Menu.create!(name: "dashboard_admin", desc: "Admin available menu items", klass: "admin")
adm.move_to_child_of(root)
p = Menu.create!(name: "使用者資訊", icon: "user", pos: 0, link: "users")
p.desc = "管理使用者資料"; p.save!; p.move_to_child_of(adm)
p = Menu.create!(name: "選單項目", icon: "bars", pos: 0, link: "menu")
p.desc = "依使用者權限編輯選單內容"; p.save!; p.move_to_child_of(adm)
p = Menu.create!(name: "題目資訊", icon: "tasks", pos: 1, link: "tasks")
p.desc = "管理題目資料"; p.save!; p.move_to_child_of(adm)
p = Menu.create!(name: "設定", icon: "cog", pos: 2, link: "pref")
p.desc = "設定系統參數"; p.save!; p.move_to_child_of(adm)
root.reload

um = Menu.create!(name: "dashboard_manager", desc: "Manager available menu items", klass: "manager")
um.move_to_child_of(root)
p = Menu.create!(name: "使用者資訊", icon: "user", pos: 0, link: "users")
p.desc = "管理使用者資料"; p.save!; p.move_to_child_of(um)
p = Menu.create!(name: "題目資訊", icon: "tasks", pos: 1, link: "tasks")
p.desc = "管理題目資料"; p.save!; p.move_to_child_of(um)
p = Menu.create!(name: "設定", icon: "cog", pos: 2, link: "pref")
p.desc = "設定系統參數"; p.save!; p.move_to_child_of(um)
root.reload

um = Menu.create!(name: "dashboard_teacher", desc: "Teacher available menu items", klass: "teacher")
um.move_to_child_of(root)
p = Menu.create!(name: "班級資訊", icon: "group", pos: 0, link: "groups")
p.desc = "管理班級資料"; p.save!; p.move_to_child_of(um)
p = Menu.create!(name: "學生資訊", icon: "graduation-cap", pos: 0, link: "students")
p.desc = "管理學生資料"; p.save!; p.move_to_child_of(um)
p = Menu.create!(name: "題目資訊", icon: "tasks", pos: 1, link: "tasks")
p.desc = "管理題目資料"; p.save!; p.move_to_child_of(um)
p = Menu.create!(name: "設定", icon: "cog", pos: 2, link: "pref")
p.desc = "設定系統參數"; p.save!; p.move_to_child_of(um)
root.reload

um = Menu.create!(name: "dashboard_student", desc: "student available menu items", klass: "student")
um.move_to_child_of(root)
p = Menu.create!(name: "測驗資訊", icon: "dot-circle-o", pos: 0, link: "contest")
p.desc = "檢視測驗資料"; p.save!; p.move_to_child_of(um)
p = Menu.create!(name: "迷你測驗", icon: "fa-list-ul", pos: 1, link: "task")
p.desc = "參加迷你測驗"; p.save!; p.move_to_child_of(um)
p = Menu.create!(name: "設定", icon: "cog", pos: 2, link: "pref")
p.desc = "個人設定"; p.save!; p.move_to_child_of(um)
root.reload

um = Menu.create!(name: "dashboard_user", desc: "user available menu items", klass: "user")
um.move_to_child_of(root)
p = Menu.create!(name: "設定", icon: "cog", pos: 2, link: "pref")
p.desc = "個人設定"; p.save!; p.move_to_child_of(um)
root.reload
