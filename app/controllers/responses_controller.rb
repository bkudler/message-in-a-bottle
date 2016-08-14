class ResponsesController < ApplicationController

  def create
    @response = Response.new(permit_params)
    @response.user_id = current_user.id
    binding.pry
    if request.xhr?
      if @resonse.save
        render json: @response
      else
        flash[:error] = 'Something went wrong'
      end
    else
      flash[:error] = "Something went wrong"
      redirect_to '/static/index'
    end
  end

  private

  def permit_params
    params.require(:response).permit(:body, :entry_id, :user_id, :can_respond)
  end
end
