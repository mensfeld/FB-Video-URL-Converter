# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fb_video_url_converter}
  s.version = "0.2.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Maciej Mensfeld}]
  s.date = %q{2011-07-03}
  s.description = %q{Facebook Video URL Converter is intended as an easy alternative to changing video hosting from Facebook to a different one.}
  s.email = %q{maciej@mensfeld.pl}
  s.extra_rdoc_files = [%q{CHANGELOG.rdoc}, %q{README.md}, %q{lib/facebook_bot.rb}, %q{lib/facebook_video.rb}, %q{lib/fb_video_url_converter.rb}, %q{lib/generators/fb_video_url_converter/install_generator.rb}, %q{lib/generators/fb_video_url_converter/templates/create_facebook_videos_migration.rb}, %q{lib/generators/fb_video_url_converter/templates/facebook_video_converter_init.rb}]
  s.files = [%q{CHANGELOG.rdoc}, %q{Gemfile}, %q{MIT-LICENSE}, %q{README.md}, %q{Rakefile}, %q{fb_video_url_converter.gemspec}, %q{init.rb}, %q{lib/facebook_bot.rb}, %q{lib/facebook_video.rb}, %q{lib/fb_video_url_converter.rb}, %q{lib/generators/fb_video_url_converter/install_generator.rb}, %q{lib/generators/fb_video_url_converter/templates/create_facebook_videos_migration.rb}, %q{lib/generators/fb_video_url_converter/templates/facebook_video_converter_init.rb}, %q{spec/facebook_bot_spec.rb}, %q{spec/facebook_video_spec.rb}, %q{spec/spec_helper.rb}, %q{Manifest}]
  s.homepage = %q{https://github.com/mensfeld/FB-Video-URL-Converter}
  s.rdoc_options = [%q{--line-numbers}, %q{--inline-source}, %q{--title}, %q{Fb_video_url_converter}, %q{--main}, %q{README.md}]
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{fb_video_url_converter}
  s.rubygems_version = %q{1.8.5}
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
