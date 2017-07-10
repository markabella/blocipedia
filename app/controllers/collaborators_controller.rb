class CollaboratorsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_wiki
    
      
   def index
     @collaborators = Collaborator.all
   end
   
   def show
     @collaborator = Collaborator.find(params[:id]) 
     if user_is_authorized_to_view_wiki?(@wiki)
        @collaborator = Collaborator.find(params[:id]) 
     else 
       flash[:alert] = "Unauthorized to view collaborator."
       redirect_to root_path
     end
   end
   
   def new
     @collaborator = Collaborator.new
   end  
   
   def create
     @collaborator = Collaborator.new(collaborator_params)
    # @collaborator = Collaborator.new #(collaborator_params)
    # @collaborator.email = user.email
    # @collaborator.wiki_id = @wiki_id

     if @collaborator.save
       flash[:notice] = "Collaborator was saved successfully."
        redirect_to :back, notice: "Collaborator was saved successfully."
     else
       flash.now[:alert] = "Error creating collaborator. Please try again."
       redirect_to :back
     end
   end

   def edit
     @collaborator = Collaborator.find(params[:id])
   end
   
   def update
     @collaborator = Collaborator.find(params[:id])

     #@collaborator.assign_attributes(collaborator_params)

     if @collaborator.private
         @collaborator.user = current_user
     end
 
     if @collaborator.save
        flash[:notice] = "Collaborator was updated."
       render :edit
     else
       flash.now[:alert] = "Error saving collaborator. Please try again."
       render :edit
     end
   end
   
   def destroy
      #@collaborator = Collaborator.where(wiki_id @wiki_id )
     #@collaborator = Collaborator.find(params[:id])
     @collaborator = Collaborator.find_by_wiki_id_and_email(params[:wiki_id], params[:email])
     
     if @collaborator != nil
         if @collaborator.destroy
           flash[:notice] = "\"#{@collaborator.email}\" was deleted successfully."
           redirect_to :back
         else
           flash.now[:alert] = "There was an error deleting the collaborator."
           redirect_to :back
         end
     end
   end 
     
   private
     
   def set_wiki
     @wiki = Wiki.find(params[:wiki_id])
   end
 
   def collaborator_params
     params.permit(:wiki_id, :email)
   end
   
   def authorize_user
     unless current_user.admin?
       flash[:alert] = "You must be an admin to do that."
       redirect_to collaborators_path
     end
   end
   
end