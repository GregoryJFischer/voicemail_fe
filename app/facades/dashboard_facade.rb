class DashboardFacade
  attr_reader :user

  def initialize(user_id)
    user = BackendService.get_user(user_id)

    @user = User.new(user)
  end
end
