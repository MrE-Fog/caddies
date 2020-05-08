class ReportsController < ApplicationController
  def index
    @reports = Report.all
  end
  
  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private
    def report_params
      params.require(:report).permit(:caddy_id, :bags)
    end
end
