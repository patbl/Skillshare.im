require 'spec_helper'

shared_examples_for "Mappable" do
  let(:model) { described_class }

  describe "#mappable" do
    let(:mappable_item) { create(model.to_s.underscore.to_sym) }

    it "requires latitude and longitude" do
      mappable_item.update_columns(latitude: nil, longitude: nil)
      expect(model.mappable).to be_empty

      mappable_item.update_columns(latitude: 1.2)
      expect(model.mappable).to be_empty

      mappable_item.update_columns(longitude: 3.4)
      expect(described_class.mappable).to eq [mappable_item]
    end
  end
end
