defmodule Emailer do
  use Bamboo.Mailer, otp_app: :emailer

  import Bamboo.Email

  @moduledoc """
  Documentation for Emailer.
  """

  @sender "wol@annkissam.com"

  def send_pair_notification(people) do
    users = for person <- people do
      {person.name, person.email}
    end

    # users = [{"Adi Iyengar", "adi.iyengar@annkissam.com"}]

    names = Enum.reduce(people, "Hi ", &(&2 <> &1.name <> "& "))
      |> String.trim_trailing("& ")

    email = new_email(to: users)
      |> from(@sender)
      |> subject("[WHEEL OF LUNCH] Paired!")
      |> html_body("""
        #{names}:
        Great news! You two have been paired for a wheel of lunch! Have fun and don't forget to share
        your experience with us!

        -- Team Wheel of Lunch!
      """)
      |> Emailer.deliver_now
  end
end
