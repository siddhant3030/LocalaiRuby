require "#{Rails.root}/app/workers/hard_worker"
class UsersController < ApplicationController
    def index
        render json: User.all
    end
    
    def create
        HardWorker.perform_async(user_params)
        render json: { message: 'working....'}, status: 200
    end

    private
    def user_params
        params.require(:user).permit(:name, :vechile_id)
    end
end
