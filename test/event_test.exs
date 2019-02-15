defmodule Stripe.EventTest do
  use ExUnit.Case, async: true

  alias Stripe.Event
  alias Stripe.InvalidRequestError

  test "retrieve an event" do
    assert {:error, %InvalidRequestError{message: "No such event: not exist"}} =
             Event.retrieve("not exist")
  end

  test "list all events" do
    assert {:ok, %{"object" => "list", "url" => "/v1/events"}} =
             Event.list()
  end
end
