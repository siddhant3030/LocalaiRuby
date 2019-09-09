class HardWorker
    include Sidekiq::Worker
  
    def perform(user_params)
      begin
        User.create!(puts user_params)
      rescue Exception => e
        puts e.message
      end
    end
  end