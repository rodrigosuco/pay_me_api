require "test_helper"

class TransfersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transfer = transfers(:one)
  end

  test "should get index" do
    get transfers_url, as: :json
    assert_response :success
  end

  test "should create transfer" do
    assert_difference("Transfer.count") do
      post transfers_url, params: { transfer: { pagante_id: @transfer.pagante_id, recebedor_id: @transfer.recebedor_id, value: @transfer.value } }, as: :json
    end

    assert_response :created
  end

  test "should show transfer" do
    get transfer_url(@transfer), as: :json
    assert_response :success
  end

  test "should update transfer" do
    patch transfer_url(@transfer), params: { transfer: { pagante_id: @transfer.pagante_id, recebedor_id: @transfer.recebedor_id, value: @transfer.value } }, as: :json
    assert_response :success
  end

  test "should destroy transfer" do
    assert_difference("Transfer.count", -1) do
      delete transfer_url(@transfer), as: :json
    end

    assert_response :no_content
  end
end
