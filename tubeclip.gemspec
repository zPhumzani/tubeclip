# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tubeclip/version'

Gem::Specification.new do |spec|
  spec.name          = "tubeclip"
  spec.version       = Tubeclip::VERSION
  spec.authors       = ["zPhumzani"]
  spec.email         = ["zphumzani@gmail.com"]

  spec.summary       = %q{Upload, delete, update, comment on youtube videos all from one gem.}
  spec.description   = %q{Ruby wrapper for youtube api's. Upload, delete, update, comment on youtube videos all from one gem}
  spec.homepage      = "https://github.com/zPhumzani/tubeclip"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency("nokogiri", "~> 1.6", ">= 1.6.8.1")
  spec.add_runtime_dependency("oauth", "~> 0.5.1")
  spec.add_runtime_dependency("oauth2", "~> 1.2")
  spec.add_runtime_dependency("simple_oauth", "~> 0.3.1")
  spec.add_runtime_dependency("faraday", ['>= 0.8', '< 0.10'])
  spec.add_runtime_dependency("bundler", "~> 1.13")
  spec.add_runtime_dependency("excon")
  spec.add_runtime_dependency("json", "~> 2.0", ">= 2.0.2")
  spec.add_development_dependency("webmock")
end
