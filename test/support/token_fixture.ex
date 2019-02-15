defmodule Stripe.Fixture.Token do
  def valid_card() do
    %{
      card: [
        number: "4242424242424242",
        exp_month: exp_month(),
        exp_year: exp_year(),
        cvc: "314"
      ]
    }
  end

  def invalid_card() do
    %{
      card: [
        number: "invalid card number",
        exp_month: exp_month(),
        exp_year: exp_year(),
        cvc: "314"
      ]
    }
  end

  def visa_debit_card() do
    %{
      card: [
        number: "4000056655665556",
        exp_month: exp_month(),
        exp_year: exp_year(),
        cvc: "314",
        currency: "usd"
      ]
    }
  end

  def master_card_debit_card() do
    %{
      card: [
        number: "5200828282828210",
        exp_month: exp_month(),
        exp_year: exp_year(),
        cvc: "314",
        currency: "usd"
      ]
    }
  end

  defp exp_month() do
    7
  end

  defp exp_year() do
    DateTime.utc_now().year + 1
  end
end
