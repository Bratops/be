Edu::Level.delete_all
Holder.delete_all
Location.delete_all
School.delete_all
Edu::Ugroup.delete_all

Edu::Level.mock(name: "國小").save
Edu::Level.mock(name: "國中").save
Edu::Level.mock(name: "高中").save
Edu::Level.mock(name: "高職").save
Edu::Level.mock(name: "大學").save
Edu::Level.mock(name: "研究所").save
Edu::Level.mock(name: "社會人士").save
Edu::Level.mock(name: "資訊專業人士").save

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
Location.mock(name: "金門縣").save
Location.mock(name: "連江縣").save

class << self
  def holder_val data
    data = "" unless data
    case data
    when "國立" then hv = Holder.find_by(name: data)
    when "縣立" then hv = Holder.find_by(name: data)
    when "市立" then hv = Holder.find_by(name: data)
    else
      hv = Holder.find_by(name: "私立")
    end
    hv
  end

  def level_val kls
    km = { ele: "國小", sen: "國中", jun: "高中", voc: "高職", uni: "大學"}
    Edu::Level.find_by(name: km[kls])
  end

  @@kls_reg = {
    ele: /(?<holder>國立|市立|私立|財團法人|天主教|縣立)(?<name>\D{2,8})(?<level>小學|國小|小|國\(中\)小)/,
    jun: /(?<holder>國立|市立|私立|財團法人|天主教|縣立)(?<name>\D{2,8})(?<level>中學|國中|國\(小\)中)/,
    sen: /(?<holder>國立|市立|私立|財團法人|天主教|縣立)(?<name>\D{2,9})(?<level>中學|女中|高中|附中|一中|二中)/,
    voc: /(?<holder>國立|市立|私立|財團法人)(?<name>\D{2,8})(?<level>高農|高工|餐旅|附工|家職|商水|海事水產|海事|農工|高商|商工|家商|工商|工家|商海|附農|工農|護家|餐飲|藝校)/,
    uni: /(?<holder>國立)?(?<name>\D{2,8})(?<level>大學|學院|專科學校)/,
  }

  def create_school row, kls
    rg = @@kls_reg[kls].match(row["name"])
    ss = School.mock(moeid: row["moeid"], name: row["name"])
    ss.holder = holder_val(rg[:holder])
    ss.level = level_val(kls)
    ss.loc = Edu::Loc.find_by(name: row["county"][4..-1])
    ss.save
    ss
  end

  def get_file(kls, region, year)
    "db/seeds/data/#{kls}_#{region}_#{year}.txt"
  end

  def seed_school(kls, region, year) # "ele", "jun", "sen", "voc", "uni"
    fs = get_file(kls, region, year)
    cnt = 0
    CSV.read(fs, headers: true, col_sep: "\t").each do |row|
      cnt += 1
      st = create_school row, kls.to_sym
      if !st
        puts "---> #{cnt}:#{row["name"]}- #{st.errors.messages}"
      end
    end
  end
end

seed_school "ele", "tw", 2014
seed_school "jun", "tw", 2014
seed_school "sen", "tw", 2014
seed_school "voc", "tw", 2014
seed_school "uni", "tw", 2014
