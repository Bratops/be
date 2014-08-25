AgeLevel.mock(name: "國小").save
AgeLevel.mock(name: "國中").save
AgeLevel.mock(name: "高中").save
AgeLevel.mock(name: "高職").save
AgeLevel.mock(name: "大學").save
AgeLevel.mock(name: "研究所").save
AgeLevel.mock(name: "社會人士").save
AgeLevel.mock(name: "資訊專業人士").save

Holder.mock(name: "私立").save
Holder.mock(name: "市立").save
Holder.mock(name: "縣立").save
Holder.mock(name: "國立").save

Location.mock(name: "臺北市").save
Location.mock(name: "新北市").save
Location.mock(name: "臺中市").save
Location.mock(name: "臺南市").save
Location.mock(name: "高雄市").save
Location.mock(name: "基隆市").save
Location.mock(name: "新竹市").save
Location.mock(name: "嘉義市").save
Location.mock(name: "桃園縣").save
Location.mock(name: "新竹縣").save
Location.mock(name: "苗栗縣").save
Location.mock(name: "彰化縣").save
Location.mock(name: "南投縣").save
Location.mock(name: "雲林縣").save
Location.mock(name: "嘉義縣").save
Location.mock(name: "屏東縣").save
Location.mock(name: "宜蘭縣").save
Location.mock(name: "臺東縣").save
Location.mock(name: "花蓮縣").save
Location.mock(name: "澎湖縣").save

class << self
  def holder_val data
    case data
    when "國立" then hv = Holder.find_by(name: data)
    when "縣立" then hv = Holder.find_by(name: data)
    when "市立" then hv = Holder.find_by(name: data)
    else
      hv = Holder.find_by(name: "私立")
    end
    hv
  end

  def level_val data
    rs = /(高農|高工|餐旅|附工|家職|商水|海事水產|海事|農工|高商|商工|家商|工商|工家|商海|工農|護家|餐飲|藝校)/.match(data)
    val = "高職" unless rs.nil?
    rs = /(中學|女中|高中|附中|一中|二中)/.match(data)
    val = "高中" unless rs.nil?
    AgeLevel.find_by(name: val)
  end

  def seed_school klass # "hs", "hv"
    reghs = /(?<holder>國立|市立|私立|財團法人|天主教|縣立)(?<name>\D{2,8})(?<level>中學|女中|高中|附中|一中|二中)/
    reghv = /(?<holder>國立|市立|私立|財團法人)(?<name>\D{2,8})(?<level>高農|高工|餐旅|附工|家職|商水|海事水產|海事|農工|高商|商工|家商|工商|工家|商海|工農|護家|餐飲|藝校)/
    regs = { "hs" => reghs, "hv" => reghv }
    cnt = 1
    File.open("db/seeds/raw/#{klass}_list.txt", "r").each_line do |ln|
      data = ln.chomp.split(/,| |\t/)  # moeid, name, location
      rk = regs[klass].match(data[1])
      ss = School.mock( moeid: data[0], name: data[1])
      ss.holder = holder_val(rk[:holder])
      ss.age_level = level_val(rk[:level])
      ss.location = Location.find_by(name: data[2][4..-1])
      cnt = cnt +1
      if ss.save then next else
        puts "[#{cnt}:#{data[1]}]Errrrrrrrrrrrrrr..."
        puts ss.errors.messages
      end
    end
  end
end

seed_school "hs"
seed_school "hv"
