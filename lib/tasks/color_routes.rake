desc 'Pretty version on rails rake routes.'

task :cdebug => :environment do
  EC.each do |e|
    puts tcolor(ct="fg", code=e) + "Test(#{e})" + tcolor(ct="bg", code=e) + "Test(#{e})" + cclr
  end
end

task :croutes => :environment do
  routes = make_routes
  widths = widths_of(routes)

  head = header(widths)
  rrender(routes, widths, head.size)
end

def make_routes
  Rails.application.reload_routes!
  all_routes = Rails.application.routes.routes.to_a
  all_routes.reject! { |route| route.defaults[:controller] && route.defaults[:controller].index("rails/") == 0 }
  all_routes.reject! { |route| route.verb.nil? || route.path.spec.to_s == '/assets' }
  all_routes.select! { |route| ENV['controller'].nil? || route.defaults[:controller].to_s == ENV['controller'] }
  all_routes.select! { |route| ENV['verb'].nil? || route.verb === ENV['verb'] }
  all_routes.select! { |route| ENV['path'].nil? || (route.path.spec.to_s.include? ENV['path']) }
  all_routes.select! { |route| ENV['action'].nil? || route.defaults[:action].to_s == ENV['action'] }
  all_routes
end

def widths_of routes
  {
    names: (routes.map { |route| route.name.to_s.length }.max),
    verbs: (6),
    paths: (routes.map { |route| route.path.spec.to_s.length }.max),
    controllers: (routes.map { |route| route.defaults[:controller].to_s.length }.max),
    actions: (routes.map { |route| route.defaults[:action].to_s.length }.max)
  }
end

def header align
  head = "#{'name'.rjust(align[:names])} | #{'verb'.center(align[:verbs])} | " +
  "#{'path'.ljust(align[:paths])} | #{'action'.ljust(align[:actions])}"
  puts tcolor("fg", "white") + head + cclr
  head
end

def rrender routes, align, header_w
  cr = tcolor("fg", "red")
  cb = tcolor("fg", "blue")
  cc = tcolor("bg", "cyan") + tcolor("fg", "blue")
  routes.group_by { |route| route.defaults[:controller] }.each_value do |group|
    cs = group.first.defaults[:controller].to_s
    puts cc + "CTLR: " + tcolor("fg", "megneta") + cs + ' '.ljust(header_w - 5 - cs.size) + cclr
    group.each do |route|
      name = tcolor("fg", "brown") + route.name.to_s.rjust(align[:names]) + cclr
      verb = tcolor("fg", "yellow") + route.verb.inspect.gsub(/^.{2}|.{2}$/, "").center(align[:verbs]) + cclr
      ps = route.path.spec.to_s.ljust(align[:paths]).gsub(/\.?:\w+/){|s| cb + s + cr }
      path = cr + ps + cclr
      action = tcolor("fg", "white") + route.defaults[:action].to_s.ljust(align[:actions]) + cclr

      puts "#{name} | #{verb} | #{path} | #{action}"
    end
  end
end

EC=%w(black red brown yellow blue megneta cyan white aa clear)

def cclr
  tcolor(ct="fg", code="clear") + tcolor(ct="bg", code="clear")
end

def tcolor(ct="fg", code="clear")
  ec = EC.index(code)
  ct == "fg" ? "\e[1;3#{ec}m" : "\e[1;4#{ec}m"
end
