class Admin::DemoNightsController < Admin::BaseController
  before_action :check_active_demo_nights, only: :create

  def index
    demo_nights = DemoNight.all
    @inactives = demo_nights.where(status: "closed")
    @currents = demo_nights.where.not(status: "closed")
  end

  def new
    @demo_night = DemoNight.new
  end

  def show
    @demo_night = DemoNight.find(params[:id])
  end

  def create
    dn = DemoNight.new(demo_night_params!)
    if dn.save
      redirect_to admin_demo_night_path(dn)
    else
      render :new
    end
  end

  private

  def demo_night_params!
    params.require(:demo_night).permit(:name, :active)
  end

  def check_active_demo_nights
    if !DemoNight.pluck(:status).all? { |status| status == "closed" }
      flash[:danger] = "There can only be 1 active demo night at a time."
      redirect_to admin_demo_nights_path
    end
  end
end
