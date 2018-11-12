
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sheet_converter/version"

Gem::Specification.new do |spec|
  spec.name          = "sheet_converter"
  spec.version       = SheetConverter::VERSION
  spec.authors       = ["ug0"]
  spec.email         = ["ug600@icloud.com"]

  spec.summary       = %q{Convert sheets(XLSX, CSV and more...)}
  spec.homepage      = "https://github.com/ug0/sheet_converter"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.20"
  spec.add_dependency "roo", "~> 2.7.0"
  spec.add_dependency 'axlsx', '>= 3.0.0.pre'
  spec.add_dependency "spreadsheet_architect"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "byebug"
end
