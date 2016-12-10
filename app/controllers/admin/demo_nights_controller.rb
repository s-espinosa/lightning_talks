class Admin::DemoNightsController < Admin::BaseController

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
end
