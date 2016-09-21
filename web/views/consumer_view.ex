defmodule UserManager.ConsumerView do
  use UserManager.Web, :view

  def render("index.json", %{consumers: consumers}) do
    %{data: render_many(consumers, UserManager.ConsumerView, "consumer.json")}
  end

  def render("show.json", %{consumer: consumer}) do
    %{data: render_one(consumer, UserManager.ConsumerView, "consumer.json")}
  end

  def render("consumer.json", %{consumer: consumer}) do
    %{
      id: consumer.id,
      created_at: consumer.created_at,
      username: consumer.username
    }
  end
end
