class Admin::LightningTalksController < Admin::BaseController
  before_action :check_active_lightning_talks, only: :create
  before_action :check_active_for_update, only: :update

  def index
    @lightning_talks = LightningTalk.all
  end

  def new
    @lightning_talk = LightningTalk.new
  end

  def show
    @lightning_talk = LightningTalk.find(params[:id])
  end

  def create
    dn = LightningTalk.new(lightning_talk_params!)
    dn.final_date = format_date(params[:lightning_talk][:final_date])
    if dn.save
      redirect_to admin_lightning_talk_path(dn)
    else
      render :new
    end
  end

  def update
    dn = LightningTalk.find(params[:id])
    if params[:lightning_talk][:final_date]
      dn.final_date = format_date(params[:lightning_talk][:final_date])
    end

    if dn.update(lightning_talk_params!)
      flash[:success] = "#{dn.name} now #{dn.status.humanize.downcase}"
      redirect_to admin_lightning_talks_path
    else
      flash[:failure] = "Something went wrong"
      redirect_to admin_lightning_talk_path(dn)
    end
  end

  private

  def lightning_talk_params!
    params.require(:lightning_talk).permit(:name, :status, :final_date)
  end

  def check_active_lightning_talks
    if LightningTalk.all.currents.any?
      flash[:danger] = "There can only be 1 active demo night at a time."
      redirect_to admin_lightning_talks_path
    end
  end

  def check_active_for_update
    if LightningTalk.currents.any?
      if LightningTalk.current.id != params[:id].to_i
        flash[:danger] = "There can only be 1 active demo night at a time."
        redirect_to admin_lightning_talks_path
      end
    end
  end

  def format_date(date)
    month, day, year = date.split('/')
    [year, month, day].join
  end
end
