defmodule OctoEventsWeb.IssueEventControllerTest do
  use OctoEventsWeb.ConnCase, async: true

  import OctoEvents.Factory

  describe "index/2" do
    setup %{conn: conn} do
      conn = OctoEvents.BasicAuthHelper.using_basic_auth(conn)

      %{conn: conn}
    end

    test "returns 200 when found the issue", %{conn: conn} do
      issue = insert(:issue)

      conn = get(conn, "api/v1/issues/#{issue.number}/events")

      assert %{"status" => "ok", "data" => _} = json_response(conn, 200)
    end

    test "returns 404 when the issue does not exist", %{conn: conn} do
      conn = get(conn, "api/v1/issues/-1/events")

      assert json_response(conn, 404)
    end
  end
end
