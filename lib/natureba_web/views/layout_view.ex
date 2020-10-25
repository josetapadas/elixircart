defmodule NaturebaWeb.LayoutView do
  use NaturebaWeb, :view

  alias Natureba.Workers.CartAgent

  def cart_item_count(natureba_session) do
    case CartAgent.get_cart(natureba_session) do
      nil ->
        0
      cart ->
        Enum.count(cart)
    end
  end
end
