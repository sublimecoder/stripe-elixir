defmodule Stripe.AccountTest do
  use ExUnit.Case
  alias Stripe.Fixture.Token, as: TokenFixture

  test "create/update/retrieve/delete an account" do
    assert {:ok, account} = Stripe.Account.create(type: "custom")
    assert {:ok, %{"email" => _email}} = Stripe.Account.retrieve(account["id"])

    assert {:ok, %{"metadata" => %{"test" => "data"}}} =
             Stripe.Account.update(account["id"], metadata: [test: "data"])

    assert {:ok, _} = Stripe.Account.delete(account["id"])
    assert {:error, _} = Stripe.Account.retrieve(account["id"])
  end

  test "list all accounts" do
    assert {:ok, %{"object" => "list", "url" => "/v1/accounts"}} = Stripe.Account.list()
  end

  test "create/update/retrieve/delete/list an external_account" do
    {:ok, account} = Stripe.Account.create(type: "custom")

    {:ok, token} = TokenFixture.visa_debit_card() |> Stripe.Token.create()
    {:ok, token2} = TokenFixture.master_card_debit_card() |> Stripe.Token.create()

    account_id = account["id"]

    assert {:ok, external_account} =
             Stripe.Account.create_external_account(account_id, external_account: token["id"])

    assert {:ok, external_account2} =
             Stripe.Account.create_external_account(account_id, external_account: token2["id"])

    url = "/v1/accounts/#{account_id}/external_accounts"

    assert {:ok, %{"object" => "list", "url" => ^url}} =
             Stripe.Account.list_external_account(account_id)

    external_account_id = external_account["id"]
    external_account_id2 = external_account2["id"]

    assert {:ok, ^external_account} =
             Stripe.Account.retrieve_external_account(account_id, external_account_id)

    assert {:ok, %{"metadata" => %{"test" => "data"}}} =
             Stripe.Account.update_external_account(account_id, external_account_id,
               metadata: [test: "data"]
             )

    assert {:ok, _} = Stripe.Account.delete_external_account(account_id, external_account_id2)

    assert {:error, _} =
             Stripe.Account.retrieve_external_account(account_id, external_account_id2)
  end
end
