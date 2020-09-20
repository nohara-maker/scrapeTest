require 'rails_helper'

RSpec.describe User, type: :model do
  it "姓、名を登録すると、姓名が取得できること" do
    user = User.new(last_name: "侍", first_name: "太郎")
    expect(user.full_name).to eq "侍 太郎"
  end
end
