module Requester
  def menu_action(option)
    menus = {
      main_menu: "random | scores | exit".colorize(mode: :italic, color: :cyan)
    }
    menus[option]
  end
end