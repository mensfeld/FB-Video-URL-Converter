# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fb_video_url_converter}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Maciej Mensfeld"]
  s.date = %q{2011-06-01}
  s.description = %q{Facebook Video URL Converter is intended as an easy alternative to changing video hosting from Facebook to a different one.}
  s.email = %q{maciej@mensfeld.pl}
  s.extra_rdoc_files = ["CHANGELOG.rdoc", "README.md", "lib/facebook_bot.rb", "lib/facebook_video.rb", "lib/fb_video_url_converter.rb", "lib/generators/fb_video_url_converter/install_generator.rb", "lib/generators/fb_video_url_converter/templates/create_facebook_videos_migration.rb", "lib/generators/fb_video_url_converter/templates/facebook_video_converter_init.rb"]
  s.files = ["CHANGELOG.rdoc", "Gemfile", "MIT-LICENSE", "README.md", "Rakefile", "fb_video_url_converter.gemspec", "init.rb", "lib/facebook_bot.rb", "lib/facebook_video.rb", "lib/fb_video_url_converter.rb", "lib/generators/fb_video_url_converter/install_generator.rb", "lib/generators/fb_video_url_converter/templates/create_facebook_videos_migration.rb", "lib/generators/fb_video_url_converter/templates/facebook_video_converter_init.rb", "spec/facebook_bot_spec.rb", "spec/facebook_video_spec.rb", "spec/spec_helper.rb", "Manifest"]
  s.homepage = %q{https://github.com/mensfeld/FB-Video-URL-Converter}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Fb_video_url_converter", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{fb_video_url_converter}
  s.rubygems_version = %q{1.5.2}
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
