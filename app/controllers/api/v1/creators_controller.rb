class Api::V1::CreatorsController < ApplicationController
    def index
        facade = CreatorFacade.index(Creator.all)
        render json: CreatorIndexSerializer.new(facade)
    end

    def show
        creator = Creator.find(params[:id])

        youtube = nil
        if creator.youtube_handle != nil
            youtube = YoutubeFacade.get_channel(creator.youtube_handle, params[:query])
        end

        twitch = nil
        #if creator.twitch_handle != nil
        #    twitch = TwitchFacade.get_channel(creator.twitch_handle, params[:query])
        #end

        twitter = nil
        #if creator.twitter_handle != nil
        #    twitter = TwitterFacade.get_channel(creator.twitter_handle, params[:query])
        #end

        package =  {'creator': creator, 
                    'youtube': youtube, 
                    'twitch': twitch, 
                    'twitter': twitter}

        facade = CreatorFacade.aggregate(package)
        render json: CreatorAggregationSerializer.new(facade)
    end
end