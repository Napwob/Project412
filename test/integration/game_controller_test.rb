# frozen_string_literal: true

require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  before :each do
    User.create(email: 'user1@gmail.com', password: 'password', name: 'User1')
  end
  fixtures :all

  test 'should get index' do
    get '/users/sign_in'
    assert_response :success
  end
end
