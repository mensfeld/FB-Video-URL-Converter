# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fb_video_url_converter}
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Maciej Mensfeld"]
  s.cert_chain = ["/home/mencio/.cert_keys/gem-public_cert.pem"]
  s.date = %q{2011-05-05}
  s.description = %q{Facebook Video URL Converter is intended as an easy alternative to changing video hosting from Facebook to a different one.}
  s.email = %q{maciej@mensfeld.pl}
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "README.md", "lib/facebook_bot.rb", "lib/facebook_video.rb", "lib/fb_video_url_converter.rb"]
  s.files = ["CHANGELOG.rdoc", "Gemfile", "MIT-LICENSE", "Manifest", "README.md", "Rakefile", "init.rb", "lib/facebook_bot.rb", "lib/facebook_video.rb", "lib/fb_video_url_converter.rb", "spec/facebook_bot_spec.rb", "spec/facebook_video_spec.rb", "spec/spec_helper.rb", "fb_video_url_converter.gemspec"]
  s.homepage = %q{https://github.com/mensfeld/FB-Video-URL-Converter}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Fb_video_url_converter", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{fb_video_url_converter}
  s.rubygems_version = %q{1.5.2}
  s.signing_key = %q{/home/mencio/.cert_keys/gem-private_key.pem}
  s.summary = %q{Facebook Video URL Converter is intended as an easy alternative to changing video hosting from Facebook to a different one.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 0"])
      s.add_runtime_dependency(%q<mechanize>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
    else
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<mechanize>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<mechanize>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
  end
end
