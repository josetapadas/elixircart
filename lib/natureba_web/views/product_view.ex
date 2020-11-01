defmodule NaturebaWeb.ProductView do
  use NaturebaWeb, :view
  alias Natureba.Carts

  def in_cart?(current_session, product_id) do
    current_cart = Carts.get(current_session)
    if current_cart[:items] do
      current_cart[:items]
      |> Map.keys()
      |> Enum.member?(:"#{product_id}")
    else
      false
    end
  end
end
