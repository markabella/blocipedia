module WikisHelper
    
   def user_is_authorized_to_view_wiki?(wiki, wiki_id, email)
     @collaborator = Collaborator.find_by_wiki_id_and_email(wiki_id, email)
     @collaborator || (wiki.private && (wiki.owner == current_user.email)) || !wiki.private || current_user.admin? 
   end
end
