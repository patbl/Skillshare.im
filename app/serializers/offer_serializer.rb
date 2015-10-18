class OfferSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :created_at, :url

  def url
    Rails.application.routes.url_helpers.offer_url(object)
  end
end
