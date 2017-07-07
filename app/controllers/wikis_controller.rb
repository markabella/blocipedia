class WikisController < ApplicationController
#   before_action :require_sign_in, except: [:index, :show]
#   before_action :authorize_user, except: [:index, :show]
    before_action :authenticate_user!, except: [:index, :show]
    
   def index
     @wikis = Wiki.all
   end
   
   def show
     @wiki = Wiki.find(params[:id])
   end
   
   def new
     @wiki = Wiki.new
   end  
   
   def create
     @wiki = Wiki.new(wiki_params)
 
     if @wiki.save
       redirect_to @wiki, notice: "Wiki was saved successfully."
     else
       flash.now[:alert] = "Error creating wiki. Please try again."
       render :new
     end
   end

   def edit
     @wiki = Wiki.find(params[:id])
   end
   
   def update
     @wiki = Wiki.find(params[:id])
 
     @wiki.assign_attributes(wiki_params)
 
     if @wiki.save
        flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash.now[:alert] = "Error saving wiki. Please try again."
       render :edit
     end
   end
   
   def destroy
     @wiki = Wiki.find(params[:id])
 
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to action: :index
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
   end
     
   private
 
   def wiki_params
     params.require(:wiki).permit(:title, :body, :private)
   end
   
   def authorize_user
     unless current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to wikis_path
     end
   end
end