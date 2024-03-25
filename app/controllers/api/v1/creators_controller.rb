class Api::V1::CreatorsController < ApplicationController
    def create
        if Creator.find_by(name: params[:name]) == nil
            creator = Creator.create(creator_params)
            if creator.save
                render json: CreatorSerializer.new(creator), status: :created
            else
                render json: ErrorSerializer.new(ErrorMessage.new("Save failed.", 500)), status: :internal_server_error
            end
        else
            render json: ErrorSerializer.new(ErrorMessage.new("Name taken.", 409)), status: :conflict
        end
    end

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
        if creator.twitch_handle != nil
            twitch = TwitchFacade.get_channel(creator.twitch_handle, params[:query])
        end

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

    private

    def creator_params
        #.require(:creator)
        params.permit(  :id, 
                        :name, 
                        :youtube_handle, 
                        :twitch_handle, 
                        :twitter_handle)
    end
end