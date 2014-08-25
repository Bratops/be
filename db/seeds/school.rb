
def holder_val data
  val = :unknown
  case data
  when '國立' then val = :national
  when '縣立' then val = :county
  when '市立' then val = :municipal
  when '財團法人' then val = :private
  when '天主教' then val = :private
  when '私立' then val = :private
  else val = :unknown
  end
end

def level_val data
  val = :unknown
  rs = /(高農|高工|餐旅|附工|家職|商水|海事水產|海事|農工|高商|商工|家商|工商|工家|商海|工農|護家|餐飲|藝校)/.match(data)
  val = :vocational unless rs.nil?
  rs = /(中學|女中|高中|附中|一中|二中)/.match(data)
  val = :senior unless rs.nil?
  val
end

def local_val data
  res = School.location.options.select{ |l| l[0] == data }
  if res.nil?
    puts "#{data} make nil value"
    return
  end
  res[0][1]
end

def seed_school klass
  item = [ { fname: 'hs_list', reg: /(?<holder>國立|市立|私立|財團法人|天主教|縣立)(?<name>\D{2,8})(?<level>中學|女中|高中|附中|一中|二中)/},
           { fname: 'hv_list', reg: /(?<holder>國立|市立|私立|財團法人)(?<name>\D{2,8})(?<level>高農|高工|餐旅|附工|家職|商水|海事水產|海事|農工|高商|商工|家商|工商|工家|商海|工農|護家|餐飲|藝校)/}
        ]
  gk = item[klass]
  cnt = 1
  File.open("db/seeds/raw/#{gk[:fname]}.txt", "r").each_line do |ln|
    I18n.locale = :zh_TW
    data = ln.chomp.split(/,| |\t/)
    rk = gk[:reg].match(data[1])
    ss = School.new( moeid: data[0],
                    holder: holder_val(rk[:holder]),
                    level: level_val(rk[:level]),
                    name: data[1],
                    location: local_val(data[2][4..-1]))
    #puts "[#{cnt}] #{ss.fancy_name}: #{ss.valid?}"
    cnt = cnt +1
    if ss.save then next else
      puts "[#{cnt}:#{data[1]}]Errrrrrrrrrrrrrr..."
    end
  end
end

def print_yes
  puts 'oh yes'
end
