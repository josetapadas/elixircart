defmodule NaturebaWeb.Plugs.SetSession do
  import Plug.Conn

  def init(_args) do
  end

  def call(conn, _args) do
    if current_session = get_session(conn, :natureba_session) do
      assign(conn, :natureba_session, current_session)
    else
      new_session_id = generate_session_id()

      conn
      |> put_session(:natureba_session, new_session_id)
      |> assign(:natureba_session, new_session_id)
    end
  end

  def generate_session_id do
    DateTime.utc_now
    |> DateTime.to_string
    |> generate_random_string()
    |> Base.encode16(case: :lower)
  end

  def generate_random_string(date) do
    "#{date}-#{:rand.uniform(1984)}"
  end
end
