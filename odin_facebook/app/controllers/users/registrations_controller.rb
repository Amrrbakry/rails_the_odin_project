class Users::RegistrationsController < Devise::RegistrationsController


  def create
    super
    UserMailer.welcome(resource).deliver unless resource.invalid?
  end



  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
