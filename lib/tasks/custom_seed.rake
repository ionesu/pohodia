namespace :db do
  namespace :seed do
    namespace :admin do
      Dir[Rails.root.join('db', 'seeds', 'admin', '*.rb')].each do |filename|
        task_name = File.basename(filename, '.rb')
        desc "Seed " + task_name + ", based on the file with the same name in `db/seeds/*.rb`"
        task task_name.to_sym => :environment do
          load(filename) if File.exist?(filename)
        end
      end
    end

    namespace :guide do
      Dir[Rails.root.join('db', 'seeds', 'guide', '*.rb')].each do |filename|
        task_name = File.basename(filename, '.rb')
        desc "Seed " + task_name + ", based on the file with the same name in `db/guide/*.rb`"
        task task_name.to_sym => :environment do
          load(filename) if File.exist?(filename)
        end
      end
    end

    namespace :all do
      Dir[Rails.root.join('db', 'seeds', 'all', '*.rb')].each do |filename|
        task_name = File.basename(filename, '.rb')
        desc "Seed " + task_name + ", based on the file with the same name in `db/all/*.rb`"
        task task_name.to_sym => :environment do
          load(filename) if File.exist?(filename)
        end
      end
    end
  end
end