# frozen_string_literal: true

class GameController < ApplicationController
  def index
    if user_session.nil?
      render plain: 'Error! You not authorized.', status: :unauthorized
      return
    end

    check_end_game
  end

  def check_end_game
    result = current_user.check_win_lose

    if result == ''
      @is_lose = false
    else
      flash.notice = result
      @is_lose = true
    end
  end

  def new_game
    current_user.init_stats

    redirect_to '/game'
  end

  def go_job
    flash.notice = current_user.go_job
    redirect_to '/game'
  end

  def contemplate_nature
    flash.notice = current_user.contemplate_nature
    redirect_to '/game'
  end

  def drink_wine_and_watch_tv_series
    flash.notice = current_user.drink_wine_and_watch_tv_series
    redirect_to '/game'
  end

  def go_to_the_bar
    flash.notice = current_user.go_to_the_bar
    redirect_to '/game'
  end

  def drink_with_marginal_people
    flash.notice = current_user.drink_with_marginal_people
    redirect_to '/game'
  end

  def sing_in_the_subway
    flash.notice = current_user.sing_in_the_subway
    redirect_to '/game'
  end

  def sleep
    flash.notice = current_user.sleep
    redirect_to '/game'
  end
end
