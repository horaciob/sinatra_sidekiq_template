# frozen_string_literal: true

# == Schema Information
#
# Table name: merchants
#
#  id         :uuid             not null, primary key
#  reference  :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
RSpec.describe Merchant, type: :model do
  describe 'validations' do
    subject { build(:merchant) }
  end

  describe 'associations' do
  end
end
