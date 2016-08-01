defmodule Trelloish.PageController do
  use Trelloish.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
