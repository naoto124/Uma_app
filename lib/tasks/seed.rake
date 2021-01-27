# namespace :seed do
#   desc 'Load the seed data from SEED_FILENAME'
#   # task :seed_from_file => 'db:abort_if_pending_migrations' do
#     seed_file = File.join(Rails.root, 'db', ENV['SEED_FILENAME'])
#     if File.exist?(seed_file)
#       puts "seeding -- #{ENV['SEED_FILENAME']}"
#       load(seed_file)
#     else
#       puts "the seed file does not exist."
#     end
#   # end
# end
