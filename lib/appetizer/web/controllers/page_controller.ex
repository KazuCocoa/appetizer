defmodule Appetizer.Web.PageController do
  use Appetizer.Web, :controller

  @issue_type ["Bug", "Feature Resuest"]
  @platform ["Android", "iOS", "Web"]

  @input_validate_fields ["issue_type", "platform", "title", "steps"]

  def index(conn, _params) do
    render conn, "index.html", fields: [platform: @platform, issue_type: @issue_type]
  end

  def create(conn, params) do
    case Map.keys(params["fields"]) |> validate_fields() do
      :ok ->
        render conn, "index.html", fields: [platform: @platform, issue_type: @issue_type]
      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> render("index.html", fields: [platform: @platform, issue_type: @issue_type])
    end
  end

  defp validate_fields(fields) when is_list(fields) do
    @input_validate_fields
    |> Enum.reject(fn field ->
      Enum.member?(fields, field)
    end)
    |> invalid_error
  end

  defp invalid_error([]), do: :ok
  defp invalid_error(list) when is_list(list), do: {:error, ~s(Required => #{Enum.join(list, "/")})}
end
