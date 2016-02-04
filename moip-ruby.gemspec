# $:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "moip-ruby"
  s.version     = "0.1.3"
  s.authors     = ["Breno Perucchi"]
  s.email       = ["bperucchi@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of ImentoreUser."
  s.description = "Description of ImentoreUser."

  s.files = Dir["{lib}/**/*"] + ["Rakefile", "README.markdown"]

  s.add_dependency(%q<rspec>)
  s.add_dependency(%q<nokogiri>)
  s.add_dependency(%q<httparty>)
  s.add_dependency(%q<activesupport>)
end
