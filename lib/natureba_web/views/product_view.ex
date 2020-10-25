defmodule NaturebaWeb.ProductView do
  use NaturebaWeb, :view
  alias Natureba.Workers.CartAgent

  def in_cart?(current_session, product_id) do
    current_cart = CartAgent.get_cart(current_session)
    if current_cart[:items] do
      current_cart[:items]
      |> Map.keys()
      |> Enum.member?(:"#{product_id}")
    else
      false
    end
  end
end
