class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth request.env["omniauth.auth"]
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message :notice, :success, kind: "Github" if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      #TODO: redirect to sign_up instead and pre fill form
      redirect_to root_path
    end
  end

  #TODO: implement, github does not have cancel authorization button
  def failure

  end
end
