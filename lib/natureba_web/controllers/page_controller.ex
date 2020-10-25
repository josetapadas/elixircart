defmodule NaturebaWeb.PageController do
  use NaturebaWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end

  def get_current_time do
    DateTime.utc_now
    |> DateTime.to_string
    |> Base.encode16(case: :lower)
  end
end
