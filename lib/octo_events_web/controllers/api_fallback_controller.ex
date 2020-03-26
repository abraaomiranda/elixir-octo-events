defmodule OctoEventsWeb.ApiFallbackController do
  use OctoEventsWeb, :controller

  def call(conn, {:check, :alive}) do
    conn
    |> json("I'm alive")
  end

  def call(conn, {:error, :unmapped}) do
    conn
    |> put_status(:unprocessable_entity)
    |> json(%{status: "Unmapped event type"})
  end

  def call(conn, {:error, %Ecto.Changeset{}}) do
    conn
    |> put_status(:unprocessable_entity)
    |> json(%{status: "Unprocessable entity"})
  end

  def call(conn, {:error, _}) do
    conn
    |> put_status(:unprocessable_entity)
    |> json(%{status: "Unprocessable entity"})
  end
end
