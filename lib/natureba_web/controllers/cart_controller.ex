defmodule NaturebaWeb.CartController do
  use NaturebaWeb, :controller

  alias Natureba.{ Store, Carts }
  alias Natureba.Workers.CartAgent

  def update(%{ assigns: %{ natureba_session: natureba_session } } = conn, %{ "id" => id }) do
    product = Store.get_product!(id)
    Carts.add(natureba_session, product)

    conn
    |> put_flash(:info, "Product added to your cart")
    |> redirect(to: Routes.product_path(conn, :index))
  end

  @spec delete(Plug.Conn.t(), map) :: Plug.Conn.t()
  def delete(%{ assigns: %{ natureba_session: natureba_session } } = conn, %{ "id" => id }) do
    product = Store.get_product!(id)
    CartAgent.delete_item(natureba_session, product)

    conn
    |> put_flash(:info, "Product removed from your cart")
    |> redirect(to: Routes.product_path(conn, :index))
  end
end
