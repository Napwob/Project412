# frozen_string_literal: true

module UserActions
  extend ActiveSupport::Concern
  def go_job
    if (mana > 50) || (fatigue > 60)
      'Valera say: Jjob?... W-what is it?'
    else
      apply_stats(0, -30, 0, 30, 1250)
      'Valera say: Its been a hard day'
    end
  end

  def contemplate_nature
    apply_stats(0, -10, 1, -10, 0)
    'Valera say: I wandered lonely as a cloud'
  end

  def drink_wine_and_watch_tv_series
    if money < 200
      'Valera say: Sorry, out of money'
    else
      apply_stats(-5, 30, 1, 10, -200)
      'Valera say: Ta-ta-tadada-ta...'
    end
  end

  def go_to_the_bar
    if money < 250
      'Valera say: Sorry, out of money'
    else
      apply_stats(-10, 60, 2, 40, -250)
      'Valera say: Beer or not two beer?'
    end
  end

  def drink_with_marginal_people
    if money < 1500
      'Valera say: Sorry, out of money'
    else
      apply_stats(-80, 90, 5, 80, -1500)
      'Valera say: Oj, MOROZ MOROOOOOZ...'
    end
  end

  def sing_in_the_subway
    if fatigue > 80
      'Valera say: I need to sleep, not sing'
    elsif (mana > 30) && (mana < 60)
      apply_stats(0, 0, 0, 0, +50)
      'Valera say: Near, far, wherever you are...'
    else
      apply_stats(0, -10, 1, 20, +10)
      'Valera say: IM GONNA ROCK!!!'
    end
  end

  def sleep
    if mana < 40
      apply_stats(90, -50, 0, -70, 0)
      'Valera say: zZzZzZ...'
    else
      apply_stats(0, -50, -3, -70, 0)
      'Valera say: zzz...one more shot...zzz'
    end
  end
end
