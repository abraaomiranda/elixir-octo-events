defmodule OctoEvents.BasicAuthHelper do
  @moduledoc """
    BasicAuthHelper
  """

  @username Application.get_env(:octo_events, :authentication)[:username]
  @password Application.get_env(:octo_events, :authentication)[:password]

  def using_basic_auth(conn, username \\ @username, password \\ @password) do
    header_content = "Basic " <> Base.encode64("#{username}:#{password}")
    conn |> Plug.Conn.put_req_header("authorization", header_content)
  end
end
