defmodule UserManager.ConsumerTest do

  use UserManager.ConnCase
  alias UserManager.Consumer
  alias UserManager.KongAdminRepo

  @consumer_json """
  {
    "data":
    [
    {
      "username":"test",
      "created_at":1472213294000,
      "id":"9da837d0-d100-4dd5-9e64-8f2c22f6cd63"
    },
    {
      "username":"raphaeqsdltest",
      "created_at":1472216888000,
      "id":"4b6259bf-7b0d-4565-b879-cb39b6ca0613"
    }
  ]
  """

  test "From raw structure to %Consumer struct" do
    consumer = KongAdminRepo.get(Consumer, "admin")
    assert "admin" = consumer.username
  end

  test "From raw consumers list to list of %Consumer.struct" do
    [first_consumer | _consumers] = KongAdminRepo.all(Consumer) 
    assert "testkjlkjcf" = first_consumer.username
  end

end
