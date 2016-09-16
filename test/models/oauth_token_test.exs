defmodule SampleMicroservice.OauthTokenTest do
  use SampleMicroservice.ConnCase

  alias SampleMicroservice.OauthToken
  alias SampleMicroservice.KongAdminRepo

  test "defines a oauthtoken struct" do
    oauth_token= struct(OauthToken, %{refresh_token: "abcd", access_token: "defc"})  
    assert oauth_token.refresh_token    == "abcd"
    assert oauth_token.access_token     == "defc"
  end
end
