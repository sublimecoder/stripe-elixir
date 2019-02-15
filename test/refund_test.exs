defmodule Stripe.RefundTest do
  use ExUnit.Case, async: true

  alias Stripe.{Token, Charge, Refund}
  alias Stripe.InvalidRequestError
  alias Stripe.Fixture.Token, as: TokenFixture

  test "create/update a refund" do
    {:ok, token} = TokenFixture.valid_card() |> Token.create()

    {:ok, charge} = Charge.create(amount: 1000, source: token["id"], currency: "usd")

    assert {:ok, %{"amount" => 1000} = refund} = Refund.create(charge: charge["id"])

    assert {:ok, %{"metadata" => %{"key" => "value"}}} =
             Refund.update(refund["id"], metadata: [key: "value"])
  end

  test "retrieve a refund" do
    assert {:error, %InvalidRequestError{message: "No such refund: not exist"}} =
             Refund.retrieve("not exist")
  end

  test "list all refunds" do
    assert {:ok, %{"object" => "list", "url" => "/v1/refunds"}} = Refund.list()
  end
end
