module PostsHelper
	def toggle_like_button(post,loggedin_user)
		if @loggedin_user.flagged?(@post, :like)
			#link_to "Unlike", like_post_path(@post)
			link_to "Unlike", like_post_path(@post)
		else
			#link_to "Like", like_post_path(@post)
			link_to "Like", like_post_path(@post)
		end

	end	
end