class KittensController < ApplicationController

    def index
        @kittens = Kitten.all
        respond_to do |format|
            format.html
            format.json { render :json => @kittens }
        end
    end

    def new
        @kitten = Kitten.new
    end

    def create
        @kitten = Kitten.new(kitten_params)

        if @kitten.save
            flash[:success] = "A kitten was created!"
            redirect_to @kitten
        else
            flash[:error] = "A kitten was NOT created!"
            render 'edit'
        end
        
    end

    def edit
        @kitten = Kitten.find(params[:id])
    end
    
    def show 
        @kitten = Kitten.find(params[:id])
        respond_to :html, :json
    end

    def update
        @kitten = Kitten.find(params[:id])

        if @kitten.update(kitten_params)
          flash[:success] = "Kitten details were successfully updated"
          redirect_to @kitten
        else
          flash[:error] = "Something went wrong"
          render 'edit'
        end
    end

    def destroy
        @kitten = Kitten.find(params[:id])
        if @kitten.destroy
            flash[:success] = 'Kitten was successfully deleted.'
            redirect_to kittens_url
        else
            flash[:error] = 'Something went wrong'
            redirect_to kittens_url
        end
    end

    private

    def kitten_params
        params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
