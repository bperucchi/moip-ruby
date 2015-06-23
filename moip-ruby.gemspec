# $:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "moip-ruby"
  s.version     = "0.1.2"
  s.authors     = ["Breno Perucchi"]
  s.email       = ["bperucchi@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of ImentoreUser."
  s.description = "Description of ImentoreUser."

  s.files = Dir["{lib}/**/*"] + ["Rakefile", "README.markdown"]

  s.add_dependency(%q<rspec>, ["~> 2.1.0"])
  s.add_dependency(%q<nokogiri>, ["~> 1.5.2"])
  s.add_dependency(%q<httparty>, ["~> 0.8.3"])
  s.add_dependency(%q<activesupport>, [">= 3.2.3"])
end
