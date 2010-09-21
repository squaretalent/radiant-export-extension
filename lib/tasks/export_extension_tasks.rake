namespace :radiant do
  namespace :extensions do
    namespace :export do

      desc "Dump schema and data to db/schema.rb and db/data.yml"
      task(:dump => [ "db:schema:dump", "db:data:dump" ])

      desc "Load schema and data from db/schema.rb and db/data.yml"
      task(:load => [ "db:schema:load", "db:data:load" ])

      namespace :data do
        def db_dump_data_file (extension = "yml")
          "#{dump_dir}/data.#{extension}"
        end

        def dump_dir(dir = "")
          "#{RAILS_ROOT}/db#{dir}"
        end

        desc "Dump contents of database to db/data.extension (defaults to yaml)"
        task :dump => :environment do
          format_class = ENV['class'] || "YamlDb::Helper"
          helper = format_class.constantize
          SerializationHelper::Base.new(helper).dump db_dump_data_file helper.extension
        end

        desc "Dump contents of database to curr_dir_name/tablename.extension (defaults to yaml)"
        task :dump_dir => :environment do
          format_class = ENV['class'] || "YamlDb::Helper"
          dir = ENV['dir'] || "#{Time.now.to_s.gsub(/ /, '_')}"
          SerializationHelper::Base.new(format_class.constantize).dump_to_dir dump_dir("/#{dir}")
        end

        desc "Load contents of db/data.extension (defaults to yaml) into database"
        task :load => :environment do
          format_class = ENV['class'] || "YamlDb::Helper"
          helper = format_class.constantize
          SerializationHelper::Base.new(helper).load (db_dump_data_file helper.extension)
        end

        desc "Load contents of db/data_dir into database"
        task :load_dir  => :environment do
          dir = ENV['dir'] || "base"
          format_class = ENV['class'] || "YamlDb::Helper"
          SerializationHelper::Base.new(format_class.constantize).load_from_dir dump_dir("/#{dir}")
        end
      end
      
      desc "Runs the migration of the Export extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          ExportExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          ExportExtension.migrator.migrate
        end
        Rake::Task['db:schema:dump'].invoke
      end
      
      desc "Copies public assets of the Export to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from ExportExtension"
        Dir[ExportExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(ExportExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory, :verbose => false
          cp file, RAILS_ROOT + path, :verbose => false
        end
        unless ExportExtension.root.starts_with? RAILS_ROOT # don't need to copy vendored tasks
          puts "Copying rake tasks from ExportExtension"
          local_tasks_path = File.join(RAILS_ROOT, %w(lib tasks))
          mkdir_p local_tasks_path, :verbose => false
          Dir[File.join ExportExtension.root, %w(lib tasks *.rake)].each do |file|
            cp file, local_tasks_path, :verbose => false
          end
        end
      end  
      
      desc "Syncs all available translations for this ext to the English ext master"
      task :sync => :environment do
        # The main translation root, basically where English is kept
        language_root = ExportExtension.root + "/config/locales"
        words = TranslationSupport.get_translation_keys(language_root)
        
        Dir["#{language_root}/*.yml"].each do |filename|
          next if filename.match('_available_tags')
          basename = File.basename(filename, '.yml')
          puts "Syncing #{basename}"
          (comments, other) = TranslationSupport.read_file(filename, basename)
          words.each { |k,v| other[k] ||= words[k] }  # Initializing hash variable as empty if it does not exist
          other.delete_if { |k,v| !words[k] }         # Remove if not defined in en.yml
          TranslationSupport.write_file(filename, basename, comments, other)
        end
      end
      
    end
  end
end