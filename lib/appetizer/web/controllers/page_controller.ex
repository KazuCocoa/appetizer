defmodule Appetizer.Web.PageController do
  use Appetizer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
