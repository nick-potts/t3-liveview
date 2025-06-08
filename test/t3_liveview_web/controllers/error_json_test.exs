defmodule T3LiveviewWeb.ErrorJSONTest do
  use T3LiveviewWeb.ConnCase, async: true

  test "renders 404" do
    assert T3LiveviewWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert T3LiveviewWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
