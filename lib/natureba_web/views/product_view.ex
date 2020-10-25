defmodule NaturebaWeb.ProductView do
  use NaturebaWeb, :view

  alias Natureba.Workers.CartAgent

  def in_cart?(current_session, product_id) do
    current_session
    |> existing_product_ids()
    |> Enum.member?(product_id)
  end

  defp existing_product_ids(current_session) do
    case CartAgent.get_cart(current_session) do
      nil ->
        []
      cart ->
        Enum.map(cart, fn(element) -> element.id end)
    end
  end
end
