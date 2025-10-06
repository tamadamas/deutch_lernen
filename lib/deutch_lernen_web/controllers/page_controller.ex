defmodule DeutchLernenWeb.PageController do
  use DeutchLernenWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
