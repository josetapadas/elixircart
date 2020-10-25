defmodule NaturebaWeb.LayoutView do
  use NaturebaWeb, :view

  alias Natureba.Workers.CartAgent

  def cart_item_count(natureba_session) do
    current_cart =  CartAgent.get_cart(natureba_session)
    case current_cart[:count] do
      nil ->
        0
      count ->
        count
    end
  end

  def cart_price(natureba_session) do
    current_cart = CartAgent.get_cart(natureba_session)
    case current_cart[:total_price] do
      nil ->
        0
      total_price ->
        total_price
        |> Decimal.from_float()
        |> Decimal.round(2)
    end
  end
end
