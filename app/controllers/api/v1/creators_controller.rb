class Api::V1::CreatorsController < ApplicationController
    def show
        creator = Creator.find(params[:id])

        youtube = nil
        if creator.youtubeId != nil
            youtube = YoutubeFacade.get_channel(creator.youtubeId, params[:query])
        end

        render json: CreatorSerializer.new(creator, youtube)
    end
end