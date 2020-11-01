defmodule Natureba.Workers.CartAgent do
  use Agent

  require Logger

  @spec start_link(any) :: {:error, any} | {:ok, pid}

  def start_link({ cart_id, item }) do
    Agent.start_link(fn -> append_item(%{}, cart_id, item) end, name: via_tuple(cart_id) )
  end

  def add_item(cart_id, item) do
    Agent.cast(via_tuple(cart_id), fn(state) -> append_item(state, cart_id, item) end)
  end

  defp append_item(state, cart_id, item) do
    Map.update(
        state,
        cart_id,
        %{
          items: %{ "#{item.id}": 1 },
          total_price: item.price,
          count: 1
        },
        fn current_state ->
          new_count = if Map.has_key?(current_state[:items], :"#{item.id}"), do: current_state[:items][:"#{item.id}"] + 1, else: 1

          Map.merge(
            current_state,
            %{
              items: Map.merge(current_state[:items], %{ "#{item.id}": new_count }),
              count: current_state[:count] + 1,
              total_price: current_state[:total_price] + item.price
            }
          )
        end
      )
  end

  def delete_item(cart_id, item) do
    Agent.update(via_tuple(cart_id), fn(state) ->
      Map.update(
        state,
        cart_id,
        %{},
        fn current_state ->
          if !Map.has_key?(current_state, :items) or (Map.has_key?(current_state, :items) and !Map.has_key?(current_state[:items], :"#{item.id}")) do
            current_state
          else
            new_count = current_state[:items][:"#{item.id}"] - 1

            if new_count < 1 do
              Map.merge(
                current_state,
                %{
                  items: Map.drop(current_state[:items], [:"#{item.id}"]),
                  count: current_state[:count] - 1,
                  total_price: current_state[:total_price] - item.price
                }
              )
            else
              Map.merge(
              current_state,
              %{
                items: Map.merge(current_state[:items], %{ "#{item.id}": new_count }),
                count: current_state[:count] - 1,
                total_price: current_state[:total_price] - item.price
              }
            )
            end
          end
        end
      )
    end)
  end

  def get_cart(cart_id) do
    Agent.get(via_tuple(cart_id), fn(state) -> state[cart_id] end)
  end

  defp via_tuple(cart_id) do
    {:via, Registry, {:cart_registry, cart_id}}
  end
end
