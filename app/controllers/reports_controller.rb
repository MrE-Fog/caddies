require 'date'

class ReportsController < ApplicationController
  def index
    @two_bags = Report.where(bags: 2).where(round_at: Date.today)
    @three_bags = Report.where(bags: 3).where(round_at: Date.today)
    @four_bags = Report.where(bags: 4).where(round_at: Date.today)

    @q=Report.ransack(params[:q])
    @reports=@q.result(distinct: true)
  end
  
  def new
    @report = Report.new
  end

  def create
    # @report = Report.new(report_params)
    # binding.pry
    @report = Report.new(caddy_id: report_params[:caddy_id], bags: report_params[:bags], user_id: current_user.id, round_at: Date.today)
    if @report.save(user_id: current_user.id)
      redirect_to reports_path
    else
      render 'new'
    end
  end
  def search
    @q = Report.search(search_params)
    @reports = @q.result(distinct: true)
  end

  private
    def report_params
      params.require(:report).permit(:caddy_id, :bags,)
    end
    def search_params
      params.require(:q).permit!
    end
end