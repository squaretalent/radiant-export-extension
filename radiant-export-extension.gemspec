# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{radiant-export-extension}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dirk Kelly"]
  s.date = %q{2010-09-21}
  s.description = %q{An extension version of yaml_db which exports schemas in order to support extension migrations}
  s.email = %q{dk@squaretalent.com}
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "README.md",
     "Rakefile",
     "VERSION",
     "about.yml",
     "export_extension.rb",
     "lib/csv_db.rb",
     "lib/serialization_helper.rb",
     "lib/tasks/yaml_db_tasks.rake",
     "lib/yaml_db.rb",
     "spec/base.rb",
     "spec/serialization_helper_base_spec.rb",
     "spec/serialization_helper_dump_spec.rb",
     "spec/serialization_helper_load_spec.rb",
     "spec/serialization_utils_spec.rb",
     "spec/yaml_dump_spec.rb",
     "spec/yaml_load_spec.rb",
     "spec/yaml_utils_spec.rb"
  ]
  s.homepage = %q{http://github.com/squaretalent/radiant-export-extension}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Export Extension for Radiant CMS}
  s.test_files = [
    "spec/base.rb",
     "spec/serialization_helper_base_spec.rb",
     "spec/serialization_helper_dump_spec.rb",
     "spec/serialization_helper_load_spec.rb",
     "spec/serialization_utils_spec.rb",
     "spec/yaml_dump_spec.rb",
     "spec/yaml_load_spec.rb",
     "spec/yaml_utils_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
