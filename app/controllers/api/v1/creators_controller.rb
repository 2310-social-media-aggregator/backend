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

    def update
        creator = Creator.find_by(id: params[:id])
        if creator != nil
            if creator.update(creator_params)
                render json: CreatorSerializer.new(creator), status: :ok
            else
                render json: ErrorSerializer.new(ErrorMessage.new("Update failed.", 500)), status: :internal_server_error
            end
        else
            render json: ErrorSerializer.new(ErrorMessage.new("Creator not found.", 404)), status: :not_found
        end
    end

    def delete
        creator = Creator.find_by(id: params[:id])
        if creator != nil
            if creator.destroy
                render json: CreatorSerializer.new(creator), status: :no_content
            else
                render json: ErrorSerializer.new(ErrorMessage.new("Delete failed.", 500)), status: :internal_server_error
            end
        else
            render json: ErrorSerializer.new(ErrorMessage.new("Creator not found.", 404)), status: :not_found
        end
    end

    private

    def creator_params
        params.permit(  :id, 
                        :name, 
                        :youtube_handle, 
                        :twitch_handle, 
                        :twitter_handle)
    end
end