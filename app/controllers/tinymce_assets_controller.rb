class TinymceAssetsController < ApplicationController
  def create
    tinyimage = TinymceImage.create!(image: params[:file], hint: params[:hint])

    render json: {
      image: {
        url: view_context.image_url(tinyimage.image)
      }
    }, content_type: "text/html"
  end
end
