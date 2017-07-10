class WikisController < ApplicationController
#   before_action :require_sign_in, except: [:index, :show]
#   before_action :authorize_user, except: [:index, :show]
    before_action :authenticate_user!, except: [:index, :show]
    
   def index
     @wikis = policy_scope(Wiki)
   end
   
   def show
     @wiki = Wiki.find(params[:id]) 
#     if user_is_authorized_to_view_wiki?(@wiki)
#        @wiki = Wiki.find(params[:id]) 
#     else 
#       flash[:alert] = "Unauthorized to view wiki."
#       redirect_to root_path
#     end
   end
   
   def new
     @wiki = Wiki.new
   end  
   
   def create
     @wiki = Wiki.new(wiki_params)
     @wiki.owner = current_user.email

     if @wiki.save
       redirect_to @wiki, notice: "Wiki was saved successfully."
     else
       flash.now[:alert] = "Error creating wiki. Please try again."
       render :new
     end
   end

   def edit
     @wiki = Wiki.find(params[:id])
     @users = User.all
     @collaborators = Collaborator.all
   end
   
   def update
     @wiki = Wiki.find(params[:id])

     @wiki.assign_attributes(wiki_params)

     if @wiki.private
         @wiki.owner = current_user.email
     end
 
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
   
   def user_is_authorized_to_view_wiki?(wiki)
    (wiki.private && (wiki.owner == current_user.email)) || !wiki.private || current_user.admin?
   end
   
   def authorize_user
     unless current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to wikis_path
     end
   end
   
end
