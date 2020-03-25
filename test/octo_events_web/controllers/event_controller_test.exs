defmodule OctoEventsWeb.EventControllerTest do
  use OctoEventsWeb.ConnCase, async: true

  import OctoEvents.Factory

  describe "create/2" do
    setup %{conn: conn} do
      %{conn: conn, path: "api/v1/events"}
    end

    test "returns 201 when issue_event is created successfully", %{conn: conn, path: path} do
      params = %{
        "payload" => %{
          "action" => "open",
          "issue" => string_params_for(:issue)
        }
      }

      conn = conn
        |> put_req_header("http_x_github_event", "issue")
        |> post(path, params)

      assert %{"status" => "ok", "data" => _} = json_response(conn, 201)
    end

    test "returns 200 when receive ping request", %{conn: conn, path: path} do
      params = %{
        "payload" => %{
          "action" => "open",
          "issue" => string_params_for(:issue)
        }
      }

      conn = conn
        |> put_req_header("http_x_github_event", "ping")
        |> post(path, params)

      assert json_response(conn, 200)
    end

    test "return 422 when params are invalid", %{conn: conn, path: path} do
      params = %{
        "payload" => %{
        }
      }

      conn = conn
        |> put_req_header("http_x_github_event", "issue")
        |> post(path, params)

      assert %{"status" => "unprocessable entity"} = json_response(conn, 422)
    end

    test "return 422 when when event type is not mapped", %{conn: conn, path: path} do
      params = %{
        "payload" => %{
          "action" => "open",
          "issue" => string_params_for(:issue)
        }
      }

      conn = conn
        |> put_req_header("http_x_github_event", "unexistent type")
        |> post(path, params)

      assert %{"status" => "unprocessable entity"} = json_response(conn, 422)
    end
  end
end
