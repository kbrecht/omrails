namespace :db do 
	desc "Testing populator"
	task :populate => :environment do
		require 'populator'
		require 'faker'

		User.populate 5 do |user|
			user.name = Faker::Name.name
			user.email = Faker::Internet.email
			user.encrypted_password = 'foo'
			Pin.populate 10 do |pin|
				pin.description = Populator.words(1..5).titleize
				pin.user_id = user.id
				pin.created_at = 2.years.ago..Time.now
			end
		end

		Pin.all.each { |pin| pin.image = File.open(Dir.glob(File.join(Rails.root, 'sampleimages', '*')).sample); pin.save! }
	end
end

