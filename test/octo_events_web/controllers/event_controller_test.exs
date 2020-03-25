defmodule OctoEventsWeb.EventControllerTest do
  use OctoEventsWeb.ConnCase, async: true

  describe "create/2" do
    setup %{conn: conn} do
      %{conn: conn, path: "api/v1/events"}
    end

    test "returns 201 when issue_event is created successfully", %{conn: conn, path: path} do
      params = %{
        "payload" =>
          File.read!(Path.expand("../../support/fixtures/payload/issue_event.json", __DIR__))
      }

      conn =
        conn
        |> put_req_header("x-github-event", "issues")
        |> post(path, params)

      assert %{"status" => "ok", "data" => _} = json_response(conn, 201)
    end

    test "returns 200 when receive ping request", %{conn: conn, path: path} do
      params = %{
        "payload" =>
          File.read!(Path.expand("../../support/fixtures/payload/issue_event.json", __DIR__))
      }

      conn =
        conn
        |> put_req_header("x-github-event", "ping")
        |> post(path, params)

      assert json_response(conn, 200)
    end

    test "return 422 when params are invalid", %{conn: conn, path: path} do
      params = %{
        "payload" => Jason.encode!(%{wrong: :argumentss})
      }

      conn =
        conn
        |> put_req_header("x-github-event", "issues")
        |> post(path, params)

      assert %{"status" => "unprocessable entity"} = json_response(conn, 422)
    end

    test "return 422 when event type is not mapped", %{conn: conn, path: path} do
      params = %{
        "payload" =>
          File.read!(Path.expand("../../support/fixtures/payload/issue_event.json", __DIR__))
      }

      conn =
        conn
        |> put_req_header("x-github-event", "unexistent type")
        |> post(path, params)

      assert %{"status" => "unprocessable entity"} = json_response(conn, 422)
    end
  end
end
