class UsersController < ApplicationController
  skip_before_filter  :verify_authenticity_token, only: [:create, :login]

  def create
    @user = User.new(first: params['first'],
                     last: params['last']
                     email: params['email'],
                     password: params['password'])
    @user.ensure_auth_token
    if @user.save
      render "create.json.jbuilder", status: :ok
    else
      render json: { errors: @user.errors.full_messages },
                     status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by!(email: params["email"])
    if @user.authenticate(params["password"])
      render json: { user: @user.as_json(only: [:email, :auth_token]) },
          status: :ok
    else
      render json: { message: "INVALID EMAIL OR PASSWORD."},
          status: :unauthorized
    end
  end
end
