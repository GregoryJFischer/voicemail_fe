class UserDashboardFacade
  attr_reader :representatives,
              :user

  def initialize(user_id)
    @representatives = BackendService.representatives(user_id)
    @user = BackendService.get_user(user_id)
  end
end
