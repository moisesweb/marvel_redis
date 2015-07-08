require 'rails_helper'

describe DataStructures do
  context '.get' do
    it 'returns a Redis object as data structure provider' do
      data_structures = DataStructures.get
      expect(data_structures).to be_a(Redis)
    end
  end
end
