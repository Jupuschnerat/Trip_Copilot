module RoutesHelper
  def button_to_favorite(route)
    if current_user.favorite_routes.include?(route)
      button_to "Remove from Favorites", favorite_path(route), method: :delete, remote: true
    else
      button_to "Add to Favorites", favorites_path(route_id: route.id), method: :post, remote: true
    end
  end
end
